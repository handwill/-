//
//  HWNewsViewController.m
//  MyWeibo
//
//  Created by imac on 15/8/27.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWNewsViewController.h"
#import "HWNewsCell.h"
#import "HWNewsTopCell.h"
#import "HWNews.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "GDataXMLNode.h"
#import "HWNewsContant.h"
#import "HWNewsTopImage.h"

#define NewsUrl @"http://zaijiawan.com/news/news/getNews.jsp?appname=readingnews360junshi&version=2.2.1&os=ios&hardware=iphone&timestamp=0&page=0"
#define  NewsTopImgUrl @"http://zaijiawan.com/news/news/getGalleryNews.jsp?appname=readingnews360junshi&version=2.2.1&os=ios&hardware=iphone"

@interface HWNewsViewController ()
@property (nonatomic,strong) NSMutableArray *newsArray;
@property (nonatomic,strong) NSMutableArray *imageArray;
@end

@implementation HWNewsViewController

- (NSMutableArray *)newsArray
{
    if (_newsArray == nil) {
        _newsArray = [[NSMutableArray alloc] init];
    }
    return _newsArray;
}

- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 加载新闻数据
    [self loadNewsData];
    
    // 加载顶部的图片
    [self loadTopImage];
}

/**
 *  加载新闻数据
 */
- (void)loadNewsData
{
    
    /**
     加载服务器最新的新闻数据
     */
    
    // 1.创建URL
    NSURL *url = [NSURL URLWithString:NewsUrl];
    
    // 2.创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError || data == nil) {
            [MBProgressHUD showError:@"网络繁忙，请稍后再试！"];
            return;
        }
        
        /**********************  解析XML数据  **************************************/ 
        
        // 加载整个XML数据
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        
        // 获得文档的根元素 -- videos元素
        GDataXMLElement *root = doc.rootElement;
        
        // 获得根元素里面的所有video元素
        NSArray *elements = [root elementsForName:@"news"];
        
        // 遍历所有的video元素
        for (GDataXMLElement *newsElement in elements) {
            HWNews *news = [[HWNews alloc] init];
            
            news.newsTitle = [[[newsElement elementsForName:@"newsTitle"] objectAtIndex:0] stringValue];
            news.id = [[[newsElement elementsForName:@"id"] objectAtIndex:0] stringValue];
            news.newsUrl = [[[newsElement elementsForName:@"newUrl"] objectAtIndex:0] stringValue];
            news.newsAbstract = [[[newsElement elementsForName:@"newsAbstract"] objectAtIndex:0] stringValue];
            news.imgUrl = [[[newsElement elementsForName:@"imgUrl"] objectAtIndex:0] stringValue];
            news.time = [[[newsElement elementsForName:@"time"] objectAtIndex:0] stringValue];
            news.newsComments = [[[newsElement elementsForName:@"newsComments"] objectAtIndex:0]stringValue];
            // 添加到数组中
            [self.newsArray addObject:news];
        }
        // 刷新表格
        [self.tableView reloadData];
    }];
    
}

/*
 * 加载顶部的图片
 */
- (void)loadTopImage
{
    /**
     加载服务器最新的顶部图片
     */
    
    // 1.创建URL
    NSURL *url = [NSURL URLWithString:NewsTopImgUrl];
    
    // 2.创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError || data == nil) {
            [MBProgressHUD showError:@"网络繁忙，请稍后再试！"];
            return;
        }
        
        /**********************  解析XML数据  **************************************/
        
        // 加载整个XML数据
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        
        // 获得文档的根元素 -- videos元素
        GDataXMLElement *root = doc.rootElement;
        
        // 获得根元素里面的所有video元素
        NSArray *elements = [root elementsForName:@"news"];
        
        // 遍历所有的video元素
        for (GDataXMLElement *newsElement in elements) {
            HWNews *news = [[HWNews alloc] init];
            
            news.newsTitle = [[[newsElement elementsForName:@"newsTitle"] objectAtIndex:0] stringValue];
            news.id = [[[newsElement elementsForName:@"id"] objectAtIndex:0] stringValue];
            news.newsUrl = [[[newsElement elementsForName:@"newUrl"] objectAtIndex:0] stringValue];
            news.newsAbstract = [[[newsElement elementsForName:@"newsAbstract"] objectAtIndex:0] stringValue];
            news.imgUrl = [[[newsElement elementsForName:@"imgUrl"] objectAtIndex:0] stringValue];
            news.time = [[[newsElement elementsForName:@"time"] objectAtIndex:0] stringValue];
            news.newsComments = [[[newsElement elementsForName:@"newsComments"] objectAtIndex:0]stringValue];
            // 添加到数组中
            [self.imageArray addObject:news];
        }
        
        // 刷新表格
        [self.tableView reloadData];
    }];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
        return self.newsArray.count + 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row ==0 ) {
        
        HWNewsTopCell *cell = [HWNewsTopCell cellWithTableView:tableView];
        [cell updataSouce:self.imageArray];
        return cell;
    }else
    {
        HWNewsCell *cell = [HWNewsCell cellWithTableView:tableView];
        HWNews *news = self.newsArray[indexPath.row-1];
        cell.news = news;
        return cell;
    
    }
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    }else
    {
        return 87;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        HWNewsContant *newsContent = [[HWNewsContant alloc] init];
#warning 暂时先显示第一张图片的详情，以后在更改
        HWNewsTopImage *image = self.imageArray[0];
        newsContent.newsContentUrl = image.newsUrl;
        [self.navigationController pushViewController:newsContent animated:YES];

    }else
    {
        HWNews *news = self.newsArray[indexPath.row-1];
        HWNewsContant *newsContent = [[HWNewsContant alloc] init];
        
        newsContent.newsContentUrl = news.newsUrl;
        [self.navigationController pushViewController:newsContent animated:YES];
    }

}


@end
