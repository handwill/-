//
//  UIImage+HW.h
//  MyWeibo
//
//  Created by imac on 15/8/17.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HW)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end
