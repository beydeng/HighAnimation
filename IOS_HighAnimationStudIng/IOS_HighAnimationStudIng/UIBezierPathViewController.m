//
//  UIBezierPathViewController.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/6/23.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "UIBezierPathViewController.h"

@interface UIBezierPathViewController ()
{
    int i;
    NSTimer *time;
}
@property (nonatomic,assign) NSString *keyPath;
@property (nonatomic,strong) CAShapeLayer *layer;

@end


@implementation UIBezierPathViewController


-(void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = @[@"beginAnimation"];
    
    for (int ii =0; ii<arr.count; ii++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100*(ii+1), 50, 100, 30)];
//        button.titleLabel.textColor = [UIColor blackColor];
        [button setTitle:arr[0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor redColor].CGColor;
        button.layer.borderWidth = 1.0f;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [button addTarget:self action:@selector(actionOfAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
    
        
}

-(void)layer1
{
    
    CAShapeLayer *myShapeLayer = [[CAShapeLayer alloc]init];
    myShapeLayer.frame = CGRectMake(15, 200, 200, 200);
    
    myShapeLayer.fillColor = [UIColor clearColor].CGColor;
    myShapeLayer.strokeColor = [UIColor redColor].CGColor;
    myShapeLayer.lineWidth = 2.0f;
    [self.view.layer addSublayer:myShapeLayer];
    
    myShapeLayer.path = [self patheOfBezier1].CGPath;
    
    self.layer = myShapeLayer;
    
}


-(UIBezierPath *)patheOfBezier2
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 80, 80)];

    return path;
}


-(UIBezierPath *)patheOfBezier
{
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 100, 100) cornerRadius:10.0f];

//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 80, 80)];
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(17, 42)];
    [path addLineToPoint:CGPointMake(100, 42)];
    [path addLineToPoint:CGPointMake(100/2+77/2-17,150+42)];
    [path addLineToPoint:CGPointMake(17, 150+42)];
    [path addLineToPoint:CGPointMake(17, 42)];
    [path closePath];
    
    return path;
    
}
-(UIBezierPath *)patheOfBezier1
{
    
    UIBezierPath *pathSeller = [[UIBezierPath alloc]init];
    [pathSeller moveToPoint:CGPointMake(17, 42)];
    [pathSeller addLineToPoint:CGPointMake(100, 42)];
    [pathSeller addLineToPoint:CGPointMake(100,150+42)];
    [pathSeller addLineToPoint:CGPointMake(77/2+17,150+42)];
    [pathSeller addLineToPoint:CGPointMake(17, 42)];
    [pathSeller closePath];
    
    return pathSeller;
    
}


-(void)animation1:(CAShapeLayer *)layer type:(int)ii
{
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation.fromValue = @0;
//    animation.toValue = @1;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];

    animation.removedOnCompletion = NO;
    
    if (ii==0) {
        animation.fromValue = (__bridge id _Nullable)([self patheOfBezier].CGPath);
        animation.toValue = (__bridge id _Nullable)([self patheOfBezier1].CGPath);
    }
    else
    {
        animation.fromValue = (__bridge id _Nullable)([self patheOfBezier1].CGPath);
        animation.toValue = (__bridge id _Nullable)([self patheOfBezier].CGPath);
    }
    
    animation.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.duration = 2.0;
//    animation.repeatCount = MAX_CANON;
    
    [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    
    if ([self.keyPath isEqualToString:@"strokeEndAnimation" ]) {
        self.keyPath = @"strokeEndAnimation";
    }
    
}

-(void)removeAnimation:(CAShapeLayer *)layer{
    
    if (self.keyPath.length>0) {
        
        [layer removeAnimationForKey:self.keyPath];

    }
    
}

-(void)actionOfAnimation:(UIButton *)sender
{
    
    if (sender.selected) {
        [sender setTitle:@"beginAnimation" forState:UIControlStateNormal];
        
        [self removeAnimation:self.layer];

        if ([time isValid]) {
            
            [time invalidate];
            time = nil;
            
        }
        
    }
    else
    {
        if (!self.layer) {
            [self layer1];
        }
        
//        if (![time isValid]) {
//            [self timerToGo];
//        }
        
        [self animation2];
        
        [sender setTitle:@"endAnimation" forState:UIControlStateNormal];
        
    }
    
    sender.selected = sender.selected?NO:YES;
    
}

-(void)timerToGo
{
    
    time = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(animation) userInfo:nil repeats:YES];
    i = 0;
    
}

-(void)animation
{
    
    i++;
    NSLog(@"==--==%d",i);
    if (i%2==0) {
        [self animation1:self.layer type:0];
    }
    else
    {
        [self animation1:self.layer type:1];
    }
    
}

-(void)animation2
{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 80, 80)];
    self.layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    CGFloat value = arc4random()%100/100.0f;
//    CGFloat value1 = arc4random()%100/100.0f;

    animation.removedOnCompletion = NO;

    animation.fromValue = @0;
    animation.toValue = @1;
//    self.layer.strokeColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:arc4random()%255/255.0f].CGColor;
    animation.repeatCount = MAX_CANON;
    animation.duration = 3.0f;
//    [self.layer addAnimation:animation forKey:@"strokeEnd"];
    
    CABasicAnimation *animationColor = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    
    animationColor.removedOnCompletion = NO;

    animationColor.toValue = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:arc4random()%255/255.0f];
    animationColor.repeatCount = MAX_CANON;
    animationColor.duration = 3.0f;

//    [self.layer addAnimation:animation forKey:@"strokeColor"];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation,animationColor];
    
    [self.layer addAnimation:group forKey:@"groupAnimation"];
    
}


@end
