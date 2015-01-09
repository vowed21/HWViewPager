//
//  TableViewCell.h
//  HWViewPager
//
//  Created by HyunWoo Kim on 2015. 1. 9..
//  Copyright (c) 2015년 HyunWoo Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWViewPager.h"
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet HWViewPager *pager;

@property int row;

@end
