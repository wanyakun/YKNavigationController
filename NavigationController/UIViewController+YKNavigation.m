//
//  UIViewController+YKNavigation.m
//  NavigationControllerDemo
//
//  Created by wanyakun on 16/4/14.
//  Copyright © 2016年 wanyakun. All rights reserved.
//

#import "UIViewController+YKNavigation.h"
#import <objc/runtime.h>

@implementation UIViewController (YKNavigation)

- (BOOL)canNotUseInteractivePopGestureRecognizer {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCanNotUseInteractivePopGestureRecognizer:(BOOL)canNotUseInteractivePopGestureRecognizer {
    objc_setAssociatedObject(self, @selector(canNotUseInteractivePopGestureRecognizer), @(canNotUseInteractivePopGestureRecognizer), OBJC_ASSOCIATION_RETAIN);
}

- (YKNavigationController *)yk_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYk_navigationController:(YKNavigationController *)yk_navigationController {
    objc_setAssociatedObject(self, @selector(yk_navigationController), yk_navigationController, OBJC_ASSOCIATION_RETAIN);
}

@end
