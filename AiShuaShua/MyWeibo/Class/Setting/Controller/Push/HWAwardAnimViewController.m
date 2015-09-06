//
//  HWAwardAnimViewController.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HWAwardAnimViewController.h"
#import "HWSettingSwitchItem.h"
#import "HWSettingGroup.h"

@interface HWAwardAnimViewController ()

@end

@implementation HWAwardAnimViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HWSettingItem *anim = [HWSettingSwitchItem itemWithTitle:@"中奖动画"];
    
    HWSettingGroup *group = [[HWSettingGroup alloc] init];
    group.items = @[anim];
    group.header = @"当您有新中奖订单，启动程序时通过动画提醒您。为避免过于频繁，高频彩不会提醒。";
    [self.data addObject:group];
}
@end
