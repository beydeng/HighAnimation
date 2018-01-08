//
//  AnimationViewControllerOfYin.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/22.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "AnimationViewControllerOfYin.h"


@interface AnimationViewControllerOfYin ()

@property (nonatomic,strong) UIView *viewContent;
@property (nonatomic,strong) UIButton *buttonChange;
@property (nonatomic, strong) CAShapeLayer *colorLayer;

@end

@implementation AnimationViewControllerOfYin

-(void)viewDidLoad
{
    
    self.viewContent = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    [self.view addSubview:self.viewContent];
    
//    self.colorLayer = [CAShapeLayer layer];
//    self.colorLayer.frame = CGRectMake(25, 25, 50, 50);
//    self.colorLayer.backgroundColor = [UIColor grayColor].CGColor;
//    [self.viewContent.layer addSublayer:self.colorLayer];
    
    [self actionGuodu];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 210, 100, 20)];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"Change" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeColor2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
#pragma -mark 事务
    //Core Animation基于一个假设，说屏幕上的任何东西都可以（或者可能）做动画。你并不需要在Core Animation中手动打开动画，但是你需要明确地关闭它，否则它会一直存在。
    
    //当你改变CALayer一个可做动画的属性时，这个改变并不会立刻在屏幕上体现出来。相反，该属性会从先前的值平滑过渡到新的值。这一切都是默认的行为，你不需要做额外的操作。
    
    //这其实就是所谓的隐式动画。之所以叫隐式是因为我们并没有指定任何动画的类型。我们仅仅改变了一个属性，然后Core Animation来决定如何并且何时去做动画
    
    //但当你改变一个属性，Core Animation是如何判断动画类型和持续时间的呢？实际上动画执行的时间取决于当前事务的设置，动画类型取决于图层行为。
    
    //事务实际上是Core Animation用来包含一系列属性动画集合的机制，任何用指定事务去改变可以做动画的图层属性都不会立刻发生变化，而是当事务一旦提交的时候开始用一个动画过渡到新值。
    
    /*
    事务是通过CATransaction类来做管理，这个类的设计有些奇怪，不像你从它的命名预期的那样去管理一个简单的事务，而是管理了一叠你不能访问的事务。CATransaction没有属性或者实例方法，并且也不能用+alloc和-init方法创建它。而是用类方法+begin和+commit分别来入栈或者出栈。
    
    任何可以做动画的图层属性都会被添加到栈顶的事务，你可以通过+setAnimationDuration:方法设置当前事务的动画时间，或者通过+animationDuration方法来获取时长值（默认0.25秒）。
    
    Core Animation在每个run loop周期中自动开始一次新的事务（run loop是iOS负责收集用户输入，处理未完成的定时器或者网络事件，最终重新绘制屏幕的东西），即使你不显式地使用[CATransaction begin]开始一次事务，在一个特定run loop循环中的任何属性的变化都会被收集起来，然后做一次0.25秒的动画。
    
    明白这些之后，我们就可以轻松修改变色动画的时间了。我们当然可以用当前事务的+setAnimationDuration:方法来修改动画时间，但在这里我们首先起一个新的事务，于是修改时间就不会有别的副作用。因为修改当前事务的时间可能会导致同一时刻别的动画（如屏幕旋转），所以最好还是在调整动画之前压入一个新的事务。
    */
    
}

- (void)changeColor
{
    //randomize the layer background color
    
    //add
    //change time of animation
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    [CATransaction commit];

}

#pragma -mark ##完成块

