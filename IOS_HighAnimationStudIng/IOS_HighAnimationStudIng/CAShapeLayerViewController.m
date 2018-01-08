//
//  CAShapeLayerViewController.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/19.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

/*
 
 CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类。你指定诸如颜色和线宽等属性，用CGPath来定义想要绘制的图形，最后CAShapeLayer就自动渲染出来了。当然，你也可以用Core Graphics直接向原始的CALyer的内容中绘制一个路径，相比直下，使用CAShapeLayer有以下一些优点：
 
 渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
 高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
 不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。你的图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉（如我们在第二章所见）。
 不会出现像素化。当你给CAShapeLayer做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。
 
 */

#import "CAShapeLayerViewController.h"
#import <CoreText/CoreText.h>
#import "ReflectionView.h"


@interface  CAShapeLayerViewController()
{
    UIView *_containerView;
}

@property (nonatomic,strong) UIView *containerView;

@end



@implementation CAShapeLayerViewController

-(void)viewDidLoad
{
    
    
#pragma -mark 创建一个CGPath
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    [path moveToPoint:CGPointMake(175, 100)]; //从175，100开始绘制
    
    /**
     * 该方法会创建出一个开放路径, 创建出来的圆弧是圆的一部分. 在默认的坐标系统中, 开始角度 和 结束角度 都是基于单位圆的(看下面这张图). 调用这个方法之后, currentPoint 将会设置为圆弧的结束点.
     * 举例来说: 指定其实角度为0, 指定结束角度为π, 设置 clockwise 属性为 YES, 将会绘制出圆的下半部分.
     * 然而当我们不修改起始角度 和 结束角度, 我们仅仅将 clockwise 角度设置为 NO, 则会绘制出来一个圆的上半部分.
     * @param center:   圆心
     * @param radius: 半径
     * @param startAngle:   起始角度
     * @param endAngle:   结束角度
     * @param clockwise:   是否顺时针绘制
     */
/*
+ (instancetype) bezierPathWithArcCenter:(CGPoint)center
radius:(CGFloat)radius
startAngle:(CGFloat)startAngle
endAngle:(CGFloat)endAngle
clockwise:(BOOL)clockwise;
*/
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
    
    
    
    //define path parameters
    
#pragma -mark 一个直角 3个圆角
    
    CGRect rect = CGRectMake(100, 350, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    
    shapeLayer1.strokeColor = [UIColor redColor].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 2.0f;
    shapeLayer1.lineJoin = kCALineJoinRound;
    shapeLayer1.lineCap = kCALineCapRound;
    shapeLayer1.path = path1.CGPath;
    [self.view.layer addSublayer:shapeLayer1];
    
    
#pragma -mark ##CATextLayer
    
    CATextLayer *textLayer = [CATextLayer layer];
    
    textLayer.frame = CGRectMake(20, 450, self.view.bounds.size.width-2*20, 200);
    [self.view.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor blueColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    UIFont *font = [UIFont systemFontOfSize:15];
    
    
    /*
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontref = CGFontCreateWithFontName(fontName);
    textLayer.font = fontref;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontref);
    */
    
    NSString *str = @"如果你仔细看这个文本，你会发现一个奇怪的地方：这些文本有一些像素化了。这是因为并没有以Retina的方式渲染，第二章提到了这个contentScale属性，用来决定图层内容应该以怎样的分辨率来渲染。contentsScale并不关心屏幕的拉伸因素而总是默认为1.0。如果我们想以Retina的质量来显示文字，我们就得手动地设置CATextLayer的contentsScale属性";
    /*
     
     textLayer.string = str;
     
     //如果你仔细看这个文本，你会发现一个奇怪的地方：这些文本有一些像素化了。这是因为并没有以Retina的方式渲染，第二章提到了这个contentScale属性，用来决定图层内容应该以怎样的分辨率来渲染。contentsScale并不关心屏幕的拉伸因素而总是默认为1.0。如果我们想以Retina的质量来显示文字，我们就得手动地设置CATextLayer的contentsScale属性
     
     textLayer.contentsScale = [UIScreen mainScreen].scale;
     
     */
    
    
#pragma -mark NSMutableAttributedString
    
    //convert UIFont to a CTFont
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:str];
    CFStringRef fontName = (__bridge CFStringRef) font.fontName;
    CGFloat fonsize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fonsize, NULL);

    //set text attributes
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };

    
    [attribute setAttributes:attribs range:NSMakeRange(0, [str length])];
    
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };

    [attribute setAttributes:attribs range:NSMakeRange(0, 15)];

    CFRelease(fontRef);
    
    textLayer.string = attribute;
    
    textLayer.contentsScale = [UIScreen mainScreen].scale;

//    [self newLiTi];
    
//    [self newCreatedCute];
    
//    [self CAGradientLayer];
    
//    [self CAReplicatorLayer];
    
    [self ReflectionView];
}


