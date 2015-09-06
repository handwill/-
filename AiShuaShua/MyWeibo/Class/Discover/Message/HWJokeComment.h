//
//  HWJokeComment.h
//  MyWeibo
//
//  Created by imac on 15/8/25.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWJokeComment : NSObject

/**
 *  用户编号
 */
@property (nonatomic,copy) NSString *userid;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString *nickname;
/**
 *  头像地址
 */
@property (nonatomic,copy) NSString *pathimg;

/**
 *  评论内容
 */
@property (nonatomic,copy) NSString *comment;
/**
 *  点赞数
 */
@property (nonatomic,copy) NSString *praise;


/*
 "userid": "3098",
 "nickname": "我是萌夫@",
 "pathimg": "http://jbls.qingyou.cn/upload/userimg/2014-12-18/1987.jpg",
 "cid": "1551831",
 "comment": "唐僧再能也是个耍猴的；悟空再能也是个耍棍的。",
 "praise": "4",
 "stype": "0",
 "addtime": "2015-08-07 22:13:58"
 */
@end
