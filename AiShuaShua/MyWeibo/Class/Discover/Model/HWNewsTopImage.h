//
//  HWNewsTopImage.h
//  AiShuaShua
//
//  Created by imac on 15/9/2.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWNewsTopImage : NSObject
/**
 * 新闻id
 */
@property (nonatomic,copy) NSString *id;
/**
 * 新闻详情URL
 */
@property (nonatomic,copy) NSString *newsUrl;
/**
 * 跳转后新闻标题
 */
@property (nonatomic,copy) NSString *newsTitle;
/**
 * 新闻标题
 */
@property (nonatomic,copy) NSString *newsAbstract;
/**
 * 新闻图片地址
 */
@property (nonatomic,copy) NSString *imgUrl;
/**
 * 新闻时间
 */
@property (nonatomic,copy) NSString *time;


/*
 <root>
 
	<news>
	<id>27581</id>
	<newUrl>http://xw.qq.com/mil/20150902032490/MIL2015090203249002</newUrl>
	<newsTitle>T-72高速撞墙 主装甲被生生撞碎</newsTitle>
	<newsAbstract>T-72高速撞墙 主装甲被生生撞碎</newsAbstract>
	<imgUrl>http://inews.gtimg.com/newsapp_ls/0/60584169_640330/0</imgUrl>
	<time>2015-09-02</time>
	<newsComments>0</newsComments>
	<newsSource>腾讯新闻</newsSource>
	<newsSrcChannel>军事频道</newsSrcChannel>
	<newsChannel>null</newsChannel>
	<hasImg>1</hasImg>
	</news>
 
 </root>
 
 */
@end
