//
//  UIView+Rotable.m
//  AppDemo
//
//  Created by Doan Van Vu on 10/19/17.
//  Copyright © 2017 Doan Van Vu. All rights reserved.
//

#import "UIView+Rotable.h"
#import <objc/runtime.h>

@implementation UIView (Rotable)

#pragma mark - setRotable

- (void)setRotable:(BOOL)rotable {
    
    self.rotationGesture.enabled = rotable;
}

#pragma mark - enableRotable

- (void)enableRotable {
    
    self.rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationWithGestureRecognizer:)];
    [self addGestureRecognizer:self.rotationGesture];
}

#pragma mark - setRotationGesture

- (void)setRotationGesture:(UIRotationGestureRecognizer *)rotationGesture {
    
    objc_setAssociatedObject(self, @selector(rotationGesture), rotationGesture, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - rotationGesture

- (UIRotationGestureRecognizer *)rotationGesture {
    
    return objc_getAssociatedObject(self, @selector(rotationGesture));
}

#pragma mark - rotationWithGestureRecognizer

- (void)rotationWithGestureRecognizer:(UIRotationGestureRecognizer *)sender {

    self.transform = CGAffineTransformRotate(self.transform, sender.rotation);
    sender.rotation = 0.0;
}

@end
