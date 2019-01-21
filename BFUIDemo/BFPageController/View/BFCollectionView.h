//
//  BFCollectionView.h
//  BFUIDemo
//
//  Created by 刘玲 on 2018/9/20.
//  Copyright © 2018年 BFAlex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFDataModel.h"

@interface BFCollectionView : UIView

@property (nonatomic, strong) NSArray<BFDataModel *> *dataModels;   

+ (instancetype)collectionViewWithFrame:(CGRect)frame andScrollDirection:(UICollectionViewScrollDirection)scrollDirection;
- (void)reloadData;

@end
