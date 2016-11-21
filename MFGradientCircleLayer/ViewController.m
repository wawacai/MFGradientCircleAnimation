//
//  ViewController.m
//  MFGradientCircleLayer
//
//  Created by 彭作青 on 2016/11/21.
//  Copyright © 2016年 myself. All rights reserved.
//

#import "ViewController.h"
#import "MFGradientCircleLayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MFGradientCircleLayer *cicle = [[MFGradientCircleLayer alloc] initGradientCircleWithBounds:CGRectMake(0, 0, 100, 100) Position:CGPointMake(200, 200) FromColor:[UIColor whiteColor] ToColor:[UIColor redColor] LineWidth:3.0];
    
    [self.view.layer addSublayer:cicle];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
