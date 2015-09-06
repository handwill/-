//
//  HWJokeCommentCell.m
//  MyWeibo
//
//  Created by imac on 15/8/25.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWJokeCommentCell.h"
#import "HWJokeComFrame.h"
#import "HWJokeComment.h"
#import "UIImageView+WebCache.h"
#import "HWPraiseButton.h"

@interface HWJokeCommentCell ()

/** 顶部的view */
@property (nonatomic, weak) UIImageView *comtSuperView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *commentLabel;
/** 点赞按钮的位置*/
@property (nonatomic, strong) HWPraiseButton *praiseBtn;



@end



@implementation HWJokeCommentCell

+ (HWJokeCommentCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ceshi";
    HWJokeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HWJokeCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
  
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 0.设置cell选中时的背景
        self.selectedBackgroundView = [[UIView alloc] init];
        
        /** 1.顶部的view */
        UIImageView *comtSuperView = [[UIImageView alloc] init];
        comtSuperView.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        comtSuperView.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        [self.contentView addSubview:comtSuperView];
        self.comtSuperView = comtSuperView;
        
        
        /** 2.头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.comtSuperView addSubview:iconView];
        self.iconView = iconView;
        
        /** 3.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = HWJokeNameFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self.comtSuperView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 4.点赞按钮 */
        HWPraiseButton *praiseBtn = [[HWPraiseButton alloc] init];
        [self.comtSuperView addSubview:praiseBtn];
        self.praiseBtn = praiseBtn;
        
        /** 8.正文\内容 */
        UILabel *commentLabel = [[UILabel alloc] init];
        commentLabel.numberOfLines = 0;
        commentLabel.textColor = HWColor(39, 39, 39);
        commentLabel.font = HWJokeContentFont;
        commentLabel.backgroundColor = [UIColor clearColor];
        [self.comtSuperView addSubview:commentLabel];
        self.commentLabel = commentLabel;
        
    }
    return self;
}

/**
 *  重写set方法，设置子控件的frame
 *
 */
- (void)setJokeComFrame:(HWJokeComFrame *)jokeComFrame
{
    _jokeComFrame = jokeComFrame;
    
    // 1.topView
    self.comtSuperView.frame = self.jokeComFrame.comtSuperViewF;
    
    // 2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.jokeComFrame.jokeComment.pathimg] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.jokeComFrame.iconViewF;
    
    // 3.昵称
    self.nameLabel.text = self.jokeComFrame.jokeComment.nickname;
    self.nameLabel.frame = self.jokeComFrame.nameLabelF;
    
    // 4.点赞数
    [self.praiseBtn setTitle:self.jokeComFrame.jokeComment.praise forState:UIControlStateNormal];
    [self.praiseBtn setImage:[UIImage imageWithName:@"timeline_icon_unlike"] forState:UIControlStateNormal];
    self.praiseBtn.frame = self.jokeComFrame.praiseBtnF;
    
    // 5.正文
    self.commentLabel.text = self.jokeComFrame.jokeComment.comment;
    self.commentLabel.frame = self.jokeComFrame.commentLabelF;
    
}


@end
