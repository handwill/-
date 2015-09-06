//
//  HWAccountTool.m
//  MyWeibo
//
//  Created by imac on 15/8/20.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWAccountTool.h"
#import "HWAccount.h"

@implementation HWAccountTool
/**
 *  存储账号
 */
+ (void)saveAccount:(HWAccount *)account
{
    // 取出路径
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingFormat:@"/account.data"];
    
    NSLog(@"%@",file);
    
    // 计算账号的过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    // 存储文件
    [NSKeyedArchiver archiveRootObject:account toFile:file];
}
/**
 *  取出账号
 */
+ (HWAccount *)account
{
    // 取出路径
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingFormat:@"/account.data"];
    HWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:file]];
    
    NSLog(@"-----%@",account);
    
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) { // 还没有过期
        return account;
    } else { // 过期
        return nil;
    }

}

@end
