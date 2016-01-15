//
//  YKNavigationController.m
//  NavigationControllerDemo
//
//  Created by wanyakun on 16/1/15.
//  Copyright © 2016年 wanyakun. All rights reserved.
//

#import "YKNavigationController.h"

@interface YKNavigationController ()<UIViewControllerAnimatedTransitioning>

@end

@implementation YKNavigationController



#pragma mark - Delegate
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Get the two view controllers
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // where the animation has to happen
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    toVC.view.alpha = 0.0;
    // Perform the animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:0
                     animations:^{
                         toVC.view.alpha = 1.f;
                     }
                     completion:^(BOOL finished) {
                         [fromVC.view removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
}

@end
