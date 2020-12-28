//
//  BFPageController.m
//  BFUIDemo
//
//  Created by 刘玲 on 2018/9/18.
//  Copyright © 2018年 BFAlex. All rights reserved.
//

#import "BFPageController.h"
#import "BFPageMenuBarView.h"

#import "UIView+BFExtension.h"

@interface BFPageController ()
@property (nonatomic, strong) NSArray *pageControllers;
@property (nonatomic, strong) UIView *menuBar;

@end

@implementation BFPageController

static NSString * const reuseIdentifier = @"BFPageControllerCell";

#pragma mark - API

//+ (instancetype)pageControllerWithTitles:(NSArray *)titles andControllers:(NSArray *)controllers forScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
//
//    BFPageController *pc = [[BFPageController alloc] init];
//    if (pc) {
//        //
//    }
//
//    return pc;
//}
- (instancetype)initWithPageControllerTitles:(NSArray *)titles controllers:(NSArray *)controllers andScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    
    UICollectionViewLayout *cvLayout = [BFPageController setupCollectionLayoutForScrollDirection:scrollDirection andFrame:[UIScreen mainScreen].bounds];
    if (self = [super initWithCollectionViewLayout:cvLayout]) {
        
    }
    
    
    return self;
}

- (instancetype)initWithPageControllerItems:(NSArray<BFPageControllerItem *> *)pcItems viewBounds:(CGRect)bounds andScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    
    UICollectionViewLayout *cvLayout = [BFPageController setupCollectionLayoutForScrollDirection:scrollDirection andFrame:bounds];
    if (self = [super initWithCollectionViewLayout:cvLayout]) {
        
        self.collectionView.frame = bounds;
        [self setupDefaultConfig];
        
        NSMutableArray *pcTitles = [NSMutableArray array];
        NSMutableArray *pcControllers = [NSMutableArray array];
        for (int i = 0; i < pcItems.count; i++) {
            BFPageControllerItem *item = pcItems[i];
            if (item.pageTitle.length > 0 && item.pageController) {
                [pcTitles addObject:item.pageTitle];
                [pcControllers addObject:item.pageController];
            }
        }
        self.pageControllers = pcControllers;
        // 设置分页内容
        [self setupPageControllerItems];
    }
    
    
    return self;
}

- (void)scrollPageToIndex:(NSInteger)index {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark - Feature

- (void)setupPageControllerItems {
    
}

+ (UICollectionViewLayout *)setupCollectionLayoutForScrollDirection:(UICollectionViewScrollDirection)scrollDirection andFrame:(CGRect)frame {
    
    UICollectionViewFlowLayout *cvLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置间距
    cvLayout.minimumLineSpacing = 0;
    // 滑动方向
    cvLayout.scrollDirection = scrollDirection;
    cvLayout.itemSize = frame.size;
    cvLayout.minimumLineSpacing = 1;
    
    return cvLayout;
}

- (void)setupDefaultConfig {
    // register cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
//    return 0;
    return self.pageControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
//    if (indexPath.row % 2) {
//        cell.backgroundColor = [UIColor blueColor];
//    } else {
//        cell.backgroundColor = [UIColor yellowColor];
//    }
    UIViewController *targetVC = self.pageControllers[indexPath.row];
    [cell addSubview:targetVC.view];
    if (indexPath.row % 2) {
        targetVC.view.backgroundColor = [UIColor blueColor];
    } else {
        targetVC.view.backgroundColor = [UIColor yellowColor];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.pageScrollBlock) {
        self.pageScrollBlock(scrollView.contentOffset.x, scrollView.contentOffset.y);
    }
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
