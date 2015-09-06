//
//  HWHomeViewController.m
//  MyWeibo
//
//  Created by imac on 15/8/16.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWHomeViewController.h"
#import "UIBarButtonItem+HW.h"
#import "HWTitleButton.h"
#import "AFNetworking.h"
#import "HWAccount.h"
#import "HWAccountTool.h"
#import "MJExtension.h"
#import "HWStatus.h"
#import "HWUsers.h"
#import "UIImageView+WebCache.h"
#import "HWStatusFrame.h"
#import "HWStatusCell.h"
#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"
#import "HWPopViewController.h"


@interface HWHomeViewController () <MJRefreshBaseViewDelegate>

@property (nonatomic,strong) NSArray *statuses;
@property (nonatomic,strong) NSMutableArray *statusFrame;
@property (nonatomic,weak) MJRefreshFooterView *footer;

@end

@implementation HWHomeViewController

- (NSMutableArray *)statusFrame
{
    if (_statusFrame == nil) {
        _statusFrame = [NSMutableArray array];
    }
    return _statusFrame;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 刷新数据
    [self loadMoreData];

    // 设置导航栏样式
    [self setupHomeNavigationBar];
    
    // 加载微博数据
    [self setupStatusData];
    
    //self.tableView
    
}

- (void)loadMoreData
{
    // 1.下拉刷新
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refresh];
    [refresh addTarget:self action:@selector(loadMoreNewData:) forControlEvents:UIControlEventValueChanged];
    //[refresh beginRefreshing];
    
    // 2.上拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    // 控制器成为代理
    footer.delegate = self;
    self.footer = footer;
}

- (void)dealloc
{
    [self.footer free];
}

#pragma mark - MJRefreshFooterView的代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HWAccountTool account].access_token;
    
    params[@"count"] = @5;
    if (self.statusFrame.count) {
        HWStatusFrame *statusFrame = [self.statusFrame lastObject];
        // 加载ID <= max_id的微博
        long long maxId = [statusFrame.status.idstr longLongValue] - 1;
        params[@"max_id"] = @(maxId);
    }
    
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSArray *statusArray = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
         // 创建frame模型对象
         NSMutableArray *statusFrameArray = [NSMutableArray array];
         for (HWStatus *status in statusArray) {
             HWStatusFrame *statusFrame = [[HWStatusFrame alloc] init];
             // 传递微博模型数据
             statusFrame.status = status;
             [statusFrameArray addObject:statusFrame];
         }
         
         [self.statusFrame addObjectsFromArray:statusFrameArray];
         
         // 刷新表格
         [self.tableView reloadData];
         
         // 让刷新控件停止显示刷新状态
         [refreshView endRefreshing];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         // 让刷新控件停止显示刷新状态
         [refreshView endRefreshing];
     }];

    
}

- (void)loadMoreNewData:(UIRefreshControl *)refresh
{
    [refresh beginRefreshing];
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HWAccountTool account].access_token;
    
    if (self.statusFrame.count) {
        HWStatusFrame *statusFrame = self.statusFrame[0];
        // 加载ID比since_id大的微博
        params[@"since_id"] = statusFrame.status.idstr;
    }
    
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSArray *statusArray = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
         // 创建frame模型对象
         NSMutableArray *statusFrameArray = [NSMutableArray array];
         for (HWStatus *status in statusArray) {
             HWStatusFrame *statusFrame = [[HWStatusFrame alloc] init];
             // 传递微博模型数据
             statusFrame.status = status;
             [statusFrameArray addObject:statusFrame];
         }
         
         
         // 将最新的数据追加到旧数据的最前面
         // 旧数据: self.statusFrames
         // 新数据: statusFrameArray
         NSMutableArray *tempArray = [NSMutableArray array];
         // 添加statusFrameArray的所有元素 添加到 tempArray中
         [tempArray addObjectsFromArray:statusFrameArray];
         // 添加self.statusFrames的所有元素 添加到 tempArray中
         [tempArray addObjectsFromArray:self.statusFrame];
         self.statusFrame = tempArray;
         

         
         // 刷新表格
         [self.tableView reloadData];
         
         // 让刷新控件停止显示刷新状态
         [refresh endRefreshing];
         
         // 显示刷新出多少条围脖
         [self showStatusCountMessage:(int)statusFrameArray.count];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         // 让刷新控件停止显示刷新状态
         [refresh endRefreshing];
         NSLog(@"%@",error);
     }];
    

}

