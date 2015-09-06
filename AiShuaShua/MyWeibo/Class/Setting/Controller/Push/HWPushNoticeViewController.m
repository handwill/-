//
//  HWPushNoticeViewController.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HWPushNoticeViewController.h"
#import "HWSettingArrowItem.h"
#import "HWSettingSwitchItem.h"
#import "HWSettingGroup.h"
#import "MBProgressHUD+MJ.h"
#import "HWProductViewController.h"
#import "HWPushNoticeViewController.h"
#import "HWAwardPushViewController.h"
#import "HWAwardAnimViewController.h"
#import "HWScoreTimeViewController.h"

@interface HWPushNoticeViewController ()
@end

@implementation HWPushNoticeViewController
/**
 *  第0组数据
 */
- (void)setupGroup0
{
    HWSettingItem *awardPush = [HWSettingArrowItem itemWithTitle:@"开奖号码推送" destVcClass:[HWAwardPushViewController class]];
    HWSettingItem *awardAnim = [HWSettingArrowItem itemWithTitle:@"中奖动画" destVcClass:[HWAwardAnimViewController class]];
    HWSettingItem *scoreTime = [HWSettingArrowItem itemWithTitle:@"比分直播提醒" destVcClass:[HWScoreTimeViewController class]];
    HWSettingItem *pushNotice4 = [HWSettingArrowItem itemWithTitle:@"购彩定时提醒" destVcClass:nil];
    
    HWSettingGroup *group = [[HWSettingGroup alloc] init];
    group.items = @[awardPush, awardAnim, scoreTime, pushNotice4];
    [self.data addObject:group];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
}
@end
