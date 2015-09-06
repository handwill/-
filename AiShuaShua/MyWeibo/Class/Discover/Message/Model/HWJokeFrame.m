//
//  HWJokeFrame.m
//  MyWeibo
//
//  Created by imac on 15/8/21.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWJokeFrame.h"
#import "HWJoke.h"




@implementation HWJokeFrame

/**
 *  得到模型，设置frame
 */
- (void)setJoke:(HWJoke *)joke
{
    _joke = joke;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * HWJokeTableBorder;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = HWJokeTableBorder;
    CGFloat topViewY = 0;
    
    // 2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = HWJokeCellBorder;
    CGFloat iconViewY = HWJokeCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + HWJokeCellBorder;
    CGFloat nameLabelY = iconViewY;
    //CGSize nameLabelSize = [self.joke.nickname sizeWithFont:HWJokeNameFont];
    NSDictionary *attrs = @{NSFontAttributeName : HWJokeNameFont,NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    CGSize nameLabelSize = [self.joke.nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _nameLabelF = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    
    // 正文
    CGFloat contentlabelX = iconViewX;
    CGFloat contentlabelY = CGRectGetMaxY(_iconViewF) + HWJokeCellBorder;
    NSDictionary *contentattr = @{NSFontAttributeName:HWJokeContentFont};
    CGSize contentSize = [self.joke.content boundingRectWithSize:CGSizeMake(topViewW - 2*HWJokeCellBorder, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:contentattr context:nil].size;
    _contentLabelF = (CGRect){{contentlabelX,contentlabelY},contentSize};
    
    // 头部View的尺寸
    topViewH = CGRectGetMaxY(_contentLabelF);
    topViewH += HWJokeCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 13.工具条
    CGFloat jokeToolbarX = topViewX;
    CGFloat jokeToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat jokeToolbarW = topViewW;
    CGFloat jokeToolbarH = 35;
    _jokeToolbarF = CGRectMake(jokeToolbarX, jokeToolbarY, jokeToolbarW, jokeToolbarH);
    
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_jokeToolbarF) + HWJokeCellBorder;
    
}


@end
