//
//  HWTempWebNews.m
//  MyWeibo
//
//  Created by imac on 15/8/29.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWTempWebNews.h"

@implementation HWTempWebNews

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *newsWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    NSURL *strUrl = [NSURL URLWithString: @"http://info.3g.qq.com/g/s?aid=template&tid=infocenter&g_f=1793&icfa=home_navi&iarea=34"];
    NSURLRequest *request = [NSURLRequest requestWithURL:strUrl];
    [newsWeb loadRequest:request];
    
    [self.view addSubview:newsWeb];
    
}

@end
