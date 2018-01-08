//
//  HuiTuViewController.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/7/24.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "HuiTuViewController.h"

@interface HuiTuViewController ()

@end

@implementation HuiTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor (con,  1, 0, 0, 1.0);//设置填充颜色
    CGContextSetLineWidth(con, 1.0);//线的宽度

    CGContextMoveToPoint(con, 10, 10);
    CGContextAddLineToPoint(con, 150, 1);
    CGContextRelease(con);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
