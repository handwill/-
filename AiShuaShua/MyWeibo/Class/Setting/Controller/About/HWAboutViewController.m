//
//  HWAboutViewController.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HWAboutViewController.h"
#import "HWSettingArrowItem.h"
#import "HWSettingGroup.h"

@interface HWAboutViewController ()
//@property (nonatomic, strong) UIWebView *webView;
@end

@implementation HWAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectZero;
    [self.view addSubview:webView];
    
    // 1.具体数据
    HWSettingItem *mark = [HWSettingArrowItem itemWithTitle:@"评分支持" destVcClass:nil];
    mark.option = ^{
        NSString *appid = @"725296055";
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
        NSURL *url = [NSURL URLWithString:str];
        [[UIApplication sharedApplication] openURL:url];
    };
    
    HWSettingItem *call = [HWSettingArrowItem itemWithTitle:@"客户电话" destVcClass:nil];
    call.subtitle = @"10010";
    call.option = ^{
        NSURL *url = [NSURL URLWithString:@"tel://10010"];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
    };
    
    HWSettingGroup *group = [[HWSettingGroup alloc] init];
    group.items = @[mark, call];
    [self.data addObject:group];
    
}
@end