-(void)changeSomeThing
{
    //基于UIView的block的动画允许你在动画结束的时候提供一个完成的动作。CATranscation接口提供的+setCompletionBlock:方法也有同样的功能。我们来调整上个例子，在颜色变化结束之后执行一些操作。我们来添加一个完成之后的block，用来在每次颜色变化结束之后切换到另一个旋转90的动画。
    
    //begin a new transaction
    [CATransaction begin];
    //set the animation duration to 1 second
    [CATransaction setAnimationDuration:1.0];
    //add the spin animation on completion
    [CATransaction setCompletionBlock:^{
        //rotate the layer 90 degrees
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    //commit the transaction
    [CATransaction commit];
    
    //注意旋转动画要比颜色渐变快得多，这是因为完成块是在颜色渐变的事务提交并出栈之后才被执行，于是，用默认的事务做变换，默认的时间也就变成了0.25秒
    
}


#pragma -mark ##图层行为

//现在来做个实验，试着直接对UIView关联的图层做动画而不是一个单独的图层。清单7.4是对清单7.2代码的一点修改，移除了colorLayer，并且直接设置layerView关联图层的背景色。

- (void)changeColorToViewLayer
{
    
    //begin a new transaction
    [CATransaction begin];
    //set the animation duration to 1 second
    [CATransaction setAnimationDuration:1.0];
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.viewContent.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    //commit the transaction
    [CATransaction commit];
    
    //运行程序，你会发现当按下按钮，图层颜色瞬间切换到新的值，而不是之前平滑过渡的动画。发生了什么呢？隐式动画好像被UIView关联图层给禁用了。
    
    /*
     
     试想一下，如果UIView的属性都有动画特性的话，那么无论在什么时候修改它，我们都应该能注意到的。所以，如果说UIKit建立在Core Animation（默认对所有东西都做动画）之上，那么隐式动画是如何被UIKit禁用掉呢？
     
     我们知道Core Animation通常对CALayer的所有属性（可动画的属性）做动画，但是UIView把它关联的图层的这个特性关闭了。为了更好说明这一点，我们需要知道隐式动画是如何实现的。
     
     我们把改变属性时CALayer自动应用的动画称作行为，当CALayer的属性被修改时候，它会调用-actionForKey:方法，传递属性的名称。剩下的操作都在CALayer的头文件中有详细的说明，实质上是如下几步：
     1 图层首先检测它是否有委托，并且是否实现CALayerDelegate协议指定的-actionForLayer:forKey方法。如果有，直接调用并返回结果。
     2 如果没有委托，或者委托没有实现-actionForLayer:forKey方法，图层接着检查包含属性名称对应行为映射的actions字典。
     3 如果actions字典没有包含对应的属性，那么图层接着在它的style字典接着搜索属性名。
     4 最后，如果在style里面也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的-defaultActionForKey:方法。
     所以一轮完整的搜索结束之后，-actionForKey:要么返回空（这种情况下将不会有动画发生），要么是CAAction协议对应的对象，最后CALayer拿这个结果去对先前和当前的值做动画。
     
     于是这就解释了UIKit是如何禁用隐式动画的：每个UIView对它关联的图层都扮演了一个委托，并且提供了-actionForLayer:forKey的实现方法。当不在一个动画块的实现中，UIView对所有图层行为返回nil，但是在动画block范围之内，它就返回了一个非空值
     
     */
    
#pragma -mark --==--总结
    //当属性在动画块之外发生改变，UIView直接通过返回nil来禁用隐式动画。但如果在动画块范围之内，根据动画具体类型返回相应的属性，在这个例子就是CABasicAnimation
    //当然返回nil并不是禁用隐式动画唯一的办法，CATransaction有个方法叫做+setDisableActions:，可以用来对所有属性打开或者关闭隐式动画。如果[CATransaction begin]之后添加下面的代码，同样也会阻止动画的发生：
   // [CATransaction setDisableActions:YES];
    
}

-(void)actionGuodu
{
   //行为通常是一个被Core Animation隐式调用的显式动画对象。这里我们使用的是一个实现了CATransition的实例，叫做推进过渡。
    //知道CATransition响应CAAction协议，并且可以当做一个图层行为就足够了
    
    self.colorLayer = [CAShapeLayer layer];
    self.colorLayer.frame = CGRectMake(25.0f, 25.0f, 50.0f, 50.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add a custom action
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor": transition};
    //add it to our view
    [self.viewContent.layer addSublayer:self.colorLayer];
    
}

- (void)changeColor2
{
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}

#pragma -mark ##呈现与模型

@end
