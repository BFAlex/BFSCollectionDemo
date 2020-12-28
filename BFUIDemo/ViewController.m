//
//  ViewController.m
//  BFUIDemo
//
//  Created by 刘玲 on 2018/9/18.
//  Copyright © 2018年 BFAlex. All rights reserved.
//

#import "ViewController.h"
#import "BFPageMenuBarView.h"
#import "BFPageController.h"
#import "UIView+BFExtension.h"
#import "BFCollectionController.h"

@interface ViewController ()
@property (nonatomic, strong) BFPageMenuBarView *menuBar;
@property (nonatomic, strong) BFPageController *pageController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testMenuBarView];
//    [self testPageControllers];
//    [self testTwo];
    [self testCollectionC];
}

- (void)testCollectionC {
    BFCollectionController *cc = [BFCollectionController controllerWithViewFrame:self.view.bounds andScrollDirection:UICollectionViewScrollDirectionVertical];
//    cc.view.frame = self.view.bounds;
    [self addChildViewController:cc];
    [self.view addSubview:cc.view];
}

- (void)testTwo {
    
    NSArray *titles = @[@"A", @"B", @"C", @"D"];
    
    CGFloat menuHeight = 60;
    // MenuBar
    CGRect menuFrame = CGRectMake(0, 20, self.view.width, menuHeight);
    BFPageMenuBarView *menuBar = [BFPageMenuBarView pageMenuBarViewForTitles:titles withFrame:menuFrame];
    [self.view addSubview:menuBar];
    self.menuBar = menuBar;
    menuBar.didSelectMenuItemAtIndex = ^(NSInteger index) {
        [self.pageController scrollPageToIndex:index];
    };
    
    CGFloat y = menuBar.y + menuBar.height + 1;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.view.width, self.view.height - y)];
    [self.view addSubview:contentView];
    // PageController
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        BFPageControllerItem *item = [BFPageControllerItem item];
        item.pageTitle = [NSString stringWithFormat:@"%d", i];
        item.pageController = [[UIViewController alloc] init];
        [items addObject:item];
        //
//        UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
//        tmpLabel.text = [NSString stringWithFormat:@"vc:%d", i];
//        [item.pageController.view addSubview:tmpLabel];
//        tmpLabel.center = item.pageController.view.center;
//        tmpLabel.backgroundColor = [UIColor orangeColor];
//        tmpLabel.textColor = [UIColor blackColor];
//        
//        UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        tmpBtn.frame = CGRectMake(100, 100, 60, 60);
//        [item.pageController.view addSubview:tmpBtn];
//        tmpBtn.backgroundColor = [UIColor orangeColor];
//        [tmpBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
//        tmpBtn.tag = i;
    }
    BFPageController *pageController = [[BFPageController alloc] initWithPageControllerItems:items viewBounds:contentView.bounds andScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self addChildViewController:pageController];
    [contentView addSubview:pageController.view];
    self.pageController = pageController;
    pageController.pageScrollBlock = ^(CGFloat scrollX, CGFloat scrollY) {
        [self.menuBar scrollToX:scrollX andY:scrollY];
    };
}

- (void)actionBtn:(UIButton *)btn {
    NSLog(@"%s%d >>> tag:%d", __func__, __LINE__, btn.tag);
}

- (void)testPageControllers {
    
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        BFPageControllerItem *pcItem = [BFPageControllerItem item];
        pcItem.pageTitle = [NSString stringWithFormat:@"Title%d", i];
        pcItem.pageController = [[UIViewController alloc] init];
        [items addObject:pcItem];
    }
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 64, 200, 300)];
    [self.view addSubview:view1];
    self.pageController = [[BFPageController alloc] initWithPageControllerItems:items viewBounds:view1.bounds andScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [view1 addSubview:self.pageController.view];
    self.pageController.pageScrollBlock = ^(CGFloat scrollX, CGFloat scrollY) {
        NSLog(@"滑动PageView1【%f, %f】", scrollX, scrollY);
    };
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(80, 400, 200, 300)];
    [self.view addSubview:view2];
    BFPageController *pageController = [[BFPageController alloc] initWithPageControllerItems:items viewBounds:view2.bounds andScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self addChildViewController:pageController];
    [view2 addSubview:pageController.view];
    pageController.pageScrollBlock = ^(CGFloat scrollX, CGFloat scrollY) {
        
        NSLog(@"滑动PageView2【%f, %f】", scrollX, scrollY);
    };
}

- (void)testMenuBarView {
    
    CGRect menuBarFrame = CGRectMake(0, 20, self.view.width, 60);
    [self setupMenuBarForTitles:@[@"1", @"2", @"3", @"2", @"3", @"2", @"3", @"2", @"3"] forFrame:menuBarFrame];
    CGRect menuBarFrame2 = CGRectMake(0, 90, self.view.width, 60);
    [self setupMenuBarForTitles:@[@"1", @"2", @"3", @"2", @"3"] forFrame:menuBarFrame2];
}

- (void)setupMenuBarForTitles:(NSArray *)titles forFrame:(CGRect)frame {
    
    BFPageMenuBarView *menuBar = [BFPageMenuBarView pageMenuBarViewForTitles:titles withFrame:frame];
    [self.view addSubview:menuBar];
//    self.menuBar = menuBar;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [menuBar didSelectMenuBarItemAtIndex:3];
    });
}


@end
