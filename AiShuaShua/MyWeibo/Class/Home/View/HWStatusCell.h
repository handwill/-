//
//  HWStatusCell.h
//  MyWeibo
//
//  Created by imac on 15/8/21.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWStatusFrame;

@interface HWStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) HWStatusFrame *statusFrame;

@end
