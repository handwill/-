//
//  HWAwardPushViewController.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HWAwardPushViewController.h"
#import "HWSettingSwitchItem.h"
#import "HWSettingGroup.h"

@interface HWAwardPushViewController ()

@end

@implementation HWAwardPushViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HWSettingItem *ball = [HWSettingSwitchItem itemWithTitle:@"双色球"];
    
    HWSettingItem *letou = [HWSettingSwitchItem itemWithTitle:@"大乐透"];
    
    HWSettingGroup *group = [[HWSettingGroup alloc] init];
    group.items = @[ball, letou];
    group.header = @"打开设置即可在开奖后立即收到推送消息，获知开奖号码";
    [self.data addObject:group];
}

@end
