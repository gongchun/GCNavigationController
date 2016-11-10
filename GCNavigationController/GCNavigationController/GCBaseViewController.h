//
//  GCBaseViewController.h
//  GCNavigationController
//
//  Created by 龚纯 on 16/11/7.
//  Copyright © 2016年 龚纯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCNavigationBar.h"

@interface GCBaseViewController : UIViewController
/** 自定义的导航栏 继承自GCBaseViewController都会拥有 */
@property (strong ,nonatomic) GCNavigationBar *gc_navigationbar;

//设置自定义状态栏的颜色
-(void)setStatusBarBackgroundColor:(UIColor *)color;

//隐藏自定义导航栏
-(void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