- (CALayer *)faceWithTransform:(CATransform3D)transform
{
    //create cube face layer
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    //apply a random color
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    //apply the transform and return
    face.transform = transform;
    return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform
{
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //center the cube layer within the container
    CGSize containerSize = _containerView.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    
    //apply the transform and return
    cube.transform = transform;
    return cube;
}

-(void)newLiTi{
    
    _containerView = [[UIView alloc]initWithFrame:CGRectMake(200, 100, 100, 100)];
    
    [self.view addSubview:_containerView];
    
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    _containerView.layer.sublayerTransform = pt;
    
    //set up the transform for cube 1 and add it
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [_containerView.layer addSublayer:cube1];
    
    //set up the transform for cube 2 and add it
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [_containerView.layer addSublayer:cube2];
    
}

- (CALayer *)newFaceWithTransform:(CATransform3D)transform
{
    //create cube face layer
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    //apply a random color
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    face.transform = transform;
    return face;
}

- (CALayer *)newCubeWithTransform:(CATransform3D)transform
{
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //center the cube layer within the container
    CGSize containerSize = self.containerView.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    
    //apply the transform and return
    cube.transform = transform;
    return cube;
}


-(void)newCreatedCute
{
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    
    [self.view addSubview:self.containerView];
    
    
    //set up the perspective transform
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = pt;
    
    //set up the transform for cube 1 and add it
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [self.containerView.layer addSublayer:cube1];
    
    //set up the transform for cube 2 and add it
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [self.containerView.layer addSublayer:cube2];
}

#pragma -mark ##CAGradientLayer 渐变

-(void)CAGradientLayer
{
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.containerView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradient];
    
    
    //gradient.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor];
    
    
    //gradient.startPoint = CGPointMake(0, 0);
    //gradient.endPoint = CGPointMake(1, 1);
    
    
    
    //gradient.startPoint = CGPointMake(0.5, 0);
    
    //gradient.endPoint = CGPointMake(0.5, 1);
    
#pragma -mark ###多重渐变
    
    //如果你愿意，colors属性可以包含很多颜色，所以创建一个彩虹一样的多重渐变也是很简单的。默认情况下，这些颜色在空间上均匀地被渲染，但是我们可以用locations属性来调整空间。locations属性是一个浮点数值的数组（以NSNumber包装）。这些浮点数定义了colors属性中每个不同颜色的位置，同样的，也是以单位坐标系进行标定。0.0代表着渐变的开始，1.0代表着结束。
    
    //locations数组并不是强制要求的，但是如果你给它赋值了就一定要确保locations的数组大小和colors数组大小一定要相同，否则你将会得到一个空白的渐变
    
    //set gradient colors
    gradient.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    
    //set locations
    gradient.locations = @[@0.0, @0.25, @0.5];
    
    //set gradient start and end points
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 1);
    
}

#pragma -mark ##CAReplicatorLayer

-(void)CAReplicatorLayer
{
    //CAReplicatorLayer的目的是为了高效生成许多相似的图层。它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换。看上去演示能够更加解释这些，我们来写个例子吧。
#pragma -mark ###重复图层
    
    //我们在屏幕的中间创建了一个小白色方块图层，然后用CAReplicatorLayer生成十个图层组成一个圆圈。instanceCount属性指定了图层需要重复多少次。instanceTransform指定了一个CATransform3D3D变换（这种情况下，下一图层的位移和旋转将会移动到圆圈的下一个点）
    
//    self.view.backgroundColor = [UIColor grayColor];
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(150, 100, 100, 100)];
    
    [self.view addSubview:self.containerView];
    
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    
    layer.frame = self.containerView.bounds;
    
    layer.instanceCount = 11; //重复10次
    
    [self.containerView.layer addSublayer:layer];
    
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    layer.instanceTransform = transform;
    
    //apply a color shift for each instance
    layer.instanceBlueOffset = -0.1;
    layer.instanceGreenOffset = -0.1;
    
    //create a sublayer and place it inside the replicator
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    layer1.backgroundColor = [UIColor whiteColor].CGColor;
    [layer addSublayer:layer1];
    
}

#pragma -mark ###反射

-(void)ReflectionView
{
    
    // 方法1 使用CAReplicatorLayer并应用一个负比例变换于一个复制图层，你就可以创建指定视图（或整个视图层次）内容的镜像图片，这样就创建了一个实时的『反射』效果
    
    //方法2 指定一个继承于UIView的ReflectionView，它会自动产生内容的反射效果
    
    //没搞明白......
    
//    ReflectionView *view = [[ReflectionView alloc]initWithFrame:CGRectMake(250, 250, 100, 100)];
//    
////    view.backgroundColor = [UIColor yellowColor];
//    
//    [self.view addSubview:view];
//
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame = view.bounds;
//    layer.contents = (__bridge id)[UIImage imageNamed:@"204"].CGImage;
//    
//    [self.view.layer addSublayer:layer];
    
    
    
}




@end
