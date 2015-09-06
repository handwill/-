//
//  UIBarButtonItem+HW.m
//  MyWeibo
//
//  Created by imac on 15/8/18.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "UIBarButtonItem+HW.h"

@implementation UIBarButtonItem (HW)
+ (UIBarButtonItem *)itemWithNorImg:(NSString *)norImg HighImg:(NSString *)highImg target:(id)target action:(SEL)action
{
    UIButton *Button = [[UIButton alloc] init];
    [Button setBackgroundImage:[UIImage imageWithName:norImg] forState:UIControlStateNormal];
    [Button setBackgroundImage:[UIImage imageWithName:highImg] forState:UIControlStateHighlighted];
    Button.frame = CGRectMake(0, 0, Button.currentBackgroundImage.size.width, Button.currentBackgroundImage.size.height);
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:Button];
}
@end
