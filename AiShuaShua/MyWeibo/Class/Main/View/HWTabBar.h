//
//  HWTabBar.h
//  MyWeibo
//
//  Created by imac on 15/8/17.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWTabBar;

@protocol  HWTabBarDelegate <NSObject>
// 协议
@optional
- (void)tabBar:(HWTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface HWTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic,weak) id <HWTabBarDelegate> delegate;
@end
