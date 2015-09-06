//
//  HWJokeComFrame.h
//  MyWeibo
//
//  Created by imac on 15/8/25.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 表格边距*/
#define HWJokeTableBorder 5
/** cell的边框宽度 */
#define HWJokeCellBorder 10
/** 正文的字体 */
#define HWJokeContentFont [UIFont boldSystemFontOfSize:15]
/** 昵称的字体*/
#define HWJokeNameFont [UIFont systemFontOfSize:15]

@class HWJokeComment;


@interface HWJokeComFrame : NSObject

/** 所有子控件的父视图 */
@property (nonatomic, assign, readonly) CGRect comtSuperViewF;
/** 头像view */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 名称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 正文*/
@property (nonatomic, assign, readonly) CGRect commentLabelF;
/** 点赞按钮的位置*/
@property (nonatomic, assign, readonly) CGRect praiseBtnF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/**
 *  模型数据
 */
@property (nonatomic,strong) HWJokeComment *jokeComment;
@end
