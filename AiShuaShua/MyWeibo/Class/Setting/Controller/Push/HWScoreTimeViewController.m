//
//  HWScoreTimeViewController.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HWScoreTimeViewController.h"
#import "HWSettingLabelItem.h"
#import "HWSettingSwitchItem.h"
#import "HWSettingGroup.h"

@interface HWScoreTimeViewController ()

@end

@implementation HWScoreTimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 0组
    HWSettingItem *notice = [HWSettingSwitchItem itemWithTitle:@"提醒我关注的比赛"];
    
    HWSettingGroup *group0 = [[HWSettingGroup alloc] init];
    group0.items = @[notice];
    group0.footer = @"当我关注的比赛比分发生变化时，通过小弹窗或推送进行提醒";
    [self.data addObject:group0];
    
    // 1组
    HWSettingItem *satrtTime = [HWSettingLabelItem itemWithTitle:@"起始时间"];
    
    HWSettingGroup *group1 = [[HWSettingGroup alloc] init];
    group1.items = @[satrtTime];
    group1.header = @"只在以下时间接受比分直播";
    [self.data addObject:group1];
    
    // 2组
    HWSettingItem *endTime = [HWSettingLabelItem itemWithTitle:@"结束时间"];
    
    HWSettingGroup *group2 = [[HWSettingGroup alloc] init];
    group2.items = @[endTime];
    [self.data addObject:group2];
}

@end
