//
//  HWTabBarButton.m
//  MyWeibo
//
//  Created by imac on 15/8/17.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWTabBarButton.h"
#import "HWBadgeButton.h"

@interface HWTabBarButton ()
/**
 *  每个按钮右上角显示数字的button
 */
@property (nonatomic,weak) HWBadgeButton *badgeBtn;
@end
// 图片的高度占据按钮高度的比例
#define HWTabBarButtonimageratio 0.6

@implementation HWTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            
            // 设置按钮选中时的图片
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }

        // 设置图片文字居中，这样就不会填充
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        // 设置badgeBtn的图片，并且可拉伸
        HWBadgeButton *badgeBtn = [[HWBadgeButton alloc] init];
         badgeBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeBtn];
        
        self.badgeBtn = badgeBtn;
        
        
    }
    return self;
}
/**
 *  重写此方法，设置按钮中图片的位置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageX = 0;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * HWTabBarButtonimageratio;
    
    return CGRectMake(imageX, imageY, imageW, imageH);

}

/**
 *  重写此方法，设置按钮中文字的位置
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * HWTabBarButtonimageratio;
    CGFloat titleX = 0;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

// 重写set方法
- (void)setItem:(UITabBarItem *)item
{
    _item = item;

    
    // KVO 观察item属性的变化
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
}

#warning 一定得记得移除监听
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"badgeValue"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    // 设置提醒数字
    self.badgeBtn.badgeValue = self.item.badgeValue;
    
    // 设置提醒数字的位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgeBtn.frame.size.width - 10;
    CGRect badgeF = self.badgeBtn.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeBtn.frame = badgeF;
    
  }

/**
 *  重写setHighlighted方法，取消高亮状态
 */
- (void)setHighlighted:(BOOL)highlighted
{}
@end
