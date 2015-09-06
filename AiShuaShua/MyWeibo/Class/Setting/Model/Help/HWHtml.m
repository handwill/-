//
//  HWHtml.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HWHtml.h"

@implementation HWHtml
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.html = dict[@"html"];
        self.title = dict[@"title"];
        self.ID = dict[@"id"];
    }
    return self;
}

+ (instancetype)htmlWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
