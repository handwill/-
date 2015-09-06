//
//  HWNewsTopCell.m
//  MyWeibo
//
//  Created by imac on 15/8/28.
//  Copyright (c) 2015年 handwill. All rights reserved.
//

#import "HWNewsTopCell.h"
#import "EScrollerView.h"
#import "HWNewsTopImage.h"

@interface HWNewsTopCell ()<EScrollerViewDelegate>

@end

@implementation HWNewsTopCell

+ (HWNewsTopCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TopNews";
    HWNewsTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
       cell = [[HWNewsTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

-(void)updataSouce:(NSMutableArray *)imageArr
{
    NSMutableArray *imageS = [[NSMutableArray alloc]init];
    NSMutableArray *titleS = [[NSMutableArray alloc]init];
    for (HWNewsTopImage *object in imageArr) {
        NSString *image = object.imgUrl;
        [imageS addObject:image];
        
        NSString *title = object.newsTitle;
        [titleS addObject:title];
        
    }
    
    if (imageS.count != 0 && titleS.count != 0) {
        EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0,[[UIScreen mainScreen]bounds].size.width, 150)
                                                              ImageArray:imageS
                                                              TitleArray:titleS];
        scroller.delegate=self;
        [self.contentView addSubview:scroller];
        
        //        scroller.userInteractionEnabled = NO;
        //        [self.contentView addGestureRecognizer: scroller.panGestureRecognizer];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
