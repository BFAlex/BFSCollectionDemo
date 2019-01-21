//
//  UIView+BFExtension.m
//  BFUIDemo
//
//  Created by 刘玲 on 2018/9/19.
//  Copyright © 2018年 BFAlex. All rights reserved.
//

#import "UIView+BFExtension.h"

@implementation UIView (BFExtension)


- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (CGFloat)y {
    
    return self.frame.origin.y;
}

- (CGFloat)width {
    
    return self.bounds.size.width;
}

- (CGFloat)height {
    
    return self.bounds.size.height;
}

@end
