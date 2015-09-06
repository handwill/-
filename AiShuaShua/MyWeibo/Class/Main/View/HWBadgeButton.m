//
//  HWBadgeButton.m
//  MyWeibo
//
//  Created by imac on 15/8/17.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWBadgeButton.h"

@implementation HWBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        // 设置badgeBtn始终贴着右上角
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        // 设置字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
#warning copy
    //    _badgeValue = badgeValue;
    _badgeValue = [badgeValue copy];
    
    // 设置数字显示位置
    if (badgeValue > 0) {
        self.hidden = NO;
        
        [self setTitle:self.badgeValue forState:UIControlStateNormal];
        // 设置提醒数字的位置
        CGRect frame;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        // 给badgebutton设置frame
        self.frame = frame;
    }else
    {
        self.hidden = YES;
    }
    


}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
