//
//  ReflectionView.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/22.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "ReflectionView.h"
#import <QuartzCore/QuartzCore.h>
@implementation ReflectionView


-(Class)layerClass
{
    return [CAReplicatorLayer class];
}

-(void)setUp{
    
    
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.instanceCount = 2;
    
    //move reflection instance below original and flip vertically
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffset = self.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform = transform;
    
    //reduce alpha of reflection layer
    layer.instanceAlphaOffset = -0.6;
    
}

- (id)initWithFrame:(CGRect)frame
{
    //this is called when view is created in code
    if ((self = [super initWithFrame:frame])) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    //this is called when view is created from a nib
    [self setUp];
}


@end
