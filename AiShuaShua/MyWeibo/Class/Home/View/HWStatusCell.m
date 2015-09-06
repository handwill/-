//
//  HWStatusCell.m
//  MyWeibo
//
//  Created by imac on 15/8/21.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWStatusCell.h"
#import "HWStatus.h"
#import "HWStatusFrame.h"
#import "HWUsers.h"
#import "UIImageView+WebCache.h"
#import "HWStatusToolBar.h"
#import "HWRetweetView.h"
#import "HWStatusTopView.h"

@interface HWStatusCell()
/** 顶部的view */
@property (nonatomic, weak) HWStatusTopView *topView;


/** 微博的工具条 */
@property (nonatomic, weak) HWStatusToolBar *statusToolbar;
@end


@implementation HWStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    HWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = YES;
        
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        
        // 3.添加微博的工具条
        [self setupStatusToolBar];
        
    }
    return self;
}


/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{
    // 0.设置cell选中时的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    
    /** 1.顶部的view */
    HWStatusTopView *topView = [[HWStatusTopView alloc] init];
    
    [self.contentView addSubview:topView];
     self.topView = topView;
   
}



/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar
{
    /** 1.微博的工具条 */
    HWStatusToolBar *statusToolbar = [[HWStatusToolBar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += HWStatusTableBorder;
    frame.origin.x = HWStatusTableBorder;
    frame.size.width -= 2 * HWStatusTableBorder;
    frame.size.height -= HWStatusTableBorder;
    [super setFrame:frame];
}

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(HWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.原创微博
    [self setupOriginalData];
    
    // 3.微博工具条
    [self setupStatusToolbar];
}

/**
 *  微博工具条
 */
- (void)setupStatusToolbar
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    self.statusToolbar.status = self.statusFrame.status;
}

/**
 *  原创微博
 */
- (void)setupOriginalData
{
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.传递模型数据
    self.topView.statusFrame = self.statusFrame;
   
}

@end
