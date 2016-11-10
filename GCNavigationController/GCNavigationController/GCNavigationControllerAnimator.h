//
//  GCNavigationControllerAnimator.h
//  GCNavigationController
//
//  Created by 龚纯 on 16/11/9.
//  Copyright © 2016年 龚纯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCNavigationControllerAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign ,nonatomic) UINavigationControllerOperation operation;

@property (assign ,nonatomic) BOOL isInteractionAnimation;

@end
