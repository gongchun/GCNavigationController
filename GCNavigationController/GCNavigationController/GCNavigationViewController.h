//
//  GCNavigationViewController.h
//  GCNavigationController
//
//  Created by 龚纯 on 16/11/9.
//  Copyright © 2016年 龚纯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, GCNavigationControllerAnimationStyle) {
    GCNavigationControllerAnimationStyleNone
};

@class GCNavigationControllerAnimator;

@interface GCNavigationViewController : UINavigationController

@property (assign ,nonatomic) GCNavigationControllerAnimationStyle  gcNavigationControllerAnimationStyle;

-(void)gc_fullScreenPop:(BOOL)enabled;

@end

//类拓展
@interface UIViewController (GCNavigationViewController)

@property (weak,nonatomic ,readonly) GCNavigationViewController *gc_NavigationViewController;

@end
