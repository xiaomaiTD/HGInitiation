//
//  UIColor+HG.m
//  HGInitiation
//
//  Created by __无邪_ on 2018/1/3.
//  Copyright © 2018年 __无邪_. All rights reserved.
//

#import "UIColor+HG.h"

@implementation UIColor (HG)

+ (UIColor *)randomColor {
    CGFloat aRedValue = arc4random() % 255 / 255.f;
    CGFloat aGreenValue = arc4random() % 255 / 255.f;
    CGFloat aBlueValue = arc4random() % 255 / 255.f;
    UIColor *randColor = [UIColor colorWithRed:aRedValue green:aGreenValue blue:aBlueValue alpha:1.0f];
    return randColor;
}
+ (UIColor *)disabledColor {
    return [UIColor lightGrayColor];
}
+ (UIColor *)placeholderColor {
    return [UIColor groupTableViewBackgroundColor];
}

+ (UIColor *)gradientColorFrom:(UIColor *)colorFrom to:(UIColor *)colorTo height:(int)height {
    return HGGradientFromColors(@[colorFrom,colorTo], CGSizeMake(HGPixelOne, height));
}
+ (UIColor *)gradientColorFrom:(UIColor *)colorFrom to:(UIColor *)colorTo width:(int)width {
    return HGGradientFromColors(@[colorFrom,colorTo], CGSizeMake(width, HGPixelOne));
}
+ (UIColor *)gradientColors:(NSArray *)colors size:(CGSize)size {
    return HGGradientFromColors(colors, size);
}

UIKIT_STATIC_INLINE UIColor *HGGradientFromColors(NSArray *colors,CGSize size){
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSMutableArray *refColors = [NSMutableArray.alloc init];
    for (int i = 0; i < colors.count; i++) {
        [refColors addObject:(id)[colors[i] CGColor]];
    }
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)refColors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(size.width, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

@end