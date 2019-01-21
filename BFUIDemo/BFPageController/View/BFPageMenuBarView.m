//
//  BFPageMenuBarView.m
//  BFUIDemo
//
//  Created by 刘玲 on 2018/9/19.
//  Copyright © 2018年 BFAlex. All rights reserved.
//

#import "BFPageMenuBarView.h"
#import "UIView+BFExtension.h"

#define kMaxRowItemNum 5
#define kBottomLineHeightPercent 0.2
#define kViewSpace 1
#define kBottomLineColor [UIColor blueColor]

@interface BFPageMenuBarView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;

@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UICollectionView *menu;

@property (nonatomic, assign) BOOL isShowButtonLine;
@property (nonatomic, assign) int didSelectIndex;

@end

@implementation BFPageMenuBarView

static NSString * const reuseIdentifier = @"BFPageMenuBarViewCell";


#pragma mark - API

+ (instancetype)pageMenuBarViewForTitles:(NSArray<NSString *> *)titles withFrame:(CGRect)frame {
    
    BFPageMenuBarView *menuBar = [[BFPageMenuBarView alloc] init];
    if (menuBar) {
        
        [menuBar setupDefaultConfig];
        
        menuBar.backgroundColor = [UIColor whiteColor];
        menuBar.menuTitles = [titles copy];
        [menuBar setupMenuItemsForFrame:frame];
    }
    
    return menuBar;
}

- (void)didSelectMenuBarItemAtIndex:(NSInteger)index {
    
    self.didSelectIndex = (int)index;
    [self.menu reloadData];
    if (self.isShowButtonLine) {
        [self updateBottonLineForIndex:self.didSelectIndex];
    }
}

- (void)scrollBottomLineXTo:(CGFloat)x {

    [self updateBottonLineOriginX:x / self.menuTitles.count];
//    [UIView animateWithDuration:0.1f animations:^{
//        self.bottomLine.x = x * (self.itemWidth / self.width);
//    } completion:^(BOOL finished) {
//
//    }];
}

- (void)scrollToX:(CGFloat)x andY:(CGFloat)y {
    
//    int index = x / self.itemWidth;
//    [self didSelectMenuBarItemAtIndex:index];
    [self scrollBottomLineXTo:x];
}

#pragma mark - Feature

- (void)setupDefaultConfig {
    self.didSelectIndex = 0;
}

- (void)setupMenuItemsForFrame:(CGRect)frame {
    
    /*
     ****************************
     * menu1 menu2 menu3 ...... *
     * _____                    *
     ****************************
     **/
    
    self.frame = frame;
    
    // 方法一：不使用相对布局，直接重新根据Size创建子View
    if (self.subviews.count > 0) {
        for (UIView *subView in self.subviews) {
            [subView removeFromSuperview];
        }
    }
    
    CGFloat bottomLineHeight = 4; // frame.size.height * kBottomLineHeightPercent;
    CGFloat itemY = kViewSpace;  // menu.y
    if (self.menuTitles.count <= kMaxRowItemNum) {
        self.itemWidth = (frame.size.width - (self.menuTitles.count - 1) * kViewSpace) / self.menuTitles.count;
        self.itemHeight = self.height - bottomLineHeight - kViewSpace * 2 - itemY;
        self.isShowButtonLine = YES;
    } else {
        self.itemWidth = (frame.size.width - (self.menuTitles.count - 1) * kViewSpace) / kMaxRowItemNum;
        self.itemHeight = self.height - itemY * 2;
        self.isShowButtonLine = NO;
    }
    
    if (self.isShowButtonLine) {
        // Bottom Line
        UIView *bl = [[UIView alloc] init];
        CGRect blFrame = CGRectMake(0, self.height - bottomLineHeight - kViewSpace, self.itemWidth, bottomLineHeight);
        bl.frame = blFrame;
        bl.backgroundColor = kBottomLineColor;
        [self addSubview:bl];
        self.bottomLine = bl;
    }
    
    // Menu
    CGRect menuFrame = CGRectMake(0, itemY, self.width, self.itemHeight);
    UICollectionView *menu = [self createMenuWithFrame:menuFrame anrItemSize:CGSizeMake(self.itemWidth, self.itemHeight)];
    [self addSubview:menu];
    self.menu = menu;
    menu.showsHorizontalScrollIndicator = NO;
    menu.bounces = NO;
    menu.backgroundColor = [UIColor clearColor];
    [menu registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)updateBottonLineForIndex:(int)index {
    
    CGFloat newX = self.itemWidth * index + kViewSpace * index;
    [self updateBottonLineOriginX:newX];
    
}

- (void)updateBottonLineOriginX:(CGFloat)newX {
    
    [UIView animateWithDuration:0.2f animations:^{
        self.bottomLine.x = newX;
    } completion:^(BOOL finished) {
        //
        self.didSelectIndex = (newX / self.itemWidth * 1.2);
        [self.menu reloadData];
    }];
}

- (UICollectionView *)createMenuWithFrame:(CGRect)menuFrame anrItemSize:(CGSize)itemSize {
    
    // Layout
    UICollectionViewFlowLayout *menuLayout = [[UICollectionViewFlowLayout alloc] init];
    menuLayout.minimumLineSpacing = kViewSpace;
    menuLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    menuLayout.itemSize = itemSize;
    // View
    UICollectionView *menuView = [[UICollectionView alloc] initWithFrame:menuFrame collectionViewLayout:menuLayout];
    [self addSubview:menuView];
    menuView.delegate = self;
    menuView.dataSource = self;
    
    
    return menuView;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.didSelectIndex = (int)indexPath.row;
    
    NSLog(@"click menu item for index: %ld", (long)indexPath.row);
//    CGFloat newX = self.itemWidth * indexPath.row + kViewSpace * indexPath.row;
//    [self updateBottonLineOriginX:newX];
    [self updateBottonLineForIndex:self.didSelectIndex];
    
    [self.menu reloadData];
    
    if (self.didSelectMenuItemAtIndex) {
        self.didSelectMenuItemAtIndex(indexPath.row);
    }
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.menuTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
//    NSLog(@"page menu bar subview count: %lu", (unsigned long)cell.subviews.count);
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell.backgroundColor = [UIColor orangeColor];
    }
    
    if (indexPath.row == self.didSelectIndex) {
        cell.backgroundColor = [UIColor redColor];
    }
    
    
    return cell;
}

@end
