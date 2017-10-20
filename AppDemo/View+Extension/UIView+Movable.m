//
//  UIView+Movable.m
//  AppDemo
//
//  Created by Doan Van Vu on 10/19/17.
//  Copyright © 2017 Doan Van Vu. All rights reserved.
//

#import "UIView+Movable.h"
#import <objc/runtime.h>

@implementation UIView (Movable)

CGPoint tapBeganPoint;

#pragma mark - setMovable

- (void)setMovable:(BOOL)movable {
    
    self.panGesture.enabled = movable;
}

#pragma mark - enableMovable

- (void)enableMovable {
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.panGesture.maximumNumberOfTouches = 1;
    self.panGesture.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:self.panGesture];
}

#pragma mark - setPanGesture

- (void)setPanGesture:(UIPanGestureRecognizer *)panGesture {
    
    objc_setAssociatedObject(self, @selector(panGesture), panGesture, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - panGesture

- (UIPanGestureRecognizer *)panGesture {
    
    return objc_getAssociatedObject(self, @selector(panGesture));
}

#pragma mark - setShouldMoveAlongY

- (void)setShouldMoveAlongY:(BOOL)newShould {
    
    NSNumber* shouldMoveAlongYBool = [NSNumber numberWithBool:newShould];
    objc_setAssociatedObject(self, @selector(shouldMoveAlongY), shouldMoveAlongYBool, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - shouldMoveAlongY

- (BOOL)shouldMoveAlongY {
    
    NSNumber* moveAlongY = objc_getAssociatedObject(self, @selector(shouldMoveAlongY));
    return (moveAlongY) ? [moveAlongY boolValue] : YES;
}

#pragma mark - setShouldMoveAlongX

- (void)setShouldMoveAlongX:(BOOL)newShould {
    
    NSNumber* shouldMoveAlongXBool = [NSNumber numberWithBool:newShould];
    objc_setAssociatedObject(self, @selector(shouldMoveAlongX), shouldMoveAlongXBool, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - shouldMoveAlongX

- (BOOL)shouldMoveAlongX {
    
    NSNumber* moveAlongX = objc_getAssociatedObject(self, @selector(shouldMoveAlongX));
    return (moveAlongX) ? [moveAlongX boolValue] : YES;
}

#pragma mark - handlePan

- (void)handlePan:(UIPanGestureRecognizer *)sender {
    
    [self.superview bringSubviewToFront:sender.view];
    CGSize parentViewSize = self.superview.frame.size;
    CGPoint translatedPoint = [sender translationInView:self.superview];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        tapBeganPoint = [[sender view] center];
    }
    
    translatedPoint = CGPointMake(tapBeganPoint.x + (([self shouldMoveAlongX]) ? translatedPoint.x : 0), tapBeganPoint.y + (([self shouldMoveAlongY]) ? translatedPoint.y : 0));
    
    CGFloat velocityX = translatedPoint.x;
    CGFloat velocityY = translatedPoint.y;
    
    // X
    if (velocityX <= -self.frame.size.width * 0.4) {
    
        // Don't move
        velocityX = -self.frame.size.width * 0.4;
    }
    
    if (velocityX >= parentViewSize.width + self.frame.size.width * 0.4) {
        
        velocityX = parentViewSize.width + self.frame.size.width * 0.4;
    }
    
    // Y
    if (velocityY <= -self.frame.size.height * 0.4) {
        
        velocityY = -self.frame.size.height * 0.4;
    }
    
    if (velocityY >= parentViewSize.height + self.frame.size.height * 0.4) {
        
        velocityY = parentViewSize.height + self.frame.size.height * 0.4;
    }

    [[sender view] setCenter:CGPointMake(velocityX, velocityY)];
}

@end
