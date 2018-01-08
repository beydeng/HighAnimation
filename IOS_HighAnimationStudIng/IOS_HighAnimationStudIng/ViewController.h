//
//  ViewController.h
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/18.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer;
-(void)addImage:(UIImage *)image toLayer:(CALayer *)layer;

@end

