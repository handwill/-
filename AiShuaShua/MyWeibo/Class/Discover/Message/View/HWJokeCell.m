//
//  HWJokeCell.m
//  MyWeibo
//
//  Created by imac on 15/8/21.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWJokeCell.h"
#import "HWJokeFrame.h"
#import "HWJoke.h"
#import "UIImageView+WebCache.h"
#import "HWJokeToolBar.h"

@interface HWJokeCell ()
/** 顶部的view */
@property (nonatomic, weak) UIImageView *topView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 微博的工具条 */
@property (nonatomic, weak) HWJokeToolBar *jokeToolbar;

@end

@implementation HWJokeCell

+ (HWJokeCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"joke";
    HWJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HWJokeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
         NSLog(@"%s",__func__);
        
        
        // 3.添加微博的工具条
        [self setupJokeToolBar];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{
    // 0.设置cell选中时的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    
    /** 1.顶部的view */
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    topView.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    
    /** 2.头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /** 5.昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = HWJokeNameFont;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    
    /** 8.正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = HWColor(39, 39, 39);
    contentLabel.font = HWJokeContentFont;
    contentLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
}

/**
 *  添加微博的工具条
 */
- (void)setupJokeToolBar
{
    /** 1.微博的工具条 */
    HWJokeToolBar *jokeToolbar = [[HWJokeToolBar alloc] init];
    jokeToolbar.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
    jokeToolbar.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
    [self.contentView addSubview:jokeToolbar];
    self.jokeToolbar = jokeToolbar;
    
}

/**
 *  拿到frame模型，设置尺寸
 */
- (void)setJokeFrame:(HWJokeFrame *)jokeFrame
{
    _jokeFrame = jokeFrame;
    
    // 1.正文
    [self setupOriginalDataFrame];

    
    // 3.笑话工具条
    [self setupJokeToolbarFrame];
    
}

/**
 *  正文尺寸
 */
- (void)setupOriginalDataFrame
{
    HWJoke *joke = self.jokeFrame.joke;

    
    // 1.topView
    self.topView.frame = self.jokeFrame.topViewF;
    
    // 2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.jokeFrame.joke.pathimg] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.jokeFrame.iconViewF;
    
    // 3.昵称
    self.nameLabel.text = joke.nickname;
    self.nameLabel.frame = self.jokeFrame.nameLabelF;
    
    // 4.正文
    self.contentLabel.text = joke.content;
    self.contentLabel.frame = self.jokeFrame.contentLabelF;

}

/**
 *  笑话工具条
 */
- (void)setupJokeToolbarFrame
{
    self.jokeToolbar.frame = self.jokeFrame.jokeToolbarF;
    // 传递模型数据
    self.jokeToolbar.joke = self.jokeFrame.joke;
}

@end
