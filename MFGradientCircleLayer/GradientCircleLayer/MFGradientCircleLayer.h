//
//  MFGradientCircleLayer.h
//  MFGradientCircleLayer
//
//  Created by 彭作青 on 2016/11/21.
//  Copyright © 2016年 myself. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFGradientCircleLayer : CALayer

-(instancetype)initGradientCircleWithBounds:(CGRect)bounds
                                 Position:(CGPoint)position
                                FromColor:(UIColor *)fromColor
                                  ToColor:(UIColor *)toColor
                                LineWidth:(CGFloat) linewidth;
+(instancetype)layerWithWithBounds:(CGRect)bounds
                          Position:(CGPoint)position
                         FromColor:(UIColor *)fromColor
                           ToColor:(UIColor *)toColor
                         LineWidth:(CGFloat) linewidth;

@end
