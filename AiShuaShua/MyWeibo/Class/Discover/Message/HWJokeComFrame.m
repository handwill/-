//
//  HWJokeComFrame.m
//  MyWeibo
//
//  Created by imac on 15/8/25.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWJokeComFrame.h"
#import "HWJokeComment.h"
#import "HWPraiseButton.h"



@implementation HWJokeComFrame

/**
 *  得到模型重写set方法
 */
- (void)setJokeComment:(HWJokeComment *)jokeComment
{
    _jokeComment = jokeComment;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * HWJokeTableBorder;
    
    // 1.topView
    CGFloat comtSuperViewW = cellW;
    CGFloat comtSuperViewH = 0;
    CGFloat comtSuperViewX = HWJokeTableBorder;
    CGFloat comtSuperViewY = 0;
    
    // 头像的位置
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = HWJokeCellBorder;
    CGFloat iconViewY = HWJokeCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称的位置
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + HWJokeCellBorder;
    CGFloat nameLabelY = iconViewY;
    //CGSize nameLabelSize = [self.joke.nickname sizeWithFont:HWJokeNameFont];
    NSDictionary *attrs = @{NSFontAttributeName : HWJokeNameFont};
    CGSize nameLabelSize = [self.jokeComment.nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    _nameLabelF = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    

    
    // 评论内容位置
    CGFloat commentlabelX = nameLabelX;
    CGFloat commentlabelY = CGRectGetMaxY(_iconViewF) + HWJokeCellBorder;
    NSDictionary *commentattr = @{NSFontAttributeName:HWJokeContentFont};
    // 评论文字的宽度
    CGFloat commentContentX = [UIScreen mainScreen].bounds.size.width - nameLabelX - HWJokeTableBorder - HWJokeCellBorder;
    CGSize commentSize = [self.jokeComment.comment boundingRectWithSize:CGSizeMake(commentContentX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:commentattr context:nil].size;
    _commentLabelF = (CGRect){{commentlabelX,commentlabelY},commentSize};
    
    // 点赞按钮的位置
    CGFloat praiseBtnH = 30;
    CGFloat praiseBtnY = iconViewY;
    CGSize praiseNumSize = [self.jokeComment.praise boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:commentattr context:nil].size;
    CGFloat praiseBtnW = praiseNumSize.width + 30 + HWJokeCellBorder;
    CGFloat praiseBtnX = [UIScreen mainScreen].bounds.size.width - HWJokeTableBorder - HWJokeCellBorder - praiseBtnW;
    _praiseBtnF = CGRectMake(praiseBtnX, praiseBtnY, praiseBtnW, praiseBtnH);
    
    // 父视图的位置
    comtSuperViewH = CGRectGetMaxY(_commentLabelF);
    comtSuperViewH += HWJokeCellBorder;
    _comtSuperViewF = CGRectMake(comtSuperViewX, comtSuperViewY, comtSuperViewW, comtSuperViewH);
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_commentLabelF) + HWJokeCellBorder;
    
    
}
@end
