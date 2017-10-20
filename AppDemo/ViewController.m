//
//  ViewController.m
//  AppDemo
//
//  Created by Doan Van Vu on 10/19/17.
//  Copyright © 2017 Doan Van Vu. All rights reserved.
//

#import "UIView+Pinchable.h"
#import "UIView+Movable.h"
#import "UIView+Rotable.h"
#import "ViewController.h"
#import "Constants.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView* parentView;
@property (nonatomic) UIView* demoView;
@property (nonatomic) CGFloat edgeSize;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    [_parentView setBackgroundColor:[UIColor redColor]];
    _edgeSize = EDGE_SIZE;
    _demoView = [[UIView alloc] init];
    _demoView.frame = CGRectMake(self.view.center.x - _edgeSize / 2, self.view.center.y - _edgeSize / 2, _edgeSize, _edgeSize);
    [_demoView setBackgroundColor:[UIColor greenColor]];
    [_parentView addSubview:_demoView];

    // drag
    [_demoView enableMovable];

    // rotate
    [_demoView enableRotable];

    // zoom
    [_demoView enablePinchable];
}

@end
