//
//  HWTabBar.m
//  MyWeibo
//
//  Created by imac on 15/8/17.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWTabBar.h"
#import "HWTabBarButton.h"

@interface HWTabBar ()
/**
 *  记录被选中的按钮
 */
@property (nonatomic,weak)UIButton *selectBtn;
/**
 *  中间的加号按钮
 */
@property (nonatomic,weak)UIButton *addButton;
/**
 *  存储tanBar底部除加号按钮的其余按钮
 */
@property (nonatomic,strong) NSMutableArray *btnArray;

@end

@implementation HWTabBar

- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        
        
        
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{

    
    // 1.创建按钮
    HWTabBarButton *button = [[HWTabBarButton alloc] init];
    [self addSubview:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }

}




- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 按钮的frame数据
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.subviews.count; index++) {
        // 1.取出按钮
        HWTabBarButton *button = self.subviews[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}
- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)])
    {
        [self.delegate tabBar:self didSelectButtonFrom:self.selectBtn.tag to:button.tag];
    }
    
    // 1.取消原来按钮的选中状态
    self.selectBtn.selected = NO;
    // 2.被点击的按钮的设置为选中状态
    button.selected = YES;
    // 3.selectBtn重新赋值
    self.selectBtn = button;
    
  
}

@end
