//
//  YKNavigationController.h
//  NavigationControllerDemo
//
//  Created by wanyakun on 16/1/15.
//  Copyright © 2016年 wanyakun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (YKWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface YKNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, strong, readonly) NSArray *yk_viewControllers;

@end
