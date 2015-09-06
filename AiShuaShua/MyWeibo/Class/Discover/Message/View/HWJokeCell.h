//
//  HWJokeCell.h
//  MyWeibo
//
//  Created by imac on 15/8/21.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWJokeFrame;
@interface HWJokeCell : UITableViewCell

@property (nonatomic,strong)HWJokeFrame *jokeFrame;

+ (HWJokeCell *)cellWithTableView:(UITableView *)tableView;
@end
