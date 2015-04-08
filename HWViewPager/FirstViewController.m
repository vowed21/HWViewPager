//
//  FirstViewController.m
//  HWViewPager
//
//  Created by HyunWoo Kim on 2015. 1. 9..
//  Copyright (c) 2015년 HyunWoo Kim. All rights reserved.
//

#import "FirstViewController.h"
#import "HWViewPager.h"

@interface FirstViewController () <UICollectionViewDataSource, HWViewPagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    NSLog(@"FistViewController, SelectedPage : %d",(int)selectedPage);
    NSString * string = [NSString stringWithFormat:@"SectionInset left,right = 30\nminLinespacing =20\nSelectedPage : %d",(int)selectedPage];
    self.label.text = string;                       
}


@end
