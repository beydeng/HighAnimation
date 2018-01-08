//
//  AnimationViewControllerOfXian.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/22.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "AnimationViewControllerOfXian.h"

@interface AnimationViewControllerOfXian ()


@property (strong,nonatomic) UIView *viewContent;
@property (strong,nonatomic) CAShapeLayer *layer;

@end

@implementation AnimationViewControllerOfXian

#pragma -mark 首先先来探讨下属性动画

//属性动画分为两种：基础和关键帧

#pragma -mark ###基础动画

/*
 
 动画其实就是一段时间内发生的改变，最简单的形式就是从一个值改变到另一个值，这也是CABasicAnimation最主要的功能。CABasicAnimation是CAPropertyAnimation的一个子类，而CAPropertyAnimation的父类是CAAnimation，CAAnimation同时也是Core Animation所有动画类型的抽象基类。作为一个抽象类，CAAnimation本身并没有做多少工作，它提供了一个计时函数（见第十章“缓冲”），一个委托（用于反馈动画状态）以及一个removedOnCompletion，用于标识动画是否该在结束后自动释放（默认YES，为了防止内存泄露）。CAAnimation同时实现了一些协议，包括CAAction（允许CAAnimation的子类可以提供图层行为），以及CAMediaTiming（第九章“图层时间”将会详细解释）。
 
 CAPropertyAnimation通过指定动画的keyPath作用于一个单一属性，CAAnimation通常应用于一个指定的CALayer，于是这里指的也就是一个图层的keyPath了。实际上它是一个关键路径（一些用点表示法可以在层级关系中指向任意嵌套的对象），而不仅仅是一个属性的名称，因为这意味着动画不仅可以作用于图层本身的属性，而且还包含了它的子成员的属性，甚至是一些虚拟的属性（后面会详细解释）。
 
 CABasicAnimation继承于CAPropertyAnimation，并添加了如下属性：
 
 id fromValue
 id toValue
 id byValue
 从命名就可以得到很好的解释：fromValue代表了动画开始之前属性的值，toValue代表了动画结束之后的值，byValue代表了动画执行过程中改变的值。
 
 通过组合这三个属性就可以有很多种方式来指定一个动画的过程。它们被定义成id类型而不是一些具体的类型是因为属性动画可以用作很多不同种的属性类型，包括数字类型，矢量，变换矩阵，甚至是颜色或者图片。
 
 id类型可以包含任意由NSObject派生的对象，但有时候你会希望对一些不直接从NSObject继承的属性类型做动画，这意味着你需要把这些值用一个对象来封装，或者强转成一个对象，就像某些功能和Objective-C对象类似的Core Foundation类型。但是如何从一个具体的数据类型转换成id看起来并不明显，一些普通的例子见表8.1。
 
 表8.1 用于CAPropertyAnimation的一些类型转换
 
        Type	Object Type	Code Example
        CGFloat	NSNumber	id obj = @(float);
        CGPoint	NSValue	id obj = [NSValue valueWithCGPoint:point);
        CGSize	NSValue	id obj = [NSValue valueWithCGSize:size);
        CGRect	NSValue	id obj = [NSValue valueWithCGRect:rect);
        CATransform3D	NSValue	id obj = [NSValue valueWithCATransform3D:transform);
        CGImageRef	id	id obj = (__bridge id)imageRef;
        CGColorRef	id	id obj = (__bridge id)colorRef;
        fromValue，toValue和byValue属性可以用很多种方式来组合，但为了防止冲突，不能一次性同时指定这三个值。例如，如果指定了fromValue等于2，toValue等于4，byValue等于3，那么Core Animation就不知道结果到底是4（toValue）还是5（fromValue + byValue）了。他们的用法在CABasicAnimation头文件中已经描述的很清楚了，所以在这里就不重复了。总的说来，就是只需要指定toValue或者byValue，剩下的值都可以通过上下文自动计算出来。
 
 */



-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewContent = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    self.viewContent.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.viewContent];
    
    
//    [self perFormTransition:self.viewContent];
    
    
    //自定义动画
    /*
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 210, 100, 20)];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"Change" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(perFormTransition) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];

    */
    
    
    
    /*
    self.layer = [CAShapeLayer layer];
    self.layer.frame = self.viewContent.bounds;
    
    self.layer.backgroundColor = [UIColor redColor].CGColor;
    
    [self.viewContent.layer addSublayer:self.layer];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 210, 100, 20)];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"Change" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeColor4) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    */
    
//    [self creatBezierAnimation];
 
