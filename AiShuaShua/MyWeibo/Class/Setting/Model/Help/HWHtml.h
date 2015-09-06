//
//  HWHtml.h
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWHtml : NSObject
/**
 *  网页标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  网页文件名
 */
@property (nonatomic, copy) NSString *html;

@property (nonatomic, copy) NSString *ID;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)htmlWithDict:(NSDictionary *)dict;
@end
