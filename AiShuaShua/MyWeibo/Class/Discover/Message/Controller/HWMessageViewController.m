//
//  HWMessageViewController.m
//  MyWeibo
//
//  Created by imac on 15/8/16.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWMessageViewController.h"
#import "AFNetworking.h"
#import "HWJoke.h"
#import "MJExtension.h"
#import "HWJokeFrame.h"
#import "HWJokeCell.h"
#import "MJRefresh.h"
#import "HWJokeCommentView.h"



@interface HWMessageViewController () <MJRefreshBaseViewDelegate>
@property (nonatomic,strong)NSArray *jokes;

@property (nonatomic,strong)NSMutableArray *jokeFrames;
@property (nonatomic,weak)MJRefreshFooterView *footer;
@end

@implementation HWMessageViewController

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
    
    // 设置导航栏
    [self setupNavigationItem];
    
    // 加载笑话数据
    [self setupJokeData];
    
    [self loadMoreData];

}

#pragma mark - MJRefresh加载更多数据
- (void)loadMoreData
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.delegate = self;
    self.footer = footer;
    footer.scrollView = self.tableView;
    //[footer beginRefreshing];
}
/**
 *  MJRefresh的代理方法
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    static NSUInteger page = 2;
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSString *strUrl = [NSString stringWithFormat:@"http://jbls.qingyou.cn/inter/inter/shiwen?page=%d&userid=0",page++];
    
    // 3.发送请求
    [mgr GET:strUrl parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         //NSLog(@"%@",responseObject);
         
         NSArray *jokeArray = [HWJoke objectArrayWithKeyValuesArray:responseObject[@"alljson"]];
         
         // 创建frame模型对象
         NSMutableArray *jokeFrameArray = [NSMutableArray array];
         for (HWJoke *joke in jokeArray) {
             HWJokeFrame *jokeFrame = [[HWJokeFrame alloc] init];
             // 传递微博模型数据
             jokeFrame.joke = joke;
             [jokeFrameArray addObject:jokeFrame];
         }
         
         // 在原来的数据后面添加数据
         [self.jokeFrames addObjectsFromArray:jokeFrameArray];

         
         // 刷新表格
         [self.tableView reloadData];
         // 停止刷新
         [refreshView endRefreshing];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // 停止刷新
         [refreshView endRefreshing];
     }];
}
/**
 *  释放
 */
- (void)dealloc
{
    [self.footer free];
}

/**
 *  设置导航栏
 */
- (void)setupNavigationItem
{
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷笑话" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    // 去除cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
 *  加载笑话数据
 */
- (void)setupJokeData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    // 3.发送请求
    [mgr GET:@"http://jbls.qingyou.cn/inter/inter/shiwen?page=1&userid=0" parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         //NSLog(@"%@",responseObject);
         
        NSArray *jokeArray = [HWJoke objectArrayWithKeyValuesArray:responseObject[@"alljson"]];
         
         // 创建frame模型对象
         NSMutableArray *jokeFrameArray = [NSMutableArray array];
         for (HWJoke *joke in jokeArray) {
             HWJokeFrame *jokeFrame = [[HWJokeFrame alloc] init];
             // 传递微博模型数据
             jokeFrame.joke = joke;
             [jokeFrameArray addObject:jokeFrame];
         }
         
         // 赋值
         self.jokeFrames = jokeFrameArray;
         
         // 刷新表格
        [self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
    
   
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.jokeFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HWJokeCell *cell = [HWJokeCell cellWithTableView:tableView];
    cell.jokeFrame = self.jokeFrames[indexPath.row];
     //NSLog(@"%s----%d",__func__,i++);
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static int i = 0;
    HWJokeFrame *jokeFrame = self.jokeFrames[indexPath.row];
    //HWLog(@"%s---%d",__func__,i++);
    return jokeFrame.cellHeight;
    
}
/**
 *  跳转到详情页面  HWJokeCommentView
 *
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWJokeCommentView *comtView = [[HWJokeCommentView alloc] init];
    // 给页面传递数据
    comtView.jokeFrame = self.jokeFrames[indexPath.row];
    [self.navigationController pushViewController:comtView animated:YES];
}



@end
