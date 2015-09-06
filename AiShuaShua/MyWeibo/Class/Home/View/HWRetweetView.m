//
//  HWRetweetView.m
//  MyWeibo
//
//  Created by imac on 15/8/22.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWRetweetView.h"
#import "HWStatus.h"
#import "HWStatusFrame.h"
#import "HWUsers.h"
#import "UIImageView+WebCache.h"
#import "HWPhoto.h"
#include "HWPhotosView.h"

@interface HWRetweetView ()

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) HWPhotosView *retweetPhotosView;

@end

@implementation HWRetweetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        self.retweetView = self;
        
        
        /** 2.被转发微博作者的昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = HWRetweetStatusNameFont;
        retweetNameLabel.textColor = HWColor(67, 107, 163);
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        [self.retweetView addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        /** 3.被转发微博的正文\内容 */
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = HWRetweetStatusContentFont;
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.textColor = HWColor(90, 90, 90);
        [self.retweetView addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        /** 4.被转发微博的配图 */
        HWPhotosView *retweetPhotosView = [[HWPhotosView alloc] init];
        [self addSubview:retweetPhotosView];
        self.retweetPhotosView = retweetPhotosView;
    }
    return self;
}



- (void)layoutSubviews
{
    HWStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    HWUsers *user = retweetStatus.user;
    
    // 1.父控件
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 2.昵称
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        // 3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 3.配图
        if (retweetStatus.pic_urls.count) {
            self.retweetPhotosView.hidden = NO;
            self.retweetPhotosView.frame = self.statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = retweetStatus.pic_urls;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
   }
}



@end
