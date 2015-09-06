//
//  HWJokeFrame.h
//  MyWeibo
//
//  Created by imac on 15/8/21.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 正文的字体 */
#define HWJokeContentFont [UIFont systemFontOfSize:17]
/** 昵称的字体*/
#define HWJokeNameFont [UIFont systemFontOfSize:15]

/** 表格的边框宽度 */
#define HWJokeTableBorder 5

/** cell的边框宽度 */
#define HWJokeCellBorder 10

@class HWJoke;


@interface HWJokeFrame : NSObject

/*笑话模型数据*/
@property (nonatomic,strong)HWJoke *joke;

/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像view */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 名称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 正文*/
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/** 笑话的工具条 */
@property (nonatomic, assign, readonly) CGRect jokeToolbarF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
