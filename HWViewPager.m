//
//  HWViewPager.m
//
//  Created by HyunWoo Kim on 2015. 1. 8..
//  Copyright (c) 2015년 HyunWoo Kim. All rights reserved.
//
//  email : hyunwoo-21@hanmail.net
//


/*
 @require 1. Need UICollectionViewFlowLayout
 @require 2. Don't Use SectionView
 @require 3. Initialize by Storyboard or initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
 
 
 제약 1. - 스토리보드를 사용해서 flowLayout을 사용할것.
 제약 2. 섹션 뷰는 사용하지 말것.
 제약 3. 스토리보드 씁시다.
 
 
 Usage 1 ... Configure FlowLayout's Section Inset (0, 0, 0, 0) AND minimumLineSpacing = 0 ... For Full Layout;
 
    but, for preview leftView and rightView -- set Section Inset value left, right and minimumLineSpaceing ...
 
 Usage 2... Use PageSelectedDelegate -  "setPagerDelgate" Method or storyboard outlet connection;
 
 사용 1. 풀스크린으로 사용하고싶다면 스토리보드에서 Section Inset 의 크기와 minLinespacing 모두 0으로 설정, 좌우 짤리는 모습쓰고 싶으면, 섹션 인셋의 left, right 와 minLinespacing 설정할것.
 사용 2. "setPagerDelegate" 메소드를 사용하거나, 스토리보드에서 아울렛을 연결하면, 페이지 선택 델리게이트를 사용할 수 있음.
 
 */

#import "HWViewPager.h"

#define VELOCITY_STANDARD 0.6f

@interface HWViewPager() <UICollectionViewDelegate>

typedef NS_ENUM(NSInteger, PagerControlState) {
    PagerControlStateStayCurrent,
    PagerControlStateMoveToLeft,
    PagerControlStateMoveToRight
};

@property (strong, nonatomic) UICollectionViewFlowLayout * flowLayout;
@property CGRect beforeFrame;
@property NSInteger itemsTotalNum;
@property CGFloat itemWidthWithMargin;
@property NSInteger selectedPageNum;
@property CGFloat scrollBeginOffset;
@property enum PagerControlState pagerControlState;

@property (weak, nonatomic) IBOutlet id<HWViewPagerDelegate> userPagerDelegate;

@end



@implementation HWViewPager


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initialize];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if(self){
        [self initialize];
    }
    return self;
}


-(void)initialize{
    //페이징은 NO로 바꿔주고.
    [self setScrollEnabled:YES];
    [self setPagingEnabled:NO];
    
    self.selectedPageNum = 0;
    self.flowLayout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
    
    //스크롤방향은 horiozontal
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self setDelegate:self];
    self.beforeFrame = self.frame;
    
    self.pagerControlState = PagerControlStateStayCurrent;
    [self setDecelerationRate: UIScrollViewDecelerationRateFast];
}



-(void)setPagerDelegate:(id<HWViewPagerDelegate>)pagerDelegate{
    self.userPagerDelegate = pagerDelegate;
}






#pragma mark - override...
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //현재 뷰의 프레임 크기와 이전의 프레임과 다르다면, 아이템의 크기도 함께 바꿔준다.
    if(!CGRectEqualToRect(self.frame, self.beforeFrame)){
        //flowLayout의 아이템 사이즈를 현재뷰의 width에서 왼쪽인섹션 *2 만큼 빼주고, 셀간여백만큼도 빼준다.
        CGFloat widthNew = self.frame.size.width - (self.flowLayout.sectionInset.left *2) - self.flowLayout.minimumLineSpacing;
        CGFloat heightNew = self.frame.size.height - self.flowLayout.sectionInset.top - self.flowLayout.sectionInset.bottom;
        self.flowLayout.itemSize = CGSizeMake(widthNew, heightNew);
        self.beforeFrame = self.frame;
        
        self.itemWidthWithMargin = widthNew + self.flowLayout.minimumLineSpacing;
        
        //현재 선택된 페이지의 오프셋으로 이동시켜준다.
        int targetX = [self getOffsetFromPage:self.selectedPageNum scrollView:self];
        [self setContentOffset:CGPointMake(targetX, 0)];
        
    }
}



-(void)reloadData{
    
    [super reloadData];
    
    self.itemsTotalNum = 0;
    
    NSInteger sectionNum = [self numberOfSections];
    for(int i=0; i<sectionNum; i++){
        self.itemsTotalNum += [self.dataSource collectionView:self numberOfItemsInSection:sectionNum];
    }
    //새로 불렸을 때, 페이지넘을 0으로, 오프셋도 0으로 이동시켜준다.
    self.selectedPageNum = 0;
    [self setContentOffset:CGPointMake(0, 0)];
}



#pragma mark - ScrollViewDelegate
//컬렉션뷰 델리게이트 중에 있는 스크롤관련 델리게이트.
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //스크롤 시작한 위치를 저장해둔다.
    self.scrollBeginOffset = scrollView.contentOffset.x;
    self.pagerControlState = PagerControlStateStayCurrent;
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{

    CGPoint point = *targetContentOffset;

    //먼저 벨로서티 기준에 따라서 이동 여부를 결정
    //벨로시티가 오른쪽으로 기준보다 크다면, 오른쪽으로 이동 시켜준다.
    if(velocity.x > VELOCITY_STANDARD){
//        NSLog(@"벨로서티가 기준보다 커서, 오른쪽으로 이동해야한다!");
        self.pagerControlState = PagerControlStateMoveToRight;
    }//벨로서티가 왼쪽으로 기준보다 작다면, 왼쪽으로 이동시켜준다.
    else if(velocity.x < -VELOCITY_STANDARD){
//        NSLog(@"벨로서티가 -기준보다 작아서, 왼쪽으로 이동해야한다!");
        self.pagerControlState = PagerControlStateMoveToLeft;
    }
    
    //총 스크롤 한 거리.
    CGFloat scrolledDistance = self.scrollBeginOffset - scrollView.contentOffset.x;
    // 컨텐츠 크기의 반.
    CGFloat standardDistance = self.itemWidthWithMargin/2;
    
    //컨텐츠 크기의 반만큼보다 많이 스크롤을 했다면,
    if(scrolledDistance < -standardDistance){
        self.pagerControlState = PagerControlStateMoveToRight;
        
    }else if(scrolledDistance > standardDistance){
        self.pagerControlState = PagerControlStateMoveToLeft;
    }
    
    //선택페이지를 결정한다.
    if(self.pagerControlState == PagerControlStateMoveToLeft && self.selectedPageNum > 0){
        self.selectedPageNum--;
    }
    else if (self.pagerControlState == PagerControlStateMoveToRight && self.selectedPageNum <self.itemsTotalNum-1){
        self.selectedPageNum++;
    }
    
    //페이지가 설정되고, 델리게이트가 설정되어있다면, 델리게이트를 호출한다.
    if(self.userPagerDelegate){
        [self.userPagerDelegate pagerDidSelectedPage:self.selectedPageNum];
    }
    
    point.x = [self getOffsetFromPage:self.selectedPageNum scrollView:scrollView];
    *targetContentOffset = point;

}


//해당 페이지의 컨텐트오프셋을 구하는 메소드.
-(CGFloat) getOffsetFromPage:(NSInteger)pageNum scrollView:(UIScrollView*)scrollView{
    
    if(pageNum == 0){
        return 0;
    }
    else if(pageNum >= self.itemsTotalNum-1){
        return scrollView.contentSize.width - self.frame.size.width;
    }
    
    return (self.itemWidthWithMargin*pageNum) - (self.flowLayout.minimumLineSpacing/2);
}





@end