/**
 *  显示刷新出多少条围脖
 */
- (void)showStatusCountMessage:(int)statusCount
{
    UIButton *countBtn = [[UIButton alloc] init];
    [self.navigationController.view insertSubview:countBtn belowSubview:self.navigationController.navigationBar];
    
    [countBtn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [countBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    countBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    countBtn.userInteractionEnabled = NO;
    
    if (statusCount) {
        [countBtn setTitle:[NSString stringWithFormat:@"共刷新%d条微博",statusCount] forState:UIControlStateNormal];
    }else
    {
        [countBtn setTitle:[NSString stringWithFormat:@"没有新微博"] forState:UIControlStateNormal];
    }
    
    CGFloat btnH = 30;
    CGFloat btnY = 64-btnH;
    CGFloat btnX = 2;
    CGFloat btnW = self.view.bounds.size.width - 2* btnX;
    countBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    [UIView animateWithDuration:0.7 animations:^{
        // 往下移按钮的高度+2
        countBtn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
    }completion:^(BOOL finished) {
        
        [UIView animateKeyframesWithDuration:0.7 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            // 往上移回原处
           // countBtn.transform = CGAffineTransformMakeTranslation(0, -(btnH + 2));
            countBtn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 消除按钮
            [countBtn removeFromSuperview];
        }];
    }];
  
}

/**
 *  加载微博数据
 */
- (void)setupStatusData
{

    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *access_token = [HWAccountTool account].access_token;
  //  NSString *access_tokenTrul = [access_token substringFromIndex:4];
    NSLog(@"%@",access_token);
    params[@"access_token"] = access_token;
    
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSArray *statusArray = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
         // 创建frame模型对象
         NSMutableArray *statusFrameArray = [NSMutableArray array];
         for (HWStatus *status in statusArray) {
             HWStatusFrame *statusFrame = [[HWStatusFrame alloc] init];
             // 传递微博模型数据
             statusFrame.status = status;
             [statusFrameArray addObject:statusFrame];
         }
         
         // 赋值
         self.statusFrame = statusFrameArray;
         
         // 刷新表格
         [self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",operation.responseString);
     }];


}

/**
 *  设置导航栏内容
 */
- (void)setupHomeNavigationBar
{
    
    // 设置左边图标
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImg:@"navigationbar_friendsearch" HighImg:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFrind)];
    // 设置右边图标
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImg:@"navigationbar_pop" HighImg:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 设置导航栏的中间内容
    // 中间按钮
    HWTitleButton *titleButton = [HWTitleButton titleButton];
    // 图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 文字
    [titleButton setTitle:@"刷微博" forState:UIControlStateNormal];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 100, 40);
    //    titleButton.tag = IWTitleButtonDownTag;
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    // 去除cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
}

- (void)titleClick:(UIButton *)titileBtn
{
    if (titileBtn.tag == 0) {
       [titileBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titileBtn.tag = -1;
        
    }else if (titileBtn.tag == -1)
    {
        [titileBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titileBtn.tag = 0;
    }
}

- (void)findFrind
{
   NSLog(@"%s",__func__);
}

- (void)pop
{
    HWPopViewController *pop = [[HWPopViewController alloc] init];
    [self.navigationController pushViewController:pop animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.statusFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HWStatusCell *cell = [HWStatusCell cellWithTableView:tableView];
    
    // 2.设置cell的数据
    // 微博的文字(内容)
    cell.statusFrame = self.statusFrame[indexPath.row];
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWStatusFrame *statusFrame = self.statusFrame[indexPath.row];
    return statusFrame.cellHeight;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