//    [self animationGroup];
    
    
    
    
    
    
}

#pragma -mark 第一步

-(void)changeColor
{
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    [self.layer addAnimation:animation forKey:nil];
    
    //运行程序，结果有点差强人意，点击按钮，的确可以使图层动画过渡到一个新的颜色，然动画结束之后又立刻变回原始值。
    
    //这是因为动画并没有改变图层的模型，而只是呈现（第七章）。一旦动画结束并从图层上移除之后，图层就立刻恢复到之前定义的外观状态。我们从没改变过backgroundColor属性，所以图层就返回到原始的颜色。
    
    
}

#pragma -mark 修改第一步

/*
 
 把动画设置成一个图层的行为（然后通过改变属性值来启动动画）是到目前为止同步属性值和动画状态最简单的方式了，假设由于某些原因我们不能这么做（通常因为UIView关联的图层不能这么做动画），那么有两种可以更新属性值的方式：在动画开始之前或者动画结束之后。
 
 动画之前改变属性的值是最简单的办法，但这意味着我们不能使用fromValue这么好的特性了，而且要手动将fromValue设置成图层当前的值。
 
 于是在动画创建之前插入如下代码，就可以解决问题了
 
 animation.fromValue = (__bridge id)self.colorLayer.backgroundColor;
 self.colorLayer.backgroundColor = color.CGColor;

 这的确是可行的，但还是有些问题，如果这里已经正在进行一段动画，我们需要从呈现图层那里去获得fromValue，而不是模型图层。另外，由于这里的图层并不是UIView关联的图层，我们需要用CATransaction来禁用隐式动画行为，否则默认的图层行为会干扰我们的显式动画（实际上，显式动画通常会覆盖隐式动画，但在文章中并没有提到，所以为了安全最好这么做）
 
 */

-(void)changeColor1
{
    
    
    //create a new random color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //create a basic animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    //apply animation without snap-back
    [self applyBasicAnimation:animation toLayer:self.layer];
    
    
}

//修改动画立刻恢复到原始状态的一个可复用函数

- (void)applyBasicAnimation:(CABasicAnimation *)animation toLayer:(CALayer *)layer
{
    
    //set the from value (using presentation layer if available)
    animation.fromValue = [(layer.presentationLayer ? layer.presentationLayer : layer) valueForKeyPath:animation.keyPath];
    //update the property in advance
    //note: this approach will only work if toValue != nil
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [layer setValue:animation.toValue forKeyPath:animation.keyPath];
    [CATransaction commit];
    //apply animation to layer
    [layer addAnimation:animation forKey:nil];
}

#pragma -mark ###CAAnimationDelegate

/*
在第七章使用隐式动画的时候，我们可以在CATransaction完成块中检测到动画的完成。但是这种方式并不适用于显式动画，因为这里的动画和事务并没太多关联。

那么为了知道一个显式动画在何时结束，我们需要使用一个实现了CAAnimationDelegate协议的delegate。

CAAnimationDelegate在任何头文件中都找不到，但是可以在CAAnimation头文件或者苹果开发者文档中找到相关函数。在这个例子中，我们用-animationDidStop:finished:方法在动画结束之后来更新图层的backgroundColor。

当更新属性的时候，我们需要设置一个新的事务，并且禁用图层行为。否则动画会发生两次，一个是因为显式的CABasicAnimation，另一次是因为隐式动画，
*/

