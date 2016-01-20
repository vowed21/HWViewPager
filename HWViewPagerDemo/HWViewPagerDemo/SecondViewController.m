//
//  SecondViewController.m
//  HWViewPager
//
//  Created by HyunWoo Kim on 2015. 1. 9..
//  Copyright (c) 2015년 HyunWoo Kim. All rights reserved.
//

#import "SecondViewController.h"
#import "TableViewCell.h"

@interface SecondViewController ()<UITableViewDataSource>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.row = indexPath.row;
    cell.label1.text = [NSString stringWithFormat:@"CollectionCell count = %@",[@(cell.row+1) stringValue]];
    [cell.pager reloadData];
    
    return cell;
    
}


@end
