//
//  TableViewCell.m
//  HWViewPager
//
//  Created by HyunWoo Kim on 2015. 1. 9..
//  Copyright (c) 2015년 HyunWoo Kim. All rights reserved.
//

#import "TableViewCell.h"
#import "HWViewPager.h"

@interface TableViewCell ()<UICollectionViewDataSource>
@end


@implementation TableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



/*
 FlowLayout Setting - 
 SectionInset Left, Right
 minimumLineSpacing
 */

#pragma mark - CollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell2" forIndexPath:indexPath];
    
    

    return collectionCell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.row +1;
}




@end
