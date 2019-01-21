//
//  BFPageMenuBarView.h
//  BFUIDemo
//
//  Created by 刘玲 on 2018/9/19.
//  Copyright © 2018年 BFAlex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFPageMenuBarView : UIView

@property(nonatomic, copy) void(^didSelectMenuItemAtIndex)(NSInteger index);

+ (instancetype)pageMenuBarViewForTitles:(NSArray<NSString *> *)titles withFrame:(CGRect)frame;
- (void)didSelectMenuBarItemAtIndex:(NSInteger)index;
- (void)scrollToX:(CGFloat)x andY:(CGFloat)y;

@end
