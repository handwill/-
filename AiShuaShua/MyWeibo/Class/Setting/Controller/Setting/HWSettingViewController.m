//
//  HWSettingViewController.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HWSettingViewController.h"
#import "HWSettingArrowItem.h"
#import "HWSettingSwitchItem.h"
#import "HWSettingGroup.h"
#import "MBProgressHUD+MJ.h"
#import "HWProductViewController.h"
#import "HWPushNoticeViewController.h"
#import "HWShareViewController.h"
#import "HWAboutViewController.h"

@interface HWSettingViewController ()
@end

@implementation HWSettingViewController
/**
 *  第1组数据
 */
- (void)setupGroup1
{
    HWSettingItem *update = [HWSettingArrowItem itemWithIcon:@"MoreUpdate" title:@"检查新版本"];
    update.option = ^{
//        // 弹框提示
//        [MBProgressHUD showMessage:@"正在拼命检查中....."];
        
#warning 发送网络请求
        // 几秒后消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 移除HUD
//            [MBProgressHUD hideHUD];
            
            // 提醒有没有新版本
            [MBProgressHUD showError:@"没有新版本"];

        });

    };
    HWSettingItem *help = [HWSettingArrowItem itemWithIcon:@"MoreHelp" title:@"帮助" destVcClass:nil];
    HWSettingItem *share = [HWSettingArrowItem itemWithIcon:@"MoreShare" title:@"分享" destVcClass:[HWShareViewController class]];
    HWSettingItem *viewMsg = [HWSettingArrowItem itemWithIcon:@"MoreMessage" title:@"查看消息" destVcClass:nil];
    
    __weak typeof(self) selfVc = self;
    viewMsg.option = ^{
        NSLog(@"%@", selfVc.tableView.subviews);
    };
    
    HWSettingItem *product = [HWSettingArrowItem itemWithIcon:@"MoreNetease" title:@"产品推荐" destVcClass:[HWProductViewController class]];
    HWSettingItem *about = [HWSettingArrowItem itemWithIcon:@"MoreAbout" title:@"关于" destVcClass:[HWAboutViewController class]];
    
    HWSettingGroup *group = [[HWSettingGroup alloc] init];
    group.items = @[update, help, share, viewMsg, product, about];
    [self.data addObject:group];
}

/**
 *  第0组数据
 */
- (void)setupGroup0
{

    HWSettingItem *soundEffect = [HWSettingSwitchItem itemWithIcon:@"sound_Effect" title:@"声音效果"];
    HWSettingItem *statusNotice = [HWSettingSwitchItem itemWithIcon:@"MorePush" title:@"微博消息推送"];
    HWSettingItem *jokeNotice = [HWSettingSwitchItem itemWithIcon:@"MorePush" title:@"笑话消息推送"];
    HWSettingItem *newsNotice = [HWSettingSwitchItem itemWithIcon:@"MorePush" title:@"新闻消息推送"];
    
    HWSettingGroup *group = [[HWSettingGroup alloc] init];
    group.items = @[statusNotice, jokeNotice, newsNotice,soundEffect];
    [self.data addObject:group];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //93 111 116
   // [self.view setBackgroundColor:HWColor(93, 111, 116)];
    // 1.标题
    self.title = @"设置";
    
    // 2.添加数据
    [self setupGroup0];
    [self setupGroup1];
}
@end
