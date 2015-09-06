//
//  HWAccountTool.h
//  MyWeibo
//
//  Created by imac on 15/8/20.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWAccount;
@interface HWAccountTool : NSObject
/**
 *  存储账号
 */
+ (void)saveAccount:(HWAccount *)account;
/**
 *  取出账号
 */
+ (HWAccount *)account;
@end
