//
//  HWProductCell.m
//  00-ItcastLottery
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HWProductCell.h"
#import "HWProduct.h"

@interface HWProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HWProductCell

- (void)awakeFromNib
{
    self.iconView.layer.cornerRadius = 8;
    self.iconView.clipsToBounds = YES;
}

- (void)setProduct:(HWProduct *)product
{
    _product = product;
    
    // 1.设置头像
    self.iconView.image = [UIImage imageNamed:product.icon];
    
    // 2.设置名称
    self.nameLabel.text = product.title;
}

@end
