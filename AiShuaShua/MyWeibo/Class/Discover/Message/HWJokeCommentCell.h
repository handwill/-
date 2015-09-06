//
//  HWJokeCommentCell.h
//  MyWeibo
//
//  Created by imac on 15/8/25.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWJokeComFrame;
@interface HWJokeCommentCell : UITableViewCell

@property (nonatomic,strong)HWJokeComFrame *jokeComFrame;

+ (HWJokeCommentCell *)cellWithTableView:(UITableView *)tableView;
@end
