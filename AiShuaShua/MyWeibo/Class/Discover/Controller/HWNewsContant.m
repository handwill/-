//
//  HWNewsContant.m
//  AiShuaShua
//
//  Created by imac on 15/9/2.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWNewsContant.h"

@implementation HWNewsContant

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    
    NSURL *url = [NSURL URLWithString:self.newsContentUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    
}

@end
