//
//  ViewController.m
//  ShapeButton
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 Pandora. All rights reserved.
//

#import "ViewController.h"
#import "ShapeButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:38.0/255 green:152.0/255 blue:68.0/255 alpha:1];
    
    ShapeButton *shapeButton = [[ShapeButton alloc] initWithFrame:CGRectMake(100, 200, 120, 120)];
    [shapeButton addTarget:self action:@selector(toggleTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shapeButton];
}

- (void)toggleTouch:(ShapeButton*)button
{
    button.showCircle = !button.showCircle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
