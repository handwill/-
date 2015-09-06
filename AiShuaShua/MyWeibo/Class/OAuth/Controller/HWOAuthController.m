//
//  HWOAuthController.m
//  MyWeibo
//
//  Created by imac on 15/8/19.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWOAuthController.h"
#import "AFNetworking.h"
#import "HWAccount.h"
#import "HWAccountTool.h"
#import "HWWeiboTool.h"

@interface HWOAuthController () <UIWebViewDelegate>

@end

@implementation HWOAuthController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 新建webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    // 控制器成为代理
    webView.delegate = self;
    
    // 加载页面
    NSURL *urlStr = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2075733604&redirect_uri=http://ios.itcast.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr];
    [webView loadRequest:request];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   // NSLog(@"%@",request.URL);
    // 查找// 2.查找code=在urlStr中的范围
    NSString *strUrl = request.URL.absoluteString;
    NSRange range = [strUrl rangeOfString:@"code="];
    
    // 如果找到，就截取code=后面的字符串
    if (range.length > 0) {
        NSInteger from = range.location + range.length;
        NSString *strToken = [strUrl substringFromIndex:from];
        
        NSLog(@"%@",strToken);
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"client_id": @"2075733604",
                                     @"client_secret": @"d03f60598a20a3ff40e167e2871d7698",
                                     @"grant_type": @"authorization_code",
                                     @"code": strToken,
                                     @"redirect_uri": @"http://ios.itcast.cn"};
        [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // 字典转模型
            HWAccount *account = [HWAccount accountWithDict:responseObject];
            // 存储模型
            [HWAccountTool saveAccount:account];
            
            // .新特性\去首页
            [HWWeiboTool chooseRootController];
           // NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           // NSLog(@"Error: %@", error);
        }];
    }
    
    return YES;
}



@end
