//
//  HWNewsTopCell.h
//  MyWeibo
//
//  Created by imac on 15/8/28.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWNewsTopCell : UITableViewCell

+ (HWNewsTopCell *)cellWithTableView:(UITableView *)tableView;
-(void)updataSouce:(NSMutableArray *)imageArr;
@end
