//
//  HWPhotosView.h
//  MyWeibo
//
//  Created by imac on 15/8/23.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWPhotosView : UIImageView
/**
 *  需要展示的图片(数组里面装的都是IWPhoto模型)
 */
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;
@end
