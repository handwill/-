//
//  HWJokeCommentView.m
//  MyWeibo
//
//  Created by imac on 15/8/24.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWJokeCommentView.h"
#import "HWJoke.h"
#import "HWJokeFrame.h"
#import "HWJokeCell.h"
#import "AFNetworking.h"
#import "HWJokeComment.h"
#import "MJExtension.h"
#import "HWJokeCommentCell.h"
#import "HWJokeComFrame.h"

@interface HWJokeCommentView () <UITableViewDelegate>
@property (nonatomic,strong)HWJokeComment *jokeComments;
// 装载模型的数组
@property (nonatomic,strong)NSArray *jokeCommentArray;
@property (nonatomic,strong)NSArray *jokeComtFrameArray;
@end

@implementation HWJokeCommentView

- (NSArray *)jokeCommentArray
{
    if (_jokeCommentArray == nil) {
        _jokeCommentArray = [NSArray array];
    }
    return _jokeCommentArray;
}
- (NSArray *)jokeComtFrameArray
{
    if (_jokeComtFrameArray == nil) {
        _jokeComtFrameArray = [NSArray array];
    }
    return _jokeComtFrameArray;
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
    // 去除cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 加载评论数据内容
    [self loadComments];
    
}

/**
 *  加载评论数据内容
 */
- (void)loadComments
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSString *strUrl = [NSString stringWithFormat:@"http://jbls.qingyou.cn/inter/inter/Comment?sid=%@&type=1",self.jokeFrame.joke.id];
    
    // 3.发送请求
    [mgr GET:strUrl parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         self.jokeCommentArray = [HWJokeComment objectArrayWithKeyValuesArray:responseObject[@"alljson"]];
    
         // 创建frame模型对象
         NSMutableArray *jokeComtFrameArray = [NSMutableArray array];
         for (HWJokeComment *jokeComt in self.jokeCommentArray) {
             HWJokeComFrame *jokeComtFrame = [[HWJokeComFrame alloc] init];
             // 传递微博模型数据
             jokeComtFrame.jokeComment = jokeComt;
             [jokeComtFrameArray addObject:jokeComtFrame];
         }
         
         // 赋值
        self.jokeComtFrameArray = jokeComtFrameArray;
         
         // 刷新表格
         [self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }else
    {
        return self.jokeComtFrameArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HWJokeCell *cell = [HWJokeCell cellWithTableView:tableView];
        cell.jokeFrame = self.jokeFrame;
        return cell;
    }
    else
    {
        HWJokeCommentCell *cell = [HWJokeCommentCell cellWithTableView:tableView];
        cell.jokeComFrame = self.jokeComtFrameArray[indexPath.row];
        
        //HWLog(@"%@",self.jokeComtFrameArray[indexPath.row]);
        return cell;
    }

}


#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.jokeFrame.cellHeight;
    }else
    {    
        HWJokeComFrame *jokeComtFrame = self.jokeComtFrameArray[indexPath.row];
        return jokeComtFrame.cellHeight;
    }


}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return [NSString stringWithFormat:@"所有评论"];
    }
    return nil;
    
}



@end
