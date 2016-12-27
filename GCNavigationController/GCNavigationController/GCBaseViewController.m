//
//  GCBaseViewController.m
//  GCNavigationController
//
//  Created by 龚纯 on 16/11/7.
//  Copyright © 2016年 龚纯. All rights reserved.
//

#import "GCBaseViewController.h"

#define StatusBarHeight = 20.0f
#define NavigationBarHeight = 46.0f

@interface GCBaseViewController ()

@end

@implementation GCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.gc_navigationbar];
}

-(void)leftButtonClick{
    if (self.navigationController.viewControllers.count > 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//隐藏自定义导航栏
-(void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated{
    
    if (hidden) {
        
        CGRect frame = self.gc_navigationbar.frame;
        frame.origin.y = -frame.size.height;
        CGFloat duration = animated ? 0.25f : 0.0f;
        [UIView animateWithDuration:duration animations:^{
            self.gc_navigationbar.frame = frame;
            
        } completion:^(BOOL finished) {
            
            self.gc_navigationbar.hidden = hidden;
            
        }];
    }else{
        
        CGRect frame = self.gc_navigationbar.frame;
        frame.origin.y = 0.0f;
        if (self.view.bounds.size.width > self.view.bounds.size.height) {// 横屏
            frame.origin.y = -20.0f;
        }
        
        CGFloat duration = animated ? 0.25f : 0.0f;
        [UIView animateWithDuration:duration animations:^{
            self.gc_navigationbar.frame = frame;
            self.gc_navigationbar.hidden = hidden;
        }];
    }
}


//设置导航状态栏的背景颜色
-(void)setStatusBarBackgroundColor:(UIColor *)color{
    if (self.gc_navigationbar) {
        self.gc_navigationbar.statusBarBackgroundColor = color;
    }
}


//懒加载
-(GCNavigationBar *)gc_navigationbar{
    if (!_gc_navigationbar) {
        _gc_navigationbar = [[GCNavigationBar alloc] init];
    }
    return _gc_navigationbar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
