//
//  TheViewOfSomeThing.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/18.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "TheViewOfSomeThing.h"

// 1秒6度(秒针)

#define perSecondA 6

// 1分钟6度(分针)

#define perMintueA 6

// 1小时30度（时针）

#define perHourA 30

// 每分钟时针转(30 / 60 °)

#define perMinHourA 0.5

#define angle2radion(angle) ((angle) / 180.0 * M_PI)


@interface TheViewOfSomeThing ()
{
    CGFloat secsAngle;
}
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic,strong) CALayer *layerShi,*layerfen,*layermiao;
@property (nonatomic,strong) UIView *viewBiao;

@end



@implementation TheViewOfSomeThing

-(void)viewDidLoad
{
    
    UIImage *imageWatch = [UIImage imageNamed:@"biaopan"];
    
    UIView *viewWatch = [[UIView alloc]initWithFrame:CGRectMake(40, 100, 200, 200)];
    viewWatch.backgroundColor = [UIColor clearColor];
    
    [self addImage:imageWatch toLayer:viewWatch.layer];
    
    [self.view addSubview:viewWatch];
    
    self.viewBiao = viewWatch;
    
    CALayer *layerShi = [CALayer layer];

//    layerShi.frame = CGRectMake(60,25, 100, 100);
//    [self addImage:[UIImage imageNamed:@"shi1"] toLayer:layerShi];
//    [viewWatch.layer addSublayer:layerShi];
    
    CALayer *layerfen = [CALayer layer];
    
    CALayer *layermiao = [CALayer layer];
    
    
    [self changeAnchorPoint:layerShi];
    [self changeAnchorPoint:layerfen];
    [self changeAnchorPoint:layermiao];

    
    [self initThePosionLayer:layerShi superView:viewWatch image:[UIImage imageNamed:@"shi1"]];
    
    [self initThePosionLayer:layerfen superView:viewWatch image:[UIImage imageNamed:@"fen2"]];
    
    [self initThePosionLayer:layermiao superView:viewWatch image:[UIImage imageNamed:@"miao2"]];
    
    self.layerShi = layerShi;
    
    self.layerfen = layerfen;
    
    self.layermiao = layermiao;
    
    [self initTime];

    
    // 注意
    /*
     
     CALayer并不关心任何响应链事件，所以不能直接处理触摸事件或者手势。但是它有一系列的方法帮你处理事件：-containsPoint:和-hitTest:。
     
     */
    
    
}


-(void)initThePosionLayer:(CALayer *)layer superView:(UIView *)superView image:(UIImage *)image
{
    layer.frame = CGRectMake(70,25, 80, 80);
    [self addImage:image toLayer:layer];

    [superView.layer addSublayer:layer];

}

-(void)changeAnchorPoint:(CALayer *)layer{
    
    layer.anchorPoint = CGPointMake(0.5f, 0.95f);

}


-(void)initTime
{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
}

-(void)tick{
    
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSDateComponents * cmp = [calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour  fromDate:[NSDate date]];
    
    CGFloat second = cmp.second;
    
    CGFloat secondA = (second * perSecondA) ;
    
    NSInteger minute = cmp.minute;
    
    CGFloat mintuteA = minute * perMintueA ;
    
    NSInteger hour = cmp.hour;
    
    CGFloat hourA = hour * perHourA  + minute * perMinHourA;
    
    self.layermiao.transform = CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);
    
    self.layerfen.transform = CATransform3DMakeRotation(angle2radion(mintuteA), 0, 0, 1);
    
    self.layerShi.transform = CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);
    
}

-(void)dealloc
{
    
    if ([self.timer isValid]) {
        
        [self.timer invalidate];
        
        self.timer = nil ;
        
    }
        
}


#pragma -mark layer的触摸事件
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get touch position relative to main view
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //convert point to the white layer's coordinates
    point = [self.viewBiao.layer convertPoint:point fromLayer:self.view.layer];
    //get layer using containsPoint:
    if ([self.viewBiao.layer containsPoint:point]) {
        //convert point to blueLayer’s coordinates
        point = [self.layerShi convertPoint:point fromLayer:self.viewBiao.layer];
        if ([self.layerShi containsPoint:point]) {
            [[[UIAlertView alloc] initWithTitle:@"layerShi"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"other"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get touch position
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //get touched layer
    CALayer *layer = [self.viewBiao.layer hitTest:point];
    //get layer using hitTest
    if (layer == self.layerShi) {
        [[[UIAlertView alloc] initWithTitle:@"layerShi"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else if (layer == self.viewBiao.layer) {
        [[[UIAlertView alloc] initWithTitle:@"viewBiao"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"other"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
 
    }
}

//-(void)addAnimation:(CALayer *)layer float:(CGFloat)float1
//{
//    
//    CABasicAnimation* rotationAnimation =
//    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
//    rotationAnimation.toValue = [NSNumber numberWithFloat:float1];
////    rotationAnimation.cumulative = YES;
//    [layer addAnimation:rotationAnimation forKey:@"ShiAnimation"];
//    
//}



@end
