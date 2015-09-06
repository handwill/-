//
//  HWNewFeatureVController.m
//  MyWeibo
//
//  Created by imac on 15/8/19.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWNewFeatureVController.h"
#import "HWTabBarController.h"

#define HWNewFeatureImageCount 3

@interface HWNewFeatureVController () <UIScrollViewDelegate>
@property (nonatomic,weak)UIPageControl *page;
@property (nonatomic,weak)UIScrollView *scroll;
@end

@implementation HWNewFeatureVController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 设置scrollView
    [self setupScrollView];
    [self setupPageing];
}

- (void) setupScrollView
{
    // 1.添加UIScrollView
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    scroll.frame = self.view.bounds;
    CGFloat imageW = self.view.bounds.size.width;
    CGFloat imageH = self.view.bounds.size.height;
    // 添加图片
    for (int index = 0; index < HWNewFeatureImageCount; index++) {
        NSString *strImage = [[NSString alloc] initWithFormat:@"new_feature_%d",index + 1];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageWithName:strImage]];
        CGFloat imageX = index * imageW;
        image.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        // 在最后一个图片上面添加按钮
        if (index == HWNewFeatureImageCount - 1) {
            [self setupLastImageView:image];
        }
        
        [scroll addSubview:image];
    }
    // 去除下面的导航栏
    scroll.showsHorizontalScrollIndicator = NO;
    // 翻页效果
    scroll.pagingEnabled = YES;
    // 去除弹簧效果
    scroll.bounces = NO;
    
    // 设置scrollView的contentSize
    scroll.contentSize = CGSizeMake(HWNewFeatureImageCount * imageW, imageH);
    // 控制器成为代理
    scroll.delegate = self;
    
    
    self.scroll = scroll;

}



- (void)setupPageing
{
    UIPageControl *page = [[UIPageControl alloc] init];
    page.numberOfPages = HWNewFeatureImageCount;
    // 设置 page 的位置
    page.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height-30);
    page.bounds = CGRectMake(0, 0, 80, 30);
    // 选中点的颜色
    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"new_feature_pagecontrol_checked_point"]];
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"new_feature_pagecontrol_point"]];
    [self.view addSubview:page];
    self.page = page;
}

/**
 *  添加内容到最后一个图片
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    // 3.设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    // 4.添加checkbox
    UIButton *checkbox = [[UIButton alloc] init];
    checkbox.selected = YES;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat checkboxCenterX = centerX;
    CGFloat checkboxCenterY = imageView.frame.size.height * 0.5;
    checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    //    checkbox.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    //    checkbox.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [imageView addSubview:checkbox];
}

/**
 *  开始微博
 */
- (void)start
{
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 切换窗口的根控制器
    self.view.window.rootViewController = [[HWTabBarController alloc] init];
}

- (void)checkboxClick:(UIButton *)checkbox
{
    checkbox.selected = !checkbox.isSelected;
}

/**
 *  当scrollView开始滚动的时候就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.page.currentPage = self.scroll.contentOffset.x / self.view.bounds.size.width;
}
@end
