//
//  HWNews.h
//  MyWeibo
//
//  Created by imac on 15/8/28.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWNews : NSObject
/**
 *  新闻标题
 */
@property (nonatomic,copy) NSString *id;
/**
 *  新闻标题
 */
@property (nonatomic,copy) NSString *newsTitle;
/**
 *  新闻url
 */
@property (nonatomic,copy) NSString *newsUrl;
/**
 *  新闻图片
 */
@property (nonatomic,copy) NSString *imgUrl;
/**
 *  新闻简介
 */
@property (nonatomic,copy) NSString *newsAbstract;
/**
 *  新闻时间
 */
@property (nonatomic,copy) NSString *time;
/**
 *  新闻评论数
 */
@property (nonatomic,copy) NSString *newsComments;

/**
 <news>
 <id>252784</id>
 <newUrl>http://xw.qq.com/mil/20150828210632/MIL2015082821063203</newUrl>
 <newsTitle>镜头下受阅女医疗兵训练的一天</newsTitle>
 <newsAbstract>起床后白求恩医疗方队女兵魏来整理内务，随后开始艰苦训练。</newsAbstract>
 <imgUrl>http://inews.gtimg.com/newsapp_lsa/0/59696797_685160/0</imgUrl>
 <time>3小时前</time>
 <newsComments>116</newsComments>
 <newsSource>腾讯新闻</newsSource>
 <newsSrcChannel>军事频道</newsSrcChannel>
 <newsChannel>null</newsChannel>
 <hasImg>0</hasImg>
 </news>
 */
@end
