//
//  CreatView.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/24.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "CreatView.h"

#define MASS 100

@interface CreatView ()

@end


@implementation CreatView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        //set image
//        self.image = [UIImage imageNamed:@"Crate.png"];
//        self.contentMode = UIViewContentModeScaleAspectFill;
        self.backgroundColor = [UIColor redColor];
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = frame.size.width/2;
        //create the body
        self.body = cpBodyNew(MASS, cpMomentForBox(MASS, frame.size.width, frame.size.height));  //进行绑定本体
        //create the shape
        cpVect corners[] = { //四个角
            cpv(0, 0),
            cpv(0, frame.size.height),
            cpv(frame.size.width, frame.size.height),
            cpv(frame.size.width, 0),
        };
//        self.shape = cpPolyShapeNew(self.body, 4, corners, cpv(-frame.size.width/2, -frame.size.height/2));
        
        
        /*
         
         cpPolyShapeNew(cpBody *body, int count, const cpVect *verts, cpTransform transform, cpFloat radius)
         
         body 本体
         
         count 几个角
         
         cpVect 角的位置
         
         cpTransform 变换
         
         cpFloat 圆角
         
         */
        
        
        self.shape = cpPolyShapeNew(self.body, 4, corners, cpTransformIdentity, 0);
        
        //set shape friction & elasticity
        cpShapeSetFriction(self.shape, 0.5);
        cpShapeSetElasticity(self.shape, 0.8);
        //link the crate to the shape
        //so we can refer to crate from callback later on
//        self.shape->point = (__bridge void *)self;
        
        cpShapeSetUserData(self.shape, (__bridge void *)self);
        
        //set the body position to match view
//        cpBodySetPos(self.body, cpv(frame.origin.x + frame.size.width/2, 300 - frame.origin.y - frame.size.height/2));
        
        cpBodySetPosition(self.body, cpv(frame.origin.x + frame.size.width/2, 300 - frame.origin.y - frame.size.height/2));
        
    }
    return self;
}

- (void)dealloc
{
    //release shape and body
    cpShapeFree(_shape);
    cpBodyFree(_body);
}


@end
