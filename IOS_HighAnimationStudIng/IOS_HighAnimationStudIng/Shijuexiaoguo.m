//
//  视觉效果.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/18.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

#import "Shijuexiaoguo.h"

@implementation Shijuexiaoguo

-(void)viewDidLoad
{
    
    
#pragma -mark 将阴影变成想要的形状

    /*
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(30, 100, 100, 100);
    layer.backgroundColor = [UIColor blueColor].CGColor;
//    layer.masksToBounds = YES;
    layer.cornerRadius = 10.0f; //圆角
    layer.borderColor = [UIColor redColor].CGColor;
    layer.borderWidth = 1.0f;
    
    layer.shadowOpacity = 1.0f; //shadowOpacity属性一个大于默认值（也就是0）的值，阴影就可以显示在任意图层之下。shadowOpacity是一个必须在0.0（不可见）和1.0（完全不透明）之间的浮点数。如果设置为1.0，将会显示一个有轻微模糊的黑色阴影稍微在图层之上。
    layer.shadowColor = [UIColor yellowColor].CGColor;
    //shadowColor属性控制着阴影的颜色
    layer.shadowOffset = CGSizeMake(6, 10);
    //shadowOffset属性控制着阴影的方向和距离。它是一个CGSize的值，宽度控制这阴影横向的位移，高度控制着纵向的位移。
    layer.shadowRadius = 10.0f;
    //shadowRadius属性控制着阴影的模糊度，当它的值是0的时候，阴影就和视图一样有一个非常确定的边界线。当值越来越大的时候，边界线看上去就会越来越模糊和自然

    //create a square shadow
//    CGMutablePathRef squarePath = CGPathCreateMutable();
//    CGPathAddRect(squarePath, NULL, layer.bounds);
//    layer.shadowPath = squarePath;
//    CGPathRelease(squarePath);
    
    //create a circular shadow
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, layer.bounds);
    layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
    
    
    [self.view.layer addSublayer:layer];
    
    
    //测试发现 当masksToBounds为true时，和shadow不能同时存在给一个视图layer
    //解决这个问题 需要两个layer，一个用来剪切，一个用来显示阴影
    */
    
#pragma -mark 图层蒙版
    //不知道为什么没有效果 感觉应该是图片的问题...
    /*
//    CALayer *layer = [CALayer layer];
//    layer.frame = CGRectMake(100, 100, 100, 100);
//    
//    [self addImage:[UIImage imageNamed:@"hah"] toLayer:layer];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    image.image = [UIImage imageNamed:@"menban"];
    
//    CALayer *layer1 = [CALayer layer];
//    layer1.frame = image.frame;
////    [self addImage:[UIImage imageNamed:@"hehe"] toLayer:layer1];
//    layer1.contents = (__bridge id)[UIImage imageNamed:@"hehe"].CGImage;
//
//    image.layer.mask = layer1;

    [self.view addSubview:image];
     */
    
    //当图片需要显示不同大小的时候，这个时候就可以用到拉升过滤了

#pragma -mark  拉升过滤
    /*
    CALayer为此提供了三种拉伸过滤方法，他们是：
    
    kCAFilterLinear
    kCAFilterNearest
    kCAFilterTrilinear
    */
    
    //minification（缩小图片）和magnification（放大图片）默认的过滤器都是kCAFilterLinear
    //kCAFilterTrilinear和kCAFilterLinear非常相似，大部分情况下二者都看不出来有什么差别。但是，较双线性滤波算法而言，三线性滤波算法存储了多个大小情况下的图片（也叫多重贴图），并三维取样，同时结合大图和小图的存储进而�得到最后的结果。
    
    //换句话说，线性过滤保留了形状，最近过滤则保留了像素的差异。
   // view.layer.magnificationFilter = kCAFilterNearest;

#pragma -makr ##组透明
    
//你可以设置CALayer的一个叫做shouldRasterize属性（见清单4.7）来实现组透明的效果，如果它被设置为YES，在应用透明度之前，图层及其子图层都会被整合成一个整体的图片，这样就没有透明度混合的问题了
//为了启用shouldRasterize属性，我们设置了图层的rasterizationScale属性。默认情况下，所有图层拉伸都是1.0， 所以如果你使用了shouldRasterize属性，你就要确保你设置了rasterizationScale属性去匹配屏幕，以防止出现Retina屏幕像素化的问题。
    
    
    
    
    
    
}





@end
