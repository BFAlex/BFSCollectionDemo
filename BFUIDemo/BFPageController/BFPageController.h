//
//  BFPageController.h
//  BFUIDemo
//
//  Created by 刘玲 on 2018/9/18.
//  Copyright © 2018年 BFAlex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFPageControllerItem.h"

typedef void(^PageScrollBlock)(CGFloat scrollX, CGFloat scrollY);

@interface BFPageController : UICollectionViewController

@property(nonatomic, copy) PageScrollBlock pageScrollBlock;

//+ (instancetype)pageControllerWithTitles:(NSArray *)titles andControllers:(NSArray *)controllers forScrollDirection:(UICollectionViewScrollDirection)scrollDirection;
// 方法一
- (instancetype)initWithPageControllerTitles:(NSArray *)titles
                                 controllers:(NSArray *)controllers
                          andScrollDirection:(UICollectionViewScrollDirection)scrollDirection;
// 方法二
- (instancetype)initWithPageControllerItems:(NSArray<BFPageControllerItem *> *)pcItems
                                     viewBounds:(CGRect)bounds
                         andScrollDirection:(UICollectionViewScrollDirection)scrollDirection;

- (void)scrollPageToIndex:(NSInteger)index;


@end
