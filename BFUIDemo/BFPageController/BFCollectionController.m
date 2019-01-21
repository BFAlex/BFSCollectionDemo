//
//  BFCollectionController.m
//  BFUIDemo
//
//  Created by 刘玲 on 2018/9/20.
//  Copyright © 2018年 BFAlex. All rights reserved.
//

#import "BFCollectionController.h"
#import "BFCollectionView.h"

@interface BFCollectionController ()
@property (nonatomic, weak) BFCollectionView *contentView;
@property (nonatomic, strong) NSArray *testData;
@end

@implementation BFCollectionController

#pragma mark - API

+ (instancetype)controllerWithViewFrame:(CGRect)frame andScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    
    BFCollectionController *controller = [[BFCollectionController alloc] init];
    if (controller) {
        
        controller.view.frame = frame;
    }
    
    return controller;
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupContentView];
    [self testViewData];
}

- (void)viewDidAppear:(BOOL)animated {
    
//    __block typeof(self) blockSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.contentView.dataModels = @[@"A", @"B", @"C", @"D"];
//    });
}

#pragma mark - Feature

- (void)testViewData {
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 23; i++) {
        [datas addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    self.contentView.dataModels = datas;
}

- (void)configDefaultInfo {
    
}

- (void)setupContentView {
    
    BFCollectionView *cv = [BFCollectionView collectionViewWithFrame:self.view.bounds andScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.view addSubview:cv];
    self.contentView = cv;
}


@end
