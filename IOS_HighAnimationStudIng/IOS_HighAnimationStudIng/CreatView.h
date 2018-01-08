//
//  CreatView.h
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/24.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "chipmunk.h"

@interface CreatView : UIImageView

@property (nonatomic,assign) cpBody *body;
@property (nonatomic,assign) cpShape *shape;

@end
