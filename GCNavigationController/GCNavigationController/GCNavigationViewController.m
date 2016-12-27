//
//  GCNavigationViewController.m
//  GCNavigationController
//
//  Created by 龚纯 on 16/11/9.
//  Copyright © 2016年 龚纯. All rights reserved.
//

#import "GCNavigationViewController.h"
#import "GCNavigationControllerAnimator.h"
#import "GCBaseViewController.h"

@interface GCNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    BOOL _isInteracting;
}
@property (nonatomic ,strong) GCNavigationControllerAnimator *animator;
@property (nonatomic ,strong) UIPanGestureRecognizer *fullScreenPanGesture;
@property (nonatomic ,strong) UIPercentDrivenInteractiveTransition *interactive;
@end

@implementation GCNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)gc_fullScreenPop:(BOOL)enabled{
    if (enabled) {
        // 添加手势在系统的手势的view上面
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fullScreenPanGesture];
        // 禁用系统的手势
        self.interactivePopGestureRecognizer.enabled = NO;
        //设置代理
        self.delegate = self;
        //隐藏系统navigationBar
        self.navigationBarHidden = YES;
        
    }else{
        self.delegate = nil;
        self.fullScreenPanGesture = nil;
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}


-(void)handelPanGesture:(UIPanGestureRecognizer *)panGesture{
    CGPoint transtion = [panGesture translationInView:panGesture.view];
    CGFloat progress = transtion.x/panGesture.view.bounds.size.width;
    
    progress = MIN(1.0f, MAX(progress, 0.0f));
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //记录手势
            _isInteracting = YES;
            if (self.viewControllers.count > 1) {//不是第一个页面
                //执行pop动画
                [self popViewControllerAnimated:YES];
            }

        }
        break;
        case UIGestureRecognizerStateChanged:{
            CGPoint transtion = [panGesture translationInView:panGesture.view];
            CGFloat progress = transtion.x/panGesture.view.bounds.size.width;
            
            progress = MIN(1.0f, MAX(progress, 0.0f));
            //跟新动画进度
            [self.interactive updateInteractiveTransition:progress];
        }
        break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            if (progress > 0.35) {
                //动画完成
                [self.interactive finishInteractiveTransition];
            }else{
                CGPoint velocity = [panGesture velocityInView:panGesture.view];
                if (velocity.x > 200) {//滑动距离小 但是很快 视为完成
                    [self.interactive finishInteractiveTransition];
                }else{
                    [self.interactive cancelInteractiveTransition];
                }
            }
        }
            _isInteracting = NO;//手势完成
            break;
        default:
            _isInteracting = NO;
            break;
    }
}


#pragma mark getter setter
-(UIPanGestureRecognizer *)fullScreenPanGesture{
    if (_fullScreenPanGesture == nil) {
        UIPanGestureRecognizer *panGuester = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handelPanGesture:)];
        panGuester.delegate = self;
        _fullScreenPanGesture = panGuester;
    }
    return _fullScreenPanGesture;
}

-(GCNavigationControllerAnimator *)animator{
    if (!_animator) {
        _animator = [[GCNavigationControllerAnimator alloc] init];
    }
    return _animator;
}

#pragma mark UINavigationDelegate 
//手势交互对象
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    //如果使用自定义对象 返回的是我们交互的对象
    if ([animationController isKindOfClass:[GCNavigationViewController class]]&&_isInteracting) {
        //手势已经开始才返回self.interactor
        self.animator.isInteractionAnimation = YES;
        return self.interactive;
    }else{
        // 手势没有开始返回nil, 否则我们的非交互性动画也是不能执行的,
        // 因为系统会优先调用这个代理方法, 如果返回的不是nil, 就不会调用非交互性代理方法了
        self.animator.isInteractionAnimation = NO;
        return nil;
    }
}

//非交互对象
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    //设置交互类型pop还是push
    self.animator.operation = operation;
    return self.animator;
}


//处理返回按钮的 影藏
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[GCNavigationViewController class]]) {
        GCBaseViewController *baseVC = (GCBaseViewController *)viewController;
        if (self.viewControllers.count > 1) {
            baseVC.gc_navigationbar.leftButton.hidden = NO;
        }else{
            baseVC.gc_navigationbar.leftButton.hidden = YES;
        }
    }
}

@end

@implementation UIViewController (GCNavigationViewController)

-(GCNavigationViewController *)gc_NavigationViewController{
    return (GCNavigationViewController *)self.navigationController;
}
@end