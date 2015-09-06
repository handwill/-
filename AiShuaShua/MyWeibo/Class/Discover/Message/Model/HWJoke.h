//
//  HWJoke.h
//  MyWeibo
//
//  Created by imac on 15/8/21.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWJoke : NSObject

/**
 *  笑话id
 */
@property (nonatomic,copy)NSString *id;
/**
 *  笑话内容
 */
@property (nonatomic,copy)NSString *content;
/**
 *  用户名称
 */
@property (nonatomic,copy)NSString *nickname;
/**
 *  头像地址
 */
@property (nonatomic,copy)NSString *pathimg;
/**
 *  点赞数
 */
//@property (nonatomic,copy)NSString *nopraise;
/**
 *  点赞数
 */
@property (nonatomic,copy)NSString *praise;
/**
 *  收藏数
 */
@property (nonatomic,copy)NSString *coll;

/**
 *  转发数
 */
@property (nonatomic,copy)NSString *forward;
/**
 *  评论数
 */
@property (nonatomic,copy)NSString *coms;

/**
 *  时间
 */
@property (nonatomic,copy)NSString *addtime;


@end
