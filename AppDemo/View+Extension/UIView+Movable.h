//
//  UIView+Movable.h
//  AppDemo
//
//  Created by Doan Van Vu on 10/19/17.
//  Copyright © 2017 Doan Van Vu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (movable)

#pragma mark - shouldMoveAlongX
@property (nonatomic) BOOL shouldMoveAlongX;

#pragma mark - shouldMoveAlongY
@property (nonatomic) BOOL shouldMoveAlongY;

#pragma mark - movable
- (void)setMovable:(BOOL)movable;

#pragma mark - enableMovable
- (void)enableMovable;

@end
