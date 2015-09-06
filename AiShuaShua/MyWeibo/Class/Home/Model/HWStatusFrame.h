//
//  HWStatusFrame.h
//  MyWeibo
//
//  Created by imac on 15/8/21.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWStatus;


/** 昵称的字体 */
#define HWStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define HWRetweetStatusNameFont HWStatusNameFont

/** 时间的字体 */
#define HWStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define HWStatusSourceFont HWStatusTimeFont

/** 正文的字体 */
#define HWStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define HWRetweetStatusContentFont HWStatusContentFont

/** 表格的边框宽度 */
#define HWStatusTableBorder 5

/** cell的边框宽度 */
#define HWStatusCellBorder 10

@interface HWStatusFrame : NSObject

@property (nonatomic, strong) HWStatus *status;

/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;

/** 配图 */
@property (nonatomic, assign, readonly) CGRect photosViewF;
/** 配图 */
//@property (nonatomic, assign, readonly) CGRect photoViewF;

/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/** 被转发微博的view(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/** 被转发微博作者的昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;

/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotosViewF;
/** 被转发微博的配图 */
//@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;

/** 微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statusToolbarF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
