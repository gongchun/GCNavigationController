//
//  GCNavigationControllerAnimator.m
//  GCNavigationController
//
//  Created by 龚纯 on 16/11/9.
//  Copyright © 2016年 龚纯. All rights reserved.
//

#import "GCNavigationControllerAnimator.h"

@interface GCNavigationControllerAnimator ()

@end

@implementation GCNavigationControllerAnimator

//定义转场动画时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.25f;
}

//真正的动画
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //将要消失的视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //将要展示的视图
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //容器view
    UIView *containerView = [transitionContext containerView];
    UIView *fromView;
    UIView *toView;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromVC.view;
        toView = toVC.view;
    }
    
    //最终显示在屏幕上的view大小
    CGRect finalFrame = [UIScreen mainScreen].bounds;
    
    //隐藏在屏幕左边的view
    CGRect leftHiddenFrame = finalFrame;
    leftHiddenFrame.origin.x = -finalFrame.size.width/2;
    //隐藏在屏幕右边的view
    CGRect rightHiddenFrame = finalFrame;
    rightHiddenFrame.origin.x = finalFrame.size.width;
    
    if (self.operation == UINavigationControllerOperationPush) {
        //push动画，设置将要出现view的初始位置
        toView.frame = rightHiddenFrame;
        //添加将要出现的view在上面
        [containerView insertSubview:toView aboveSubview:fromView];
        [self drawShadowForView:containerView];
        
        UIViewAnimationOptions option = self.isInteractionAnimation ? UIViewAnimationOptionCurveLinear : UIViewAnimationOptionCurveEaseInOut;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f options:option animations:^{
            
            //把消失的view 影藏的左边
            fromView.frame = leftHiddenFrame;
            //需要展示的view展示出来
            toView.frame = finalFrame;
        } completion:^(BOOL finished) {
            //判断是否取消动画
            BOOL cancel = [transitionContext transitionWasCancelled];
            if(cancel){
                //如果动画取消 就取消移动toview
                [toView removeFromSuperview];
            }
            // 一定要调用这个方法, 告诉系统动画已经执行完成
            [transitionContext completeTransition:cancel];
        }];
    }
    
    if (self.operation == UINavigationControllerOperationPop) {
        toView.frame = leftHiddenFrame;
        //添加到头view的下面
        [containerView insertSubview:toView belowSubview:fromView];
        
        UIViewAnimationOptions option = self.isInteractionAnimation ? UIViewAnimationOptionCurveLinear : UIViewAnimationOptionCurveEaseInOut;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f options:option animations:^{
            
            fromView.frame = rightHiddenFrame;
            toView.frame = finalFrame;
        } completion:^(BOOL finished) {
            //判断是否取消动画
            BOOL cancel = [transitionContext transitionWasCancelled];
            if (cancel) {
                [toView removeFromSuperview];
            }
            
            [transitionContext completeTransition:cancel];
        }];
    }
}

-(void)drawShadowForView:(UIView *)view{
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 3.0f;
    view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:view.bounds] CGPath];
    view.layer.shadowOffset = CGSizeZero;
    view.layer.shadowOpacity = 0.3f;

}
@end
