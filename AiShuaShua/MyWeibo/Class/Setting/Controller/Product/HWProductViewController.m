//
//  HWProductViewController.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//
/**
 UICollectionView must be initialized with a non-nil layout parameter
 
 必须用一个非nil的layout参数来初始化UICollectionView
 */

#define HWProductCellID @"product"

#import "HWProductViewController.h"
#import "HWProduct.h"
#import "HWProductCell.h"

@interface HWProductViewController ()
@property (nonatomic, strong) NSArray *products;
@end

@implementation HWProductViewController

- (NSArray *)products
{
    if (_products == nil) {
        
        // JSON文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"products.json" ofType:nil];
        
        // 加载JSON文件
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        // 将JSON数据转为NSArray或者NSDictionary
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        // 将字典转成模型
        NSMutableArray *productArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HWProduct *p = [HWProduct productWithDict:dict];
            [productArray addObject:p];
        }
        
        _products = productArray;
    }
    return _products;
}

- (id)init
{
    // 1.流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.每个cell的尺寸
    layout.itemSize = CGSizeMake(80, 80);
    // 3.设置cell之间的水平间距
    layout.minimumInteritemSpacing = 0;
    // 4.设置cell之间的垂直间距
    layout.minimumLineSpacing = 10;
    // 5.设置四周的内边距
    layout.sectionInset = UIEdgeInsetsMake(layout.minimumLineSpacing, 0, 0, 0);
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.注册cell(告诉collectionView将来创建怎样的cell)
    UINib *nib = [UINib nibWithNibName:@"HWProductCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:HWProductCellID];
    
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:HWProductCellID];
    
    // 2.设置collectionView的背景色
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 数据源方法
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.获得cell
    HWProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HWProductCellID forIndexPath:indexPath];
    
    // 2.传递模型
    cell.product = self.products[indexPath.item];
    
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HWProduct *p = self.products[indexPath.item];
    NSURL *customUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@", p.scheme, p.identifier]];
    UIApplication *app = [UIApplication sharedApplication];
    
    if ([app canOpenURL:customUrl]) { // 有安装应用
        // 打开应用
        [app openURL:customUrl];
    } else { // 没有安装应用
        // 打开appStore
        [app openURL:[NSURL URLWithString:p.url]];
    }
}

@end
