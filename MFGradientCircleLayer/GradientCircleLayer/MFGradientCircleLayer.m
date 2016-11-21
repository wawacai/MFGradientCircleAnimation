//
//  MFGradientCircleLayer.m
//  MFGradientCircleLayer
//
//  Created by 彭作青 on 2016/11/21.
//  Copyright © 2016年 myself. All rights reserved.
//

#import "MFGradientCircleLayer.h"

@implementation MFGradientCircleLayer

-(instancetype)initGradientCircleWithBounds:(CGRect)bounds Position:(CGPoint)position FromColor:(UIColor *)fromColor ToColor:(UIColor *)toColor LineWidth:(CGFloat)linewidth {
    if (self = [super init]) {
        self.backgroundColor = [UIColor yellowColor].CGColor;
        self.bounds = bounds;
        self.position = position;
        NSArray * colors = [self graintFromColor:fromColor ToColor:toColor Count:4.0];
        for (int i = 0; i < colors.count -1; i++) {
            CAGradientLayer * gradient = [CAGradientLayer layer];
            gradient.bounds = CGRectMake(0,0,CGRectGetWidth(bounds)/2,CGRectGetHeight(bounds)/2);
            NSValue * valuePoint = [[self positionArrayWithMainBounds:self.bounds] objectAtIndex:i];
            gradient.position = valuePoint.CGPointValue;
            UIColor * fromColor = colors[i];
            UIColor * toColor = colors[i+1];
            NSArray *colors = [NSArray arrayWithObjects:(id)fromColor.CGColor, toColor.CGColor, nil];
            NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
            NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
            NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
            gradient.colors = colors;
            gradient.locations = locations;
            gradient.startPoint = ((NSValue *)[[self startPoints] objectAtIndex:i]).CGPointValue;
            gradient.endPoint = ((NSValue *)[[self endPoints] objectAtIndex:i]).CGPointValue;
            [self addSublayer:gradient];
        }
        //Set mask
        CAShapeLayer * shapelayer = [CAShapeLayer layer];
        // shapeLayer的路径是宽度是向两边扩展，所以要留出 2 * linewidth 的距离
        CGRect rect = CGRectMake(0,0,CGRectGetWidth(self.bounds) - 2 * linewidth, CGRectGetHeight(self.bounds) - 2 * linewidth);
        shapelayer.bounds = rect;
        shapelayer.position = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        // 设置path的渲染颜色，与结果没有关系，只是添加一个颜色让路径显示，否则默认是不显示。
        shapelayer.strokeColor = [UIColor blueColor].CGColor;
        shapelayer.fillColor = [UIColor clearColor].CGColor;
        shapelayer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:CGRectGetWidth(rect)/2].CGPath;
        shapelayer.lineWidth = linewidth;
        shapelayer.lineCap = kCALineCapRound;
        // 控制路径绘制的开始和结束的点
        shapelayer.strokeStart = 0.015;
        shapelayer.strokeEnd = 0.985;
        [self setMask:shapelayer];
    }
    return self;
}
+(instancetype)layerWithWithBounds:(CGRect)bounds
                          Position:(CGPoint)position
                         FromColor:(UIColor *)fromColor
                           ToColor:(UIColor *)toColor
                         LineWidth:(CGFloat)linewidth{
    MFGradientCircleLayer * layer = [[self alloc] initGradientCircleWithBounds:bounds
                                                                  Position:position
                                                                 FromColor:fromColor
                                                                   ToColor:toColor
                                                                 LineWidth:linewidth];
    return layer;
}

