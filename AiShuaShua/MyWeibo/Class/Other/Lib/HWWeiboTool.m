//
//  HWWeiboTool.m
//  MyWeibo
//
//  Created by imac on 15/8/20.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWWeiboTool.h"
#import "HWTabBarController.h"
#import "HWNewFeatureVController.h"

@implementation HWWeiboTool

+ (void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[HWTabBarController alloc] init];
    } else { // 新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[HWNewFeatureVController alloc] init];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }

}
@end
