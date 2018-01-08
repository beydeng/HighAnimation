//
//  TransformMakeRotationViewCOntroller.m
//  IOS_HighAnimationStudIng
//
//  Created by DengPan on 2017/5/19.
//  Copyright © 2017年 www.Beydeng.com.HighAnimation. All rights reserved.
//

/*
 
 {
 
 CGFloat    m11（x缩放）,    m12（y切变）,      m13（旋转）,    m14（）;
 
 CGFloat    m21（x切变）,    m22（y缩放）,      m23（）       ,    m24（）;
 
 CGFloat    m31（旋转）  ,    m32（ ）       ,      m33（）       ,    m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义）;
 
 CGFloat    m41（x平移）,    m42（y平移）,    m43（z平移） ,    m44（）;
 
 };
 
 
 
 */


#import "TransformMakeRotationViewCOntroller.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5
@interface TransformMakeRotationViewCOntroller ()

{
    CALayer *_layerView,*_layer1,*_layer2;
    CGFloat rotion;
    NSMutableArray *arrView;
    UIView *_viewContent;
}

@end


@implementation TransformMakeRotationViewCOntroller

-(void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor grayColor];
    
    CALayer *layerView = [CALayer layer];
    layerView.frame = CGRectMake(40, 50, 200, 200);
    [self addImage:[UIImage imageNamed:@"timg.jpeg"] toLayer:layerView];
    
    [self.view.layer addSublayer:layerView];
    
    _layerView = layerView;
    
    rotion = M_PI/4;
    [self transOF3D];
    
    
    
    [self theSublayerTransform];
    
    
    [self changeSomeThing];
    
    
    [self initALiFangTi];
    
    
}


//rotate the layer 45 degrees

-(void)rotateTheLayer45
{
    /*
    CGAffineTransformMakeRotation(CGFloat angle)
    CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
    CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
    */
    
    CGAffineTransform transForm = CGAffineTransformMakeRotation(M_PI_4);
    
    _layerView.affineTransform = transForm;
    
    
}

#pragma -mark 混合变换
-(void)hunheBianhuan
{
    /*
    CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
    CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
    CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)
     */
    //当操纵一个变换的时候，初始生成一个什么都不做的变换很重要--也就是创建一个CGAffineTransform类型的空值，矩阵论中称作单位矩阵，Core Graphics同样也提供了一个方便的常量 CGAffineTransformIdentity
    
    //最后，如果需要混合两个已经存在的变换矩阵，就可以使用如下方法，在两个变换的基础上创建一个新的变换：
    
    //CGAffineTransformConcat(CGAffineTransform t1, CGAffineTransform t2);
    
    CGAffineTransform trans = CGAffineTransformIdentity;
    
    trans = CGAffineTransformScale(trans, 0.5, 0.5); //scale by 50%
    trans = CGAffineTransformRotate(trans, M_PI / 180.0 * 30.0); //rotate by 30 degrees
    trans = CGAffineTransformTranslate(trans, 200, 0); //translate by 200 points
    _layerView.affineTransform = trans;
    
    
}

#pragma -make 剪切变换

-(void)jianQieChange
{
    
    _layerView.affineTransform = CGAffineTransformMakeShear(1, 0);

}

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}

#pragma -mark ##3D变换
//和CGAffineTransform矩阵类似，Core Animation提供了一系列的方法用来创建和组合CATransform3D类型的矩阵，和Core Graphics的函数类似，但是3D的平移和旋转多处了一个z参数，并且旋转函数除了angle之外多出了x,y,z三个参数，分别决定了每个坐标轴方向上的旋转：
/*
 
 CATransform3DMakeRotation(CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
 CATransform3DMakeScale(CGFloat sx, CGFloat sy, CGFloat sz)
 CATransform3DMakeTranslation(Gloat tx, CGFloat ty, CGFloat tz)
 
 Z轴和这X Y轴分别垂直，指向视角外为正方向
 */

-(void)transOF3D
{
//    CATransform3D transform = CATransform3DMakeRotation(rotion, 0, 1, 0);
    
    CATransform3D transform =  CATransform3DMakeTranslation(0, 0, -200);

    _layerView.transform = transform;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get touch position
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //get touched layer
    CALayer *layer = [self.view.layer hitTest:point];
    //get layer using hitTest
    if (layer == self.view.layer) {

//        [self transOF3D];
        
        [self toushiTouyinTron];
        
        [self changeSome];
        
//        [self changeTheFangXiang];
        
        rotion = rotion + M_PI_4;
        
    }
    else
    {
        
    }
}

#pragma -make ###透视投影

//https://github.com/AttackOnDobby/iOS-Core-Animation-Advanced-Techniques/blob/master/5-变换/变换.md

-(void)toushiTouyinTron
{
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = -1.0/600;
    
    transform = CATransform3DRotate(transform, rotion, 0, 1, 0);
    
    _layerView.transform = transform;
    
}

#pragma -mark ##sublayerTransform属性

