//
//  GCNavigationBar.h
//  GCNavigationController
//
//  Created by 龚纯 on 16/11/7.
//  Copyright © 2016年 龚纯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCNavigationBar : UIView

/**中间标题**/
@property (strong ,nonatomic) NSString *title;
/**中间的view**/
@property (strong ,nonatomic) UIView *titleView;
/**左边的返回按钮**/
@property (strong ,nonatomic) UIButton *leftButton;
/** 可以间接设置状态栏背景色 */
@property (strong, nonatomic) UIColor *statusBarBackgroundColor;
/** 右边的view 需要设置frame的宽度 */
@property (strong, nonatomic) UIView *rightView;
/** 左边的view 需要设置frame的宽度 */
@property (strong, nonatomic) UIView *leftView;

@end
