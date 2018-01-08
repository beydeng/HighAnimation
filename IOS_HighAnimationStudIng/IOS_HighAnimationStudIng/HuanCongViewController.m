//
//  HuanCongViewController.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/23.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "HuanCongViewController.h"

@interface HuanCongViewController ()

@property (nonatomic,strong) CAShapeLayer *colorLayer;
@property (nonatomic,strong) CAShapeLayer *shapeQiuQiu;

@end




@implementation HuanCongViewController

#pragma -mark 缓冲

#pragma -mark ##动画速度

/*
 
 动画实际上就是一段时间内的变化，这就暗示了变化一定是随着某个特定的速率进行。速率由以下公式计算而来：
 
 velocity = change / time

这里的变化可以指的是一个物体移动的距离，时间指动画持续的时长，用这样的一个移动可以更加形象的描述（比如position和bounds属性的动画），但实际上它应用于任意可以做动画的属性（比如color和opacity）。
 
 */

#pragma -mark ###CAMediaTimingFunction

/*
 那么该如何使用缓冲方程式呢？首先需要设置CAAnimation的timingFunction属性，是CAMediaTimingFunction类的一个对象。如果想改变隐式动画的计时函数，同样也可以使用CATransaction的+setAnimationTimingFunction:方法
 
 这里有一些方式来创建CAMediaTimingFunction，最简单的方式是调用+timingFunctionWithName:的构造方法。这里传入如下几个常量之一：
 
 kCAMediaTimingFunctionLinear
 kCAMediaTimingFunctionEaseIn
 kCAMediaTimingFunctionEaseOut
 kCAMediaTimingFunctionEaseInEaseOut
 kCAMediaTimingFunctionDefault
 
 kCAMediaTimingFunctionLinear选项创建了一个线性的计时函数，同样也是CAAnimation的timingFunction属性为空时候的默认函数。线性步调对于那些立即加速并且保持匀速到达终点的场景会有意义（例如射出枪膛的子弹），但是默认来说它看起来很奇怪，因为对大多数的动画来说确实很少用到。
 
 kCAMediaTimingFunctionEaseIn常量创建了一个慢慢加速然后突然停止的方法。对于之前提到的自由落体的例子来说很适合，或者比如对准一个目标的导弹的发射。
 
 kCAMediaTimingFunctionEaseOut则恰恰相反，它以一个全速开始，然后慢慢减速停止。它有一个削弱的效果，应用的场景比如一扇门慢慢地关上，而不是砰地一声。
 
 kCAMediaTimingFunctionEaseInEaseOut创建了一个慢慢加速然后再慢慢减速的过程。这是现实世界大多数物体移动的方式，也是大多数动画来说最好的选择。如果只可以用一种缓冲函数的话，那就必须是它了。那么你会疑惑为什么这不是默认的选择，实际上当使用UIView的动画方法时，他的确是默认的，但当创建CAAnimation的时候，就需要手动设置它了。
 
 最后还有一个kCAMediaTimingFunctionDefault，它和kCAMediaTimingFunctionEaseInEaseOut很类似，但是加速和减速的过程都稍微有些慢。它和kCAMediaTimingFunctionEaseInEaseOut的区别很难察觉，可能是苹果觉得它对于隐式动画来说更适合（然后对UIKit就改变了想法，而是使用kCAMediaTimingFunctionEaseInEaseOut作为默认效果），虽然它的名字说是默认的，但还是要记住当创建显式的CAAnimation它并不是默认选项（换句话说，默认的图层行为动画用kCAMediaTimingFunctionDefault作为它们的计时方法）。
 
 */

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
//    [self cesiDemo];
    
//    [self changeSome];
    
//    [self cAMediaTimingFunction];
    
    [self theQiuQiuAnimation];
    
}

-(void)cesiDemo{
    
    self.colorLayer = [CAShapeLayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
    
}
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //configure the transaction
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    //set the position
    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    //commit transaction
    [CATransaction commit];
}
*/
#pragma -mark ###UIView的动画缓冲
/*
 
 UIKit的动画也同样支持这些缓冲方法的使用，尽管语法和常量有些不同，为了改变UIView动画的缓冲选项，给options参数添加如下常量之一：
 
    UIViewAnimationOptionCurveEaseInOut
    UIViewAnimationOptionCurveEaseIn
    UIViewAnimationOptionCurveEaseOut
    UIViewAnimationOptionCurveLinear
 
 它们和CAMediaTimingFunction紧密关联，UIViewAnimationOptionCurveEaseInOut是默认值（这里没有kCAMediaTimingFunctionDefault相对应的值了）
 
 */

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //perform the animation
//    [UIView animateWithDuration:1.0 delay:0.0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         //set the position
//                         self.colorView.center = [[touches anyObject] locationInView:self.view];
//                     }
//                     completion:NULL];
//    
//}

