//
//  GCNavigationBar.m
//  GCNavigationController
//
//  Created by 龚纯 on 16/11/7.
//  Copyright © 2016年 龚纯. All rights reserved.
//

//自定义nacigationbar

#import "GCNavigationBar.h"

@interface GCNavigationBar ()

@property (strong ,nonatomic) UIView *contentView;
@property (strong ,nonatomic) UIView *statusBarView;
@end

@implementation GCNavigationBar


-(void)UIInit{
    //设置背景颜色
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.95f];
    [self addSubview:self.contentView];
    [self addSubview:self.statusBarView];
    
    //中间的titleView
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment= NSTextAlignmentCenter;
    self.titleView = titleLabel;
    
    //左边的返回按钮
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.frame = CGRectMake(0, 0, 44.0f, 0);
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.leftButton = leftBtn;
    
}

-(void)leftBtnClick{
    UIViewController *viewController = [self getViewController];
    if (viewController.navigationController.viewControllers.count > 1) {
        if (viewController.navigationController.viewControllers.count > 1) {
            
            [viewController.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(UIViewController *)getViewController{
    UIResponder *currentResponder = self;
    while (currentResponder) {
        if ([currentResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)currentResponder;
        }else{
            currentResponder = currentResponder.nextResponder;
        }
    }
    return nil;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat statusBarHeight = 20.0f;
    CGFloat leftOrRightMargin = 10.0f;
    self.statusBarView.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, statusBarHeight);
    self.contentView.frame = CGRectMake(0, statusBarHeight, self.bounds.size.width, self.bounds.size.height - statusBarHeight);
    self.titleView.frame = CGRectOffset(self.titleView.bounds, (self.contentView.bounds.size.width-self.titleView.bounds.size.width)/2, (self.contentView.bounds.size.height-self.titleView.bounds.size.height)/2);
    if (_leftButton) {
        CGFloat leftBtnHeight = _leftButton.bounds.size.height != 0 ? _leftButton.bounds.size.height : self.contentView.bounds.size.height;
        CGFloat leftBtnY = (self.contentView.bounds.size.height - leftBtnHeight)/ 2;
        _leftButton.frame = CGRectMake(leftOrRightMargin, leftBtnY, _leftButton.bounds.size.width, leftBtnHeight);
        
    }
    
    if (_rightView) {
        _rightView.frame = CGRectMake(self.bounds.size.width - self.rightView.bounds.size.width - leftOrRightMargin, 0, _rightView.bounds.size.width, _rightView.bounds.size.height);
    }
    
    if (_leftView) {
        CGFloat leftViewHeight = _leftView.bounds.size.height != 0 ? _leftView.bounds.size.height : self.contentView.bounds.size.height;
        CGFloat leftViewY = (self.contentView.bounds.size.height-leftViewHeight)/2;
        
        _leftView.frame = CGRectMake(leftOrRightMargin, leftViewY, _leftView.bounds.size.width, leftViewHeight);
    }
}

-(void)setTitle:(NSString *)title{
    self.title = title;
    
    if (_titleView && [_titleView isKindOfClass:[UILabel class]]) {
        UILabel *titleLabel = ((UILabel *) self.titleView);
        if (titleLabel) {
            titleLabel.text = title;
            [titleLabel sizeToFit];
        }
    }
}


-(void)setLeftButton:(UIButton *)leftButton{
    if (self.leftButton) {
        [self.leftButton removeFromSuperview];
        self.leftButton = nil;
    }
    self.leftButton = leftButton;
    [self.contentView addSubview:self.leftButton];
}

-(void)setLeftView:(UIView *)leftView{
    if (self.leftButton) {
        [self.leftButton removeFromSuperview];
        self.leftButton = nil;
    }
    
    if (self.leftView) {
        [self.leftView removeFromSuperview];
        self.leftView = nil;
    }
    self.leftView = leftView;
    [self.contentView addSubview:self.leftView];
}

-(void)setRightView:(UIView *)rightView{
    if (self.rightView) {
        [self.rightView removeFromSuperview];
        self.rightView = nil;
    }
    self.rightView = rightView;
    [self.contentView addSubview:self.rightView];
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

-(UIView *)statusBarView{
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] init];
        _statusBarView.backgroundColor = [UIColor clearColor];
    }
    return _statusBarView;
}

@end
