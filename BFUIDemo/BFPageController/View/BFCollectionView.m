//
//  BFCollectionView.m
//  BFUIDemo
//
//  Created by 刘玲 on 2018/9/20.
//  Copyright © 2018年 BFAlex. All rights reserved.
//

#import "BFCollectionView.h"

@interface BFCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation BFCollectionView

static NSString * const reuseIdentifier = @"BFCollectionViewCell";

#pragma mark - Property

- (void)setDataModels:(NSArray<BFDataModel *> *)dataModels {
    
    _dataModels = dataModels;
    [self.collectionView reloadData];
}

#pragma mark - API

+ (instancetype)collectionViewWithFrame:(CGRect)frame andScrollDirection:(UICollectionViewScrollDirection)scrollDirectiont {
    
    BFCollectionView *collectionView = [[BFCollectionView alloc] initWithFrame:frame];
    if (collectionView) {
        
        collectionView.backgroundColor = [UIColor purpleColor];
        // Collection View
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //
        layout.headerReferenceSize = CGSizeMake(frame.size.width, 50);
//        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumInteritemSpacing = 2;
        //
        layout.scrollDirection = scrollDirectiont;
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        NSInteger lineItemNum = 5;
        layout.itemSize = CGSizeMake((frame.size.width - (lineItemNum - 1)) / lineItemNum, 100);
        UICollectionView *cv = [[UICollectionView alloc] initWithFrame:collectionView.bounds collectionViewLayout:layout];
        cv.delegate = collectionView;
        cv.dataSource = collectionView;
        [cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [cv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReuseHeaderView"];
        cv.backgroundColor = [UIColor blueColor];
        
        [collectionView addSubview:cv];
        collectionView.collectionView = cv;
    }
    
    
    return collectionView;
}

- (void)reloadData {
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataModels.count % 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataModels.count;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReuseHeaderView" forIndexPath:indexPath];
    
    if (reusableview.subviews.count > 0) {
        for (UIView *subView in reusableview.subviews) {
            [subView removeFromSuperview];
        }
    }
    
    reusableview.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, collectionView.frame.size.width - 18, 30)];
    [reusableview addSubview:label];
    label.text = [NSString stringWithFormat:@"Title:%ld", (long)indexPath.section];
    
    
    return reusableview;
    
//
//    UICollectionReusableView *reusableview = nil;
//
//    if (kind == UICollectionElementKindSectionHeader){
//
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReuseHeaderView" forIndexPath:indexPath];
//
//        headerView.backgroundColor = [UIColor blueColor];
//
//        reusableview = headerView;
//
//        }
//
//    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell) {
        //
        NSLog(@"cell for message: %@", self.dataModels[indexPath.row]);
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    return cell;
}

@end
