//
//  BaseOfTheTimeAnimatonViewControllew.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/24.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "BaseOfTheTimeAnimatonViewControllew.h"

@interface BaseOfTheTimeAnimatonViewControllew ()

@property (nonatomic, strong) UIImageView *ballView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *timer1;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval timeOffset;
@property (nonatomic, assign) CFTimeInterval lastStep;

@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;


@end


@implementation BaseOfTheTimeAnimatonViewControllew

/*
 
 我们研究了CAMediaTimingFunction，它是一个通过控制动画缓冲来模拟物理效果例如加速或者减速来增强现实感的东西，那么如果想更加真实地模拟物理交互或者实时根据用户输入修改动画改怎么办呢？
 
 */
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    //add ball image view
    
    self.ballView = [[UIImageView alloc]initWithFrame:CGRectMake(150, 32, 60, 60)];
    self.ballView.backgroundColor = [UIColor redColor];
    self.ballView.layer.masksToBounds = YES;
    self.ballView.layer.cornerRadius = 30;
    
    [self.view addSubview:self.ballView];
    //animate
    [self animate];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //replay animation on tap
    [self animate];
}

float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [(NSValue *)fromValue objCType];
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

/*
- (void)animate
{
    //reset ball to top of screen
    //configure the animation
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    //stop the timer if it's already running
    [self.timer invalidate];
    //start the timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0
                                                  target:self
                                                selector:@selector(step:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)step:(NSTimer *)step
{
    //update time offset
    self.timeOffset = MIN(self.timeOffset + 1/60.0, self.duration);
    //get normalized time offset (in range 0 - 1)
    float time = self.timeOffset / self.duration;
    //apply easing
    time = bounceEaseOut(time);
    //interpolate position
    id position = [self interpolateFromValue:self.fromValue
                                     toValue:self.toValue
                                        time:time];
    //move ball view to new position
    self.ballView.center = [position CGPointValue];
    //stop the timer if we've reached the end of the animation
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

 */

/*
 
 很赞，而且和基于关键帧例子的代码一样很多，但是如果想一次性在屏幕上对很多东西做动画，很明显就会有很多问题。
 
 NSTimer并不是最佳方案，为了理解这点，我们需要确切地知道NSTimer是如何工作的。iOS上的每个线程都管理了一个NSRunloop，字面上看就是通过一个循环来完成一些任务列表。但是对主线程，这些任务包含如下几项：
 
    处理触摸事件
    发送和接受网络数据包
    执行使用gcd的代码
    处理计时器行为
    屏幕重绘

 当你设置一个NSTimer，他会被插入到当前任务列表中，然后直到指定时间过去之后才会被执行。但是何时启动定时器并没有一个时间上限，而且它只会在列表中上一个任务完成之后开始执行。这通常会导致有几毫秒的延迟，但是如果上一个任务过了很久才完成就会导致延迟很长一段时间。
 
 屏幕重绘的频率是一秒钟六十次，但是和定时器行为一样，如果列表中上一个执行了很长时间，它也会延迟。这些延迟都是一个随机值，于是就不能保证定时器精准地一秒钟执行六十次。有时候发生在屏幕重绘之后，这就会使得更新屏幕会有个延迟，看起来就是动画卡壳了。有时候定时器会在屏幕更新的时候执行两次，于是动画看起来就跳动了。
 
 我们可以通过一些途径来优化：
 
 我们可以用CADisplayLink让更新频率严格控制在每次屏幕刷新之后。
 基于真实帧的持续时间而不是假设的更新频率来做动画。
 调整动画计时器的run loop模式，这样就不会被别的事件干扰。
 
 */

#pragma -mark CADisplayLink

/*
 
 CADisplayLink是CoreAnimation提供的另一个类似于NSTimer的类，它总是在屏幕完成一次更新之前启动，它的接口设计的和NSTimer很类似，所以它实际上就是一个内置实现的替代，但是和timeInterval以秒为单位不同，CADisplayLink有一个整型的frameInterval属性，指定了间隔多少帧之后才执行。默认值是1，意味着每次屏幕更新之前都会执行一次。但是如果动画的代码执行起来超过了六十分之一秒，你可以指定frameInterval为2，就是说动画每隔一帧执行一次（一秒钟30帧）或者3，也就是一秒钟20次，等等。
 
 用CADisplayLink而不是NSTimer，会保证帧率足够连续，使得动画看起来更加平滑，但即使CADisplayLink也不能保证每一帧都按计划执行，一些失去控制的离散的任务或者事件（例如资源紧张的后台程序）可能会导致动画偶尔地丢帧。当使用NSTimer的时候，一旦有机会计时器就会开启，但是CADisplayLink却不一样：如果它丢失了帧，就会直接忽略它们，然后在下一次更新的时候接着运行。
 
 */

- (void)animate
{
    //reset ball to top of screen
    self.ballView.center = CGPointMake(150, 32);
    //configure the animation
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    //stop the timer if it's already running
    [self.timer invalidate];
    //start the timer
    self.lastStep = CACurrentMediaTime();
    self.timer1 = [CADisplayLink displayLinkWithTarget:self
                                             selector:@selector(step:)];
    [self.timer1 addToRunLoop:[NSRunLoop mainRunLoop]
                     forMode:NSDefaultRunLoopMode];
}

- (void)step:(CADisplayLink *)timer
{
    //calculate time delta
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    //update time offset
    self.timeOffset = MIN(self.timeOffset + stepDuration, self.duration);
    //get normalized time offset (in range 0 - 1)
    float time = self.timeOffset / self.duration;
    //apply easing
    time = bounceEaseOut(time);
    //interpolate position
    id position = [self interpolateFromValue:self.fromValue toValue:self.toValue
                                        time:time];
    //move ball view to new position
    self.ballView.center = [position CGPointValue];
    //stop the timer if we've reached the end of the animation
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

/*
 
 一些常见的run loop模式如下：
 
 NSDefaultRunLoopMode - 标准优先级
 NSRunLoopCommonModes - 高优先级
 UITrackingRunLoopMode - 用于UIScrollView和别的控件的动画
 
 
 self.timer = [NSTimer timerWithTimeInterval:1/60.0
 target:self
 selector:@selector(step:)
 userInfo:nil
 repeats:YES];
 [[NSRunLoop mainRunLoop] addTimer:self.timer
 forMode:NSRunLoopCommonModes];
 
 */



@end
