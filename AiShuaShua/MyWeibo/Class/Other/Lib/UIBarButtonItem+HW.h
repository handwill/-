//
//  UIBarButtonItem+HW.h
//  MyWeibo
//
//  Created by imac on 15/8/18.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HW)
+ (UIBarButtonItem *)itemWithNorImg:(NSString *)norImg HighImg:(NSString *)highImg target:(id)target action:(SEL)action;
@end
