//
//  ViewController.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/18.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIView *layerView = [[UIView alloc]initWithFrame:CGRectMake(50, 120, 200, 200)];
    layerView.backgroundColor = [UIColor whiteColor];
    //#寄宿图
    layerView.layer.contents = (__bridge id)[UIImage imageNamed:@"timg.jpeg"].CGImage;
    /*
     kCAGravityCenter
     kCAGravityTop
     kCAGravityBottom
     kCAGravityLeft
     kCAGravityRight
     kCAGravityTopLeft
     kCAGravityTopRight
     kCAGravityBottomLeft
     kCAGravityBottomRight
     kCAGravityResize
     kCAGravityResizeAspect
     kCAGravityResizeAspectFill
     */
    
    //contentGravity
    layerView.layer.contentsGravity =  kCAGravityResizeAspectFill ;
    layerView.layer.contentsScale = [UIImage imageNamed:@"timg.jpeg"].scale;
    layerView.layer.masksToBounds = YES ;
//    [self.view addSubview:layerView];
    
    //#contentsScale
    

    
//    CALayer *blueLayer = [CALayer layer];
//    blueLayer.frame = CGRectMake(50, 50, 100, 100);
//    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
//    [layerView.layer addSublayer:blueLayer];
    
    
    //##contentsRect 图片拼合 使用代码 注意的是 这个位置并不是很好的计算
    
    //把一个大图 分开来显示每一部分
    
//    UIImage *image = [UIImage imageNamed:@"204.jpg"];
//
//    //使用4个不同的view来显示这个图片
//    
//    for (int i=0; i<2; i++) {
//        
//        for (int j=0; j<2; j++) {
//            
//            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20+100*i,50+100*j, 100, 100)];
//            [self addSpriteImage:image withContentRect:CGRectMake(0.5*i,0.5*j, 0.5, 0.5) toLayer:view.layer];
//            [self.view addSubview:view];
//            
//        }
//        
//    }
    
    //##contentsCenter
    
    UIImage *image = [UIImage imageNamed:@"11"];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40, 40, 100, 200)];
    
    [self addStretchableImage:image withContentCenter:CGRectMake(0, 0, 0.25, 0.25) toLayer:view.layer];
    
    [self.view addSubview:view];
    
    
    //self.greenView.layer.zPosition = 1.0f; 可以改变两个视图的显示位置

    
    
}


-(void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer
{
    
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
    
}


-(void)addImage:(UIImage *)image toLayer:(CALayer *)layer
{
    
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    
}




-(void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer
{
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsCenter = rect;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
