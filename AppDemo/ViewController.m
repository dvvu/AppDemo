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

@property (nonatomic) UIView* demoView;
@property (nonatomic) CGFloat edgeSize;

@property (nonatomic) UIView* demoView1;
@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    _edgeSize = EDGE_SIZE;
    _demoView = [[UIView alloc] init];
    _demoView.frame = CGRectMake(self.view.center.x - _edgeSize / 2, self.view.center.y - _edgeSize / 2, _edgeSize, _edgeSize);
    [_demoView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_demoView];

    // drag
    [_demoView enableMovable];

    // rotate
    [_demoView enableRotable];

    // zoom
    [_demoView enablePinchable];
    
    
    _demoView1 = [[UIView alloc] init];
    _demoView1.frame = CGRectMake(self.view.center.x - _edgeSize / 2, self.view.center.y - _edgeSize / 2, _edgeSize, _edgeSize);
    [_demoView1 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_demoView1];
    
    // drag
    [_demoView1 enableMovable];
    
    // rotate
    [_demoView1 enableRotable];
    
    // zoom
    [_demoView1 enablePinchable];
}

@end
