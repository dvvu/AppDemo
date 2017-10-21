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
CGPoint currentPoint;

#pragma mark - setMovable

- (void)setMovable:(BOOL)movable {
    
    self.panGesture.enabled = movable;
}

#pragma mark - enableMovable

- (void)enableMovable {
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.panGesture.maximumNumberOfTouches = 1;
    self.panGesture.minimumNumberOfTouches = 1;
    [self.superview addGestureRecognizer:self.panGesture];
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
    
    currentPoint = self.center;
    [self.superview.superview bringSubviewToFront:sender.view];
    CGSize parentViewSize = self.superview.frame.size;
    CGPoint translatedPoint = [sender translationInView:self.superview];

    if (sender.state == UIGestureRecognizerStateBegan) {

        tapBeganPoint = [[sender view] center];
    }

    translatedPoint = CGPointMake(currentPoint.x + (([self shouldMoveAlongX]) ? translatedPoint.x : 0), currentPoint.y + (([self shouldMoveAlongY]) ? translatedPoint.y : 0));

    CGFloat velocityX = translatedPoint.x;
    CGFloat velocityY = translatedPoint.y;
    
    // thredHold = maximum conner 45 -> 0.707
    CGFloat thredHold = 0.707 - 0.5;
    
    // X
    if (velocityX <= -self.frame.size.width * thredHold) {

        // Don't move
        velocityX = -self.frame.size.width * thredHold;
    }

    if (velocityX >= parentViewSize.width + self.frame.size.width * thredHold) {

        velocityX = parentViewSize.width + self.frame.size.width * thredHold;
    }

    // Y
    if (velocityY <= -self.frame.size.height * thredHold) {

        velocityY = -self.frame.size.height * thredHold;
    }

    if (velocityY >= parentViewSize.height + self.frame.size.height * thredHold) {

        velocityY = parentViewSize.height + self.frame.size.height * thredHold;
    }
    
    currentPoint = CGPointMake(velocityX, velocityY);
    [self setCenter:currentPoint];
    [sender setTranslation:CGPointZero inView:self.superview];
}

@end