/*
 CALayer有一个属性叫做sublayerTransform。它也是CATransform3D类型，但和对一个图层的变换不同，它影响到所有的子图层。这意味着你可以一次性对包含这些图层的容器做变换，于是所有的子图层都自动继承了这个变换方法。
 
 */

-(void)theSublayerTransform
{
    
    CATransform3D tran = CATransform3DIdentity;
    tran.m34 = -1.0/500;
    
    self.view.layer.sublayerTransform = tran;
    
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(50, 250, 100, 100);
    
    [self addImage:[UIImage imageNamed:@"204.jpg"] toLayer:layer1];
    
    [self.view.layer addSublayer:layer1];
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(250, 250, 100, 100);
    
    [self addImage:[UIImage imageNamed:@"timg.jpeg"] toLayer:layer2];
    
    [self.view.layer addSublayer:layer2];
    
    _layer1 = layer1;
    _layer2 = layer2;
    
    [self backGround];
    
    /*
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
   layer1.transform = transform1;
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    layer2.transform = transform2;
    */
    
    
}

-(void)changeSome
{
    
    CATransform3D transform1 = CATransform3DMakeRotation(rotion, 0, 1, 0);
    _layer1.transform = transform1;
    CATransform3D transform2 = CATransform3DMakeRotation(-rotion, 0, 1, 0);
    _layer2.transform = transform2;
    
}

#pragma -mark ###背面
//CALayer有一个叫做doubleSided的属性来控制图层的背面是否要被绘制。这是一个BOOL类型，默认为YES，如果设置为NO，那么当图层正面从相机视角消失的时候，它将不会被绘制。

-(void)backGround{
    
    _layer1.doubleSided = NO;
    
}

#pragma -mark ###扁平化图层
//如果对包含已经做过变换的图层的图层做反方向的变换将会发什么什么呢
-(void)changeSomeThing
{
    
    CALayer *layerOuter = [CALayer layer];
    
    layerOuter.frame = CGRectMake(50, 350, 100, 100);
    
    layerOuter.backgroundColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer:layerOuter];
    
    
    CALayer *layerInter = [CALayer layer];
    
    layerInter.frame = CGRectMake(25, 25, 50, 50);
    
    layerInter.backgroundColor = [UIColor blueColor].CGColor;
    
    [layerOuter addSublayer:layerInter];
    
    /*
    CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    layerOuter.transform = outer;
    //rotate the inner layer -45 degrees
    CATransform3D inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    layerInter.transform = inner;
     */
    
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1.0 / 500.0;
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
    layerOuter.transform = outer;
    //rotate the inner layer -45 degrees
    CATransform3D inner = CATransform3DIdentity;
    inner.m34 = -1.0 / 500.0;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
    layerInter.transform = inner;
    
}


-(void)initALiFangTi
{
    arrView = [NSMutableArray arrayWithCapacity:6];
    
    NSArray *arrColor = [NSArray arrayWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor orangeColor],[UIColor grayColor],[UIColor blackColor], nil];
    
    for (int i=0; i<6; i++) {
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(0, 0, 200, 200);
        
        if (i!=2) {
            
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 200, 50)];
            lable.text = [NSString stringWithFormat:@"%d",i+1];
            lable.textColor = (UIColor *)arrColor[i];
            lable.font = [UIFont boldSystemFontOfSize:20];
            lable.textAlignment = NSTextAlignmentCenter;
            [view addSubview:lable];
            
        }
        else
        {
            
            UIButton *btn = [UIButton new];
            btn.frame = CGRectMake(0, 25, 200, 50);
            btn.titleLabel.textColor = (UIColor *)arrColor[i];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
            [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
//            btn.layer.borderWidth = 1.0f;
//            btn.layer.borderColor = [UIColor blackColor].CGColor;
            [view addSubview:btn];
            
        }
        
        [arrView addObject:view];
        
    }
    
    
    UIView *viewContent = [[UIView alloc]initWithFrame:CGRectMake(100, 450, 200, 200)];
    viewContent.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:viewContent];
    
    _viewContent = viewContent;
    
    CATransform3D perspective = CATransform3DIdentity;
    
    perspective.m34 = -1.0/500;
    
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    
    viewContent.layer.sublayerTransform = perspective;
    
    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);  //往Z方向向上平移50个单位
    
    [self addFace:0 withTransform:transform]; // 将1玩z方向平移100单位
    
    transform = CATransform3DMakeTranslation(100, 0, 0);
    //往x方向向上平移100个单位
    
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    //然后旋转90度
    [self addFace:1 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    

}


- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    
    UIView *face = arrView[index];
    
    [_viewContent addSubview:face];
    
    CGSize containerSize = _viewContent.bounds.size;
    
    face.center = CGPointMake(containerSize.width/2, containerSize.height/2);
    
    face.layer.transform = transform;
    
    [self applyLightingToFace:face.layer];
    
}

-(void)changeTheFangXiang
{
    
    CATransform3D perspective = CATransform3DIdentity;
    
    perspective.m34 = -1.0/500;

    perspective = CATransform3DRotate(perspective, -rotion, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -rotion, 0, 1, 0);
    
    _viewContent.layer.sublayerTransform = perspective;

    
    
}

- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}


@end
