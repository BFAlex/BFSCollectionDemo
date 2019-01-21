//
//  BFPageControllerItem.h
//  BFUIDemo
//
//  Created by 刘玲 on 2018/9/18.
//  Copyright © 2018年 BFAlex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BFPageControllerItem : NSObject

@property (nonatomic, strong) NSString *pageTitle;
@property (nonatomic, strong) UIViewController *pageController;

+ (instancetype)item;

@end
