//
//  GuidancePageController.m
//  ShareView
//
//  Created by dxs on 2017/6/7.
//  Copyright © 2017年 dxs. All rights reserved.
//

#define kDeviceWidth    [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight   [UIScreen mainScreen].bounds.size.height

#define kButtonCenterYScaleToDeviceHeight   0.85

#import "GuidancePageController.h"
#import "GuidancePageImageCell.h"
#import <objc/runtime.h>


static NSString *GuidViewCellID = @"cellID";
static void *buttonImageNameKey = "buttonImageNameKey";

@interface GuidancePageController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl* pageControl;

@property (nonatomic, strong) NSArray *pageImagesArray;

@property (nonatomic, strong) UIButton* enterButton;

@property (nonatomic, assign) EnterInStyle style;

@end

@implementation GuidancePageController

- (instancetype)initPagesButtonImageWithArray:(NSArray *)array enterStyle:(EnterInStyle)style {
    if (self = [super init]) {
        self.pageImagesArray = [NSArray arrayWithArray:array];
        self.style = style;
        objc_setAssociatedObject(_pageImagesArray, buttonImageNameKey, array.lastObject, OBJC_ASSOCIATION_ASSIGN);
    }
    return self;
}
/*
- (instancetype)initPagesImageArray:(NSArray *)array enterButtonImageName:(NSString *)btnName {
    if (self = [super init]) {
        self.pageImagesArray = [NSArray arrayWithArray:array];
        objc_setAssociatedObject(_pageImagesArray, buttonImageNameKey, btnName, OBJC_ASSOCIATION_ASSIGN);
    }
    return self;
}
*/

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
    
}

- (void)setupSubviews{
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self layoutCollectionview];
    
    [self layoutPageCtrol];
    
    [self layoutEnterButton];
    
}

- (void)layoutCollectionview {
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.bounces = NO;
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    [self.collectionView registerClass:[GuidancePageImageCell class] forCellWithReuseIdentifier:GuidViewCellID];
    [self.view addSubview:self.collectionView];
    
}

- (void)layoutPageCtrol {
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidesForSinglePage = YES;
    
    if (_style == ENTER_SCROLL) {
        
       self.pageControl.numberOfPages = self.pageImagesArray.count;
        
    } else {
        
        self.pageControl.numberOfPages = self.pageImagesArray.count - 1;
        
    }
    
    [self.view addSubview:self.pageControl];
    
}

- (void)layoutEnterButton {
    
    self.enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.enterButton.hidden = YES;
    
    [self.enterButton setImage:[UIImage imageNamed:objc_getAssociatedObject(_pageImagesArray, buttonImageNameKey)] forState:UIControlStateNormal];
    objc_setAssociatedObject(_pageImagesArray, buttonImageNameKey, nil, OBJC_ASSOCIATION_ASSIGN);
    
    [self.enterButton addTarget:self action:@selector(hideGuidanceWindow) forControlEvents:UIControlEventTouchUpInside];
    [self.enterButton sizeToFit];
    [self.view addSubview:self.enterButton];
    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = [UIScreen mainScreen].bounds;
    
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageImagesArray.count];
    self.pageControl.frame = CGRectMake((kDeviceWidth - size.width) / 2, kDeviceHeight - size.height, size.width, size.height);
    
    self.enterButton.center = CGPointMake(kDeviceWidth * 1/2, kDeviceHeight * kButtonCenterYScaleToDeviceHeight);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _style == ENTER_SCROLL ? _pageImagesArray.count : _pageImagesArray.count - 1;
    //return _pageImagesArray.count;
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GuidancePageImageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:GuidViewCellID forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.pageImagesArray[indexPath.row]];
    
    if ((_style == ENTER_SCROLL) && (indexPath.row == _pageImagesArray.count - 1)) {
        
        [cell.imageView removeFromSuperview];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.bounds.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    long current = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.pageControl.currentPage = lroundf(current);
    
    if (_style == ENTER_CLICK) {
        
        self.enterButton.hidden = !(self.pageControl.currentPage == (_pageImagesArray.count - 2));
        
    } else {
        
        if (self.pageControl.currentPage == _pageImagesArray.count - 1) {
            
            [_pageControl removeFromSuperview];
            
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
   int current = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
    if (_style == ENTER_SCROLL && current == self.pageImagesArray.count - 1) {
        [self hideGuidanceWindow];
    }

}

// MARK:- 隐藏
- (void)hideGuidanceWindow {
    if (self.hiddeGuidanceWindow) {
        self.hiddeGuidanceWindow();
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