// 根据传入的bounds值来确定四个点，相当于矩形向内缩进1/4形成的矩形的四个点。
-(NSArray *)positionArrayWithMainBounds:(CGRect)bounds{
    CGPoint first = CGPointMake(CGRectGetWidth(bounds)/4 *3, CGRectGetHeight(bounds)/4 *1);
    CGPoint second = CGPointMake(CGRectGetWidth(bounds)/4 *3, CGRectGetHeight(bounds)/4 *3);
    CGPoint thrid = CGPointMake(CGRectGetWidth(bounds)/4 *1, CGRectGetHeight(bounds)/4 *3);
    CGPoint fourth = CGPointMake(CGRectGetWidth(bounds)/4 *1, CGRectGetHeight(bounds)/4 *1);
    return @[[NSValue valueWithCGPoint:first],
             [NSValue valueWithCGPoint:second],
             [NSValue valueWithCGPoint:thrid],
             [NSValue valueWithCGPoint:fourth]];
}
// 获得一个矩形的四个顶点
-(NSArray *)startPoints{
    return @[[NSValue valueWithCGPoint:CGPointMake(0,0)],
             [NSValue valueWithCGPoint:CGPointMake(1,0)],
             [NSValue valueWithCGPoint:CGPointMake(1,1)],
             [NSValue valueWithCGPoint:CGPointMake(0,1)]];
}
-(NSArray *)endPoints{
    return @[[NSValue valueWithCGPoint:CGPointMake(1,1)],
             [NSValue valueWithCGPoint:CGPointMake(0,1)],
             [NSValue valueWithCGPoint:CGPointMake(0,0)],
             [NSValue valueWithCGPoint:CGPointMake(1,0)]];
}

-(NSArray *)graintFromColor:(UIColor *)fromColor ToColor:(UIColor *)toColor Count:(NSInteger)count{
    CGFloat fromR = 0.0,fromG = 0.0,fromB = 0.0,fromAlpha = 0.0;
    // 从传入的颜色对象中获取 R G B alpha
    [fromColor getRed:&fromR green:&fromG blue:&fromB alpha:&fromAlpha];
    CGFloat toR = 0.0,toG = 0.0,toB = 0.0,toAlpha = 0.0;
    [toColor getRed:&toR green:&toG blue:&toB alpha:&toAlpha];
    NSMutableArray * result = [[NSMutableArray alloc] init];
    for (int i = 0; i <= count; i++) {
        CGFloat oneR = fromR + (toR - fromR)/count * i;
        CGFloat oneG = fromG + (toG - fromG)/count * i;
        CGFloat oneB = fromB + (toB - fromB)/count * i;
        CGFloat oneAlpha = fromAlpha + (toAlpha - fromAlpha)/count * i;
//        NSLog(@"r = %f, g = %f, b = %f, al = %f", oneR, oneG, oneB, oneAlpha);
        UIColor * onecolor = [UIColor colorWithRed:oneR green:oneG blue:oneB alpha:oneAlpha];
        [result addObject:onecolor];
        [self startAnimation];
    }
    return result;
}
-(UIColor *)midColorWithFromColor:(UIColor *)fromColor ToColor:(UIColor*)toColor Progress:(CGFloat)progress{
    CGFloat fromR = 0.0,fromG = 0.0,fromB = 0.0,fromAlpha = 0.0;
    [fromColor getRed:&fromR green:&fromG blue:&fromB alpha:&fromAlpha];
    CGFloat toR = 0.0,toG = 0.0,toB = 0.0,toAlpha = 0.0;
    [toColor getRed:&toR green:&toG blue:&toB alpha:&toAlpha];
    CGFloat oneR = fromR + (toR - fromR) * progress;
    CGFloat oneG = fromG + (toG - fromG) * progress;
    CGFloat oneB = fromB + (toB - fromB) * progress;
    CGFloat oneAlpha = fromAlpha + (toAlpha - fromAlpha) * progress;
    UIColor * onecolor = [UIColor colorWithRed:oneR green:oneG blue:oneB alpha:oneAlpha];
    return onecolor;
}

- (void)startAnimation {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.values = @[[self transformWithRotation:M_PI* 0.0],
                    [self transformWithRotation:M_PI* 0.5],
                    [self transformWithRotation:M_PI],
                    [self transformWithRotation:M_PI * 1.5],
                    [self transformWithRotation:2*M_PI]];
    anim.duration = 2.0;
    anim.repeatCount = CGFLOAT_MAX;
    [self addAnimation:anim forKey:nil];
}

-(NSValue *)transformWithRotation:(CGFloat)rotate{
    return  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(rotate,0,0,1)];
}

@end