#pragma -mark ###缓冲和关键帧动画

/*
 
 CAKeyframeAnimation有一个NSArray类型的timingFunctions属性，我们可以用它来对每次动画的步骤指定不同的计时函数。但是指定函数的个数一定要等于keyframes数组的元素个数减一，因为它是描述每一帧之间动画速度的函数。
 
 
 */
-(void)changeSome
{
    //create sublayer
    self.colorLayer = [CAShapeLayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 250.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.view.layer addSublayer:self.colorLayer];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 350, 100, 20)];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"Change" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
}

- (void)changeColor
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
    //add timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = @[fn, fn, fn];
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
}

#pragma -mark ##自定义缓冲函数

/*
 
 除了+functionWithName:之外，CAMediaTimingFunction同样有另一个构造函数，一个有四个浮点参数的+functionWithControlPoints::::
 
 CAMediaTimingFunction函数的主要原则在于它把输入的时间转换成起点和终点之间成比例的改变。我们可以用一个简单的图标来解释，横轴代表时间，纵轴代表改变的量，于是线性的缓冲就是一条从起点开始的简单的斜线
 CAMediaTimingFunction使用了一个叫做三次贝塞尔曲线的函数，它只可以产出指定缓冲函数的子集
 CAMediaTimingFunction有一个叫做-getControlPointAtIndex:values:的方法，可以用来检索曲线的点
 
 */

-(void)cAMediaTimingFunction
{
    
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CGPoint controlPoint1,controlPoint2;
    
    [function getControlPointAtIndex:1 values:(float *)&controlPoint1];
    [function getControlPointAtIndex:2 values:(float *)&controlPoint2];

    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1) controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 2.0f;
    layer.path = path.CGPath;
    
    [self.view.layer addSublayer:layer];
    self.view.layer.geometryFlipped = YES;
    
}

/*
 
 那么对于我们自定义时钟指针的缓冲函数来说，我们需要初始微弱，然后迅速上升，最后缓冲到终点的曲线，通过一些实验之后，最终结果如下
 
 
 */

- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated
{
    
    //generate transform
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        //create transform animation
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform";
        animation.fromValue = [handView.layer.presentationLayer valueForKey:@"transform"];
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
        //apply animation
        handView.layer.transform = transform;
        [handView.layer addAnimation:animation forKey:nil];
    } else {
        handView.layer.transform = transform;
    }
    
}

#pragma -mark 一个小球下落的缓冲列子

/*
 
 这种效果没法用一个简单的三次贝塞尔曲线表示，于是不能用CAMediaTimingFunction来完成。但如果想要实现这样的效果，可以用如下几种方法：
 
 用CAKeyframeAnimation创建一个动画，然后分割成几个步骤，每个小步骤使用自己的计时函数（具体下节介绍）。
 使用定时器逐帧更新实现动画。
 
 */

#pragma -mark 基于关键帧的缓冲

-(void)theQiuQiuAnimation
{
    
    self.shapeQiuQiu = [CAShapeLayer layer];
    self.shapeQiuQiu.backgroundColor = [UIColor redColor].CGColor;
    self.shapeQiuQiu.frame = CGRectMake(150, 32, 60, 60);
    self.shapeQiuQiu.masksToBounds = YES;
    self.shapeQiuQiu.cornerRadius =30;
    [self.view.layer addSublayer:self.shapeQiuQiu];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self animate1];
}
-(void)animation{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 32)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 140)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 220)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 250)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)]
                         ];
    
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                                  ];
    
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    //apply animation
    self.shapeQiuQiu.position = CGPointMake(150, 268);
    [self.shapeQiuQiu addAnimation:animation forKey:nil];
    
}

#pragma -mark 流程自动化

/*
 
 为了实现自动化，我们需要知道如何做如下两件事情：
 
 自动把任意属性动画分割成多个关键帧
 用一个数学函数表示弹性动画，使得可以对帧做便宜
 为了解决第一个问题，我们需要复制Core Animation的插值机制。这是一个传入起点和终点，然后在这两个点之间指定时间点产出一个新点的机制
 
 */

/*

float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}

- (void)animate1
{
    //reset ball to top of screen
    //set up animation parameters
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    CFTimeInterval duration = 1.0;
    //generate keyframes
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++) {
        float time = 1/(float)numFrames * i;
        //apply easing
        time = bounceEaseOut(time);
        //add keyframe
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
    }
    //create keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = frames;
    //apply animation
    self.shapeQiuQiu.position = CGPointMake(150, 268);

    [self.shapeQiuQiu addAnimation:animation forKey:nil];
}

*/

@end
