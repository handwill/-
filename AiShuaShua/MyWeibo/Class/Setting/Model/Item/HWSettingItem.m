//
//  HWSettingItem.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HWSettingItem.h"

@implementation HWSettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    HWSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}


+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}
@end
