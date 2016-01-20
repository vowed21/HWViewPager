//
//  ThirdViewController.m
//  HWViewPager
//
//  Created by HyunWoo Kim on 2015. 1. 9..
//  Copyright (c) 2015년 HyunWoo Kim. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 SectionInset = 0,0,0,0
 minimumLineSpacint = 0
 For Full Layout Pager
 */

#pragma mark - ColelctionViewDelegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FullCollectionCell" forIndexPath:indexPath];
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}



/*
 HWViewPagerDelegate
 connection IBOulet with Storyboard
 
 or
 call method : " [pager setPagerDelegate:id] "
 
 */

#pragma mark - HWViewPagerDelegate
-(void)pagerDidSelectedPage:(NSInteger)selectedPage{
    NSLog(@"FistViewController, SelectedPage : %@",[@(selectedPage) stringValue]);
    NSString * string = [NSString stringWithFormat:@"SectionInset left,right = 0, minLinespacing =0\nSelectedPage : %@",[@(selectedPage) stringValue]];
    self.label.text = string;
}

@end
