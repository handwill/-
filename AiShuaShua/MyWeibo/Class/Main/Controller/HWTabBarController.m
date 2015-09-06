//
//  HWTabBarController.m
//  MyWeibo
//
//  Created by imac on 15/8/16.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWTabBarController.h"
#import "HWHomeViewController.h"
#import "HWMessageViewController.h"
#import "HWSettingViewController.h"
#import "HWNavigationViewController.h"
#import "HWNewsViewController.h"
#import "UIImage+HW.h"
#import "HWTabBar.h"
#import "HWTempWebNews.h"

@interface HWTabBarController () <HWTabBarDelegate>
/**
 *  自定义tabBar
 */
@property (nonatomic,strong) HWTabBar *customTabBar;
@end

@implementation HWTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
#warning 这里一定得先调用setupTabBar这个函数，不然后面的customTabBar为空
    [self setupTabBar];
    // 初始化所有的子控制器
    [self setupTabBarAllChildController];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // 一定别忘了调用这个方法
    [super viewWillAppear:animated];
    
    NSLog(@"%@",self.tabBar.subviews);
    for (UIView *childVw in self.tabBar.subviews) {
        if([childVw isKindOfClass:[UIControl class]])
        {
            [childVw removeFromSuperview];
        }
    }
    
}

/**
 *  自定义tabBar
 */
- (void)setupTabBar
{
    HWTabBar *customTabBar = [[HWTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    //customTabBar.backgroundColor = [UIColor redColor];
#warning 这里应该是添加到tabBar上去，如果添加到self.view上的话，跳转页面时自定义tabBar无法移除
    [self.tabBar addSubview:customTabBar];
    
    self.customTabBar = customTabBar;
    
    // 控制器成为代理
    self.customTabBar.delegate = self;
}

/**
 *  设置tabBarItem
 */
- (void)setupTabBarAllChildController
{
    // 1.刷微博
    HWHomeViewController *home = [[HWHomeViewController alloc] init];
    [self setupChildViewController:home title:@"刷微博" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    // 2.刷笑话
    HWMessageViewController *message = [[HWMessageViewController alloc] init];
    [self setupChildViewController:message title:@"刷笑话" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    // 3.刷新闻
    HWNewsViewController *news = [[HWNewsViewController alloc] init];
   // HWTempWebNews *news = [[HWTempWebNews alloc] init];
    [self setupChildViewController:news title:@"刷新闻" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    // 4.设置
    HWSettingViewController *me = [[HWSettingViewController alloc] init];
    [self setupChildViewController:me title:@"设置" imageName:@"navigationbar_more" selectedImageName:@"navigationbar_more_highlighted"];
    
    
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
   // childVc.tableView.backgroundColor = [UIColor redColor]
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 让选中的图片自定义，且去除系统渲染的蓝色
    childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    // 添加导航控制器
    HWNavigationViewController *nav = [[HWNavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma HWTabBarDelegate的代理方法
- (void)tabBar:(HWTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

@end
