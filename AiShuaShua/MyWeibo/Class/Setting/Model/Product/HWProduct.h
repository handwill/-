//
//  HWProduct.h
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

/**
 *  
 "title": "网易电影票",
 "icon": "movie@2x.png",
 "id": "com.netease.movie",
 "url": "http://itunes.apple.com/app/id583784224?mt=8",
 "customUrl": "movieticket163"
 */

#import <Foundation/Foundation.h>

@interface HWProduct : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *scheme; // 打开应用所用的URL
@property (nonatomic, copy) NSString *url; // 下载应用的URL
@property (nonatomic, copy) NSString *identifier;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)productWithDict:(NSDictionary *)dict;
@end
