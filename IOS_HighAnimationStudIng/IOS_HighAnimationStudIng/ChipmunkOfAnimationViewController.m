//
//  ChipmunkOfAnimationViewController.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/24.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "ChipmunkOfAnimationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "chipmunk.h"
#import "CreatView.h"

#define GRAVITY 1000
#define SIMULATION_STEP (1/120.0)

@interface ChipmunkOfAnimationViewController ()<UIAccelerometerDelegate>

@property (nonatomic, assign) cpSpace *space;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CFTimeInterval lastStep;
@property (nonatomic,strong) UIView *viewContent;
@end



@implementation ChipmunkOfAnimationViewController


- (void)addCrateWithFrame:(CGRect)frame
{
    CreatView *crate = [[CreatView alloc] initWithFrame:frame];
    [self.viewContent addSubview:crate];
    cpSpaceAddBody(self.space, crate.body);
    cpSpaceAddShape(self.space, crate.shape);
}

- (void)addWallShapeWithStart:(cpVect)start end:(cpVect)end
{
    cpBody *body = cpSpaceGetStaticBody(self.space);

    cpShape *wall = cpSegmentShapeNew(body, start, end, 1);
    cpShapeSetCollisionType(wall, 2);
    cpShapeSetFriction(wall, 0.5);
    cpShapeSetElasticity(wall, 0.8);
    cpSpaceAddShape(self.space, wall);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewContent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.viewContent.backgroundColor = [UIColor grayColor];
    self.viewContent.layer.geometryFlipped = YES;

    [self.view addSubview:self.viewContent];
    /*
    //invert view coordinate system to match physics
    //set up physics space
    self.space = cpSpaceNew();
    cpSpaceSetGravity(self.space, cpv(0, -GRAVITY));
    //add a crate
    CreatView *crate = [[CreatView alloc] initWithFrame:CGRectMake(100, 0, 60, 60)];
    [self.viewContent addSubview:crate];
    cpSpaceAddBody(self.space, crate.body);
    cpSpaceAddShape(self.space, crate.shape);
    //start the timer
    self.lastStep = CACurrentMediaTime();
    self.timer = [CADisplayLink displayLinkWithTarget:self
                                             selector:@selector(step:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop]
                     forMode:NSDefaultRunLoopMode];
     */
    
    self.space = cpSpaceNew();
    cpSpaceSetGravity(self.space, cpv(0, -GRAVITY));
    //add wall around edge of view
    CGSize sizeOFMain = self.view.frame.size;
    [self addWallShapeWithStart:cpv(40, 40) end:cpv(sizeOFMain.width-80, 0)];
    [self addWallShapeWithStart:cpv(sizeOFMain.width-80, 0) end:cpv(sizeOFMain.width-80, sizeOFMain.height-80)];
    [self addWallShapeWithStart:cpv(sizeOFMain.width-80, sizeOFMain.height-80) end:cpv(0, sizeOFMain.height-80)];
    [self addWallShapeWithStart:cpv(0, sizeOFMain.height-80) end:cpv(40, 40)];
    //add a crates
    [self addCrateWithFrame:CGRectMake(0, 0, 32, 32)];
    [self addCrateWithFrame:CGRectMake(32, 0, 8, 8)];
    [self addCrateWithFrame:CGRectMake(64, 0, 64, 64)];
    [self addCrateWithFrame:CGRectMake(128, 0, 4, 4)];
    [self addCrateWithFrame:CGRectMake(0, 32, 16, 16)];
    //start the timer
    self.lastStep = CACurrentMediaTime();
    self.timer = [CADisplayLink displayLinkWithTarget:self
                                             selector:@selector(step:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop]
                     forMode:NSDefaultRunLoopMode];
//    //update gravity using accelerometer
    [UIAccelerometer sharedAccelerometer].delegate = self;
    [UIAccelerometer sharedAccelerometer].updateInterval = 1/60.0;
    
    
}


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    //update gravity
    cpSpaceSetGravity(self.space, cpv(acceleration.y * GRAVITY, acceleration.x * GRAVITY));
}

void updateShape(cpShape *shape, void *unused)
{
    //get the crate object associated with the shape
    CreatView *crate = (__bridge CreatView *)cpShapeGetUserData(shape);
    //update crate view position and angle to match physics shape
    cpBody *body = cpShapeGetBody(shape);
//    crate.center = cpBodyGetPos(body);
    crate.center = cpBodyGetPosition(body);
    crate.transform = CGAffineTransformMakeRotation(cpBodyGetAngle(body));
}

- (void)step:(CADisplayLink *)timer
{
    //calculate step duration
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    //update physics
    cpSpaceStep(self.space, stepDuration);
    //update all the shapes
    cpSpaceEachShape(self.space, &updateShape, NULL);
}



//- (void)step:(CADisplayLink *)timer
//{
//    //calculate frame step duration
//    CFTimeInterval frameTime = CACurrentMediaTime();
//    //update simulation
//    while (self.lastStep < frameTime) {
//        cpSpaceStep(self.space, SIMULATION_STEP);
//        self.lastStep += SIMULATION_STEP;
//    }
//    
//    //update all the shapes
//    cpSpaceEachShape(self.space, &updateShape, NULL);
//}



@end
