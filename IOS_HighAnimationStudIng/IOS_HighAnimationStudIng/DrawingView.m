//
//  DrawingView.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/26.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "DrawingView.h"

@interface DrawingView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation DrawingView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.path = [[UIBezierPath alloc] init];
        self.path.lineJoinStyle = kCGLineJoinRound;
        self.path.lineCapStyle = kCGLineCapRound;
        self.path.lineWidth = 2;
        
    }
    
    return self;
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the starting point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //move the path drawing cursor to the starting point
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the current point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //add a new line segment to our path
    [self.path addLineToPoint:point];
    
    //redraw the view
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //draw path
    [[UIColor clearColor] setFill];
    [[UIColor redColor] setStroke];
    [self.path stroke];
}



@end
