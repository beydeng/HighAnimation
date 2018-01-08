//
//  TheGaoxiaoHuituViewController.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/26.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "TheGaoxiaoHuituViewController.h"
#import "DrawingView.h"

@implementation TheGaoxiaoHuituViewController

-(void)viewDidLoad
{
    
    [super viewDidLoad];

    DrawingView *drawView = [DrawingView new];
    drawView.frame = self.view.bounds;
    
    [self.view addSubview:drawView];
    
}

@end
