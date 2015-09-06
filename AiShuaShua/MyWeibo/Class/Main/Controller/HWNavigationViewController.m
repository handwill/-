//
//  HWNavigationViewController.m
//  MyWeibo
//
//  Created by imac on 15/8/18.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWNavigationViewController.h"

@interface HWNavigationViewController ()

@end

@implementation HWNavigationViewController

/**
 *   第一次使用这个类就会调用，并且只会调用一次
 */
+ (void)initialize
{
    // 设置导航栏主题
    [self setupNavBarTheme];
    // 设置导航栏的item
    [self setupNavBarItem];
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置标题属性
    NSMutableDictionary *textAttri = [NSMutableDictionary dictionary];
    textAttri[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttri[NSFontAttributeName] = [UIFont systemFontOfSize:19];
    
    [navBar setTitleTextAttributes:textAttri];
}
/**
 *  设置导航栏的item
 */
+ (void)setupNavBarItem
{
    UIBarButtonItem *bavItm = [UIBarButtonItem appearance];
    if (!iOS7) {
        
        [bavItm setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [bavItm setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [bavItm setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    // 设置标题属性
    NSMutableDictionary *textAttri = [NSMutableDictionary dictionary];
    textAttri[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttri[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [bavItm setTitleTextAttributes:textAttri forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 拦截所有的push过程，是得底部的tabBar隐藏
    if (self.viewControllers.count > 0 ) { // 根控制器的tabBar不能隐藏
            viewController.hidesBottomBarWhenPushed = YES;
    }
# warning 这里得调用父类的方法
    [super pushViewController:viewController animated:YES];
}

@end
