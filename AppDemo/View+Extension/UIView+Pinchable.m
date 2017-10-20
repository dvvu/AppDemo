//
//  UIView+Pinchable.m
//  AppDemo
//
//  Created by Doan Van Vu on 10/20/17.
//  Copyright © 2017 Doan Van Vu. All rights reserved.
//

#import "UIView+Pinchable.h"
#import <objc/runtime.h>

@implementation UIView (Pinchable)

CGSize currentViewSize;

#pragma mark - setPinchable

- (void)setPinchable:(BOOL)pinchable {
    
    self.pinchGesture.enabled = pinchable;
}

#pragma mark - enablePinchable

- (void)enablePinchable {
    
    self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchWithGestureRecognizer:)];
    [self.superview addGestureRecognizer:self.pinchGesture];
    currentViewSize = self.frame.size;
}

#pragma mark - setPanGesture

- (void)setPinchGesture:(UIPinchGestureRecognizer *)pinchGesture {
    
    objc_setAssociatedObject(self, @selector(pinchGesture), pinchGesture, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - pinchGestureRecognizer

- (UIPinchGestureRecognizer *)pinchGesture {
    
    return objc_getAssociatedObject(self, @selector(pinchGesture));
}

#pragma mark - pinchWithGestureRecognizer

CGFloat lastScaleFactor;

- (void)pinchWithGestureRecognizer:(UIPinchGestureRecognizer *)sender {
    
    // zoom in
    if (sender.scale < 1) {
        
        if (self.frame.size.height < currentViewSize.height) {
            
            return;
        } else {
         
            self.transform = CGAffineTransformScale(self.transform, sender.scale, sender.scale);
        }
    } else { // zoom in
        
        self.transform = CGAffineTransformScale(self.transform, sender.scale, sender.scale);
    }
    
    sender.scale = 1.0;
}

@end
