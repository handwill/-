//
//  HWNewsCell.m
//  MyWeibo
//
//  Created by imac on 15/8/27.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWNewsCell.h"
#import "HWNews.h"
#import "UIImageView+WebCache.h"

@interface HWNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation HWNewsCell

+ (HWNewsCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"News";
    HWNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HWNewsCell" owner:nil options:nil] lastObject];
        
    }
    return cell;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//  
//}

/**
 *  得到模型数据,对cell赋值
 */
- (void)setNews:(HWNews *)news
{
    _news = news;
    // 新闻标题
    self.newsTitle.text = news.newsTitle;
    // 新闻图片
    [self.newsImage sd_setImageWithURL:[NSURL URLWithString:news.imgUrl] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    self.timeLabel.text = news.time;
    self.commentLabel.text = [NSString stringWithFormat:@"评论%@",news.newsComments];
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
