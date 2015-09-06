//
//  HWProduct.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HWProduct.h"

@implementation HWProduct
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.title = dict[@"title"];
        self.scheme = dict[@"customUrl"];
        self.url = dict[@"url"];
        self.identifier = dict[@"id"];
//        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)productWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