-(void)changeColor3
{
    //create a new random color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //create a basic animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    animation.delegate = self;
    //apply animation to layer
    [self.layer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    //set the backgroundColor property to match animation toValue
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.layer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

#pragma -mark ###关键帧动画
/*
 CABasicAnimation揭示了大多数隐式动画背后依赖的机制，这的确很有趣，但是显式地给图层添加CABasicAnimation相较于隐式动画而言，只能说费力不讨好。
 */

- (void)changeColor4
{
    //create a keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //apply animation to layer
    [self.layer addAnimation:animation forKey:nil];
}

#pragma -mark 贝塞尔曲线对图层做动画

-(void)creatBezierAnimation{
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc]init];
    //起始点
    [bezierPath moveToPoint:CGPointMake(50, 250)];
    
    //第一个点是被塞尔曲线的最后一个点
    //第二个点是滴二个点的最高点
    //第三个点是第三个点的最低点
    [bezierPath addCurveToPoint:CGPointMake(250, 250) controlPoint1:CGPointMake(100, 150) controlPoint2:CGPointMake(200, 350)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 2.0f;
    [self.viewContent.layer addSublayer:pathLayer];
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.frame = CGRectMake(0, 0, 64, 64);
    layer1.position = CGPointMake(50, 250);
    layer1.contents = (__bridge id)[UIImage imageNamed:@"hen"].CGImage;
    [self.viewContent.layer addSublayer:layer1];
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    //并且给CAKeyFrameAnimation添加了一个rotationMode的属性。设置它为常量kCAAnimationRotateAuto，图层将会根据曲线的切线自动旋转
    [layer1 addAnimation:animation forKey:nil];
    
}

#pragma -mark ##动画组

//CABasicAnimation和CAKeyframeAnimation仅仅作用于单独的属性，而CAAnimationGroup可以把这些动画组合在一起。CAAnimationGroup是另一个继承于CAAnimation的子类，它添加了一个animations数组的属性，用来组合别的动画


-(void)animationGroup
{
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.viewContent.layer addSublayer:pathLayer];
    //add a colored layer
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.viewContent.layer addSublayer:colorLayer];
    //create the position animation
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    //create the color animation
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    //create group animation
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    groupAnimation.repeatCount = MAXFLOAT;
    //add the animation to the color layer
    [colorLayer addAnimation:groupAnimation forKey:nil];
    
}

#pragma -mark 过度动画

/*
 
 有时候对于iOS应用程序来说，希望能通过属性动画来对比较难做动画的布局进行一些改变。比如交换一段文本和图片，或者用一段网格视图来替换，等等。属性动画只对图层的可动画属性起作用，所以如果要改变一个不能动画的属性（比如图片），或者从层级关系中添加或者移除图层，属性动画将不起作用。
 
 于是就有了过渡的概念。过渡并不像属性动画那样平滑地在两个值之间做动画，而是影响到整个图层的变化。过渡动画首先展示之前的图层外观，然后通过一个交换过渡到新的外观。
 
 为了创建一个过渡动画，我们将使用CATransition，同样是另一个CAAnimation的子类，和别的子类不同，CATransition有一个type和subtype来标识变换效果。type属性是一个NSString类型，可以被设置成如下类型：
 
 kCATransitionFade
 kCATransitionMoveIn
 kCATransitionPush
 kCATransitionReveal
 
 后面三种过渡类型都有一个默认的动画方向，它们都从左侧滑入，但是你可以通过subtype来控制它们的方向，提供了如下四种类型：
 kCATransitionFromRight
 kCATransitionFromLeft
 kCATransitionFromTop
 kCATransitionFromBottom

 
*/
 
-(void)animationOfGuodu
{
    
    //这段代码不一定能正确运行，旨在告诉这个动画的使用情况
    
    NSArray *images = @[[UIImage imageNamed:@"Anchor.png"],
                    [UIImage imageNamed:@"Cone.png"],
                    [UIImage imageNamed:@"Igloo.png"],
                    [UIImage imageNamed:@"Spaceship.png"]];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    //apply transition to imageview backing layer
    [self.viewContent.layer addAnimation:transition forKey:nil];
    //cycle to next image
    UIImage *currentImage = (UIImage *)self.viewContent.layer.contents;
    NSUInteger index = [images indexOfObject:currentImage];
    index = (index + 1) % [images count];
    self.viewContent.layer.contents = images[index];
    
}

#pragma -mark ###对图层树的动画

-(void)animationOfYinsiGuodu
{
    
    //从appDelegate里的 UITabBarController理解下

    
}

#pragma -mark 创建自定义动画

/*
 
 但这并不意味着在iOS上就不能实现自定义的过渡效果了。这只是意味着你需要做一些额外的工作。就像之前提到的那样，过渡动画做基础的原则就是对原始的图层外观截图，然后添加一段动画，平滑过渡到图层改变之后那个截图的效果。如果我们知道如何对图层截图，我们就可以使用属性动画来代替CATransition或者是UIKit的过渡方法来实现动画。
 
 事实证明，对图层做截图还是很简单的。CALayer有一个-renderInContext:方法，可以通过把它绘制到Core Graphics的上下文中捕获当前内容的图片，然后在另外的视图中显示出来。如果我们把这个截屏视图置于原始视图之上，就可以遮住真实视图的所有变化，于是重新创建了一个简单的过渡效果。
 
 */
 

-(void)perFormTransition
{
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext
    () ];
    
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    
    [self.view addSubview:coverView];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //perform animation (anything you like)
    [UIView animateWithDuration:1.0 animations:^{
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        //remove the cover view now we're finished with it
        [coverView removeFromSuperview];
    }];
    
    
}





@end
