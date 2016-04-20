//
//  UIViewController+YKNavigation.h
//  NavigationControllerDemo
//
//  Created by wanyakun on 16/4/14.
//  Copyright © 2016年 wanyakun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKNavigationController.h"

@interface UIViewController (YKNavigation)

@property (nonatomic, assign) BOOL canNotUseInteractivePopGestureRecognizer;

@property (nonatomic, strong) YKNavigationController *yk_navigationController;

@end
