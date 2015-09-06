//
//  HWNewsCell.h
//  MyWeibo
//
//  Created by imac on 15/8/27.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWNews;
@interface HWNewsCell : UITableViewCell
@property (nonatomic,strong) HWNews *news;
+ (HWNewsCell *)cellWithTableView:(UITableView *)tableView;
@end
