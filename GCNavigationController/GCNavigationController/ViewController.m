//
//  ViewController.m
//  GCNavigationController
//
//  Created by 龚纯 on 16/11/7.
//  Copyright © 2016年 龚纯. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
    [btn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    self.gc_navigationbar.title = @"这是自定义的标题";
    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    test.backgroundColor = [UIColor redColor];
    self.gc_navigationbar.leftView = test;
    
    [self setStatusBarBackgroundColor:[UIColor purpleColor]];

}

- (void)btnOnClick {
//    ZJTest1ViewController *vc = [ZJTest1ViewController new];
//    [self showViewController:vc sender:nil];
//
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
