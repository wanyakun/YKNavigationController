//
//  YKNavigationController.m
//  NavigationControllerDemo
//
//  Created by wanyakun on 16/1/15.
//  Copyright © 2016年 wanyakun. All rights reserved.
//

#import "YKNavigationController.h"
#import "UIViewController+YKNavigation.h"

#pragma makr - YKWrapNavigationController

@interface YKWrapNavigationController : UINavigationController

@end

@implementation YKWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    YKNavigationController *yk_navigationController = (YKNavigationController *)viewController.yk_navigationController;
    NSInteger index = [yk_navigationController.yk_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:yk_navigationController.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.yk_navigationController = (YKNavigationController *)self.navigationController;
    
    UIImage *backButtonImage = viewController.yk_navigationController.backButtonImage;
    if (backButtonImage == nil) {
        backButtonImage = [self backButtonImage];
    }
    
    UIBarButtonItem *navigationSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    navigationSpace.width = -10;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    viewController.navigationItem.leftBarButtonItems = @[navigationSpace, leftBarButtonItem];
    
    [self.navigationController pushViewController:[YKWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.yk_navigationController = nil;
}

- (UIImage *)backButtonImage {

    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = 44;
    CGFloat height = 44;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width*scale, height*scale, 8, 4 * width*scale, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextSetLineWidth(context, scale);
    CGContextScaleCTM(context, 1, 1);
    
    CGPoint aPoints[3];//坐标点
    aPoints[0] =CGPointMake(12*scale, 10*scale);//坐标1
    aPoints[1] =CGPointMake(1, 21*scale);//坐标2
    aPoints[2] =CGPointMake(12*scale, 32*scale);//坐标3
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    
    CGContextAddLines(context, aPoints, 3);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径

    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = [UIImage imageWithCGImage:imageMasked scale:scale orientation:UIImageOrientationUp];
    CGImageRelease(imageMasked);
    return image;
}

@end

#pragma mark - YKWrapViewController

static NSValue *yk_tabBarRectValue;

@implementation YKWrapViewController

+ (YKWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    YKWrapNavigationController *wrapNavigationController = [[YKWrapNavigationController alloc] init];
    wrapNavigationController.viewControllers = @[viewController];
    
    YKWrapViewController *wrapViewController = [[YKWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavigationController.view];
    [wrapViewController addChildViewController:wrapNavigationController];
    
    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !yk_tabBarRectValue) {
        yk_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && yk_tabBarRectValue) {
        self.tabBarController.tabBar.frame = yk_tabBarRectValue.CGRectValue;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (BOOL)canNotUseInteractivePopGestureRecognizer {
    return self.rootViewController.canNotUseInteractivePopGestureRecognizer;
}

-  (BOOL)hidesBottomBarWhenPushed {
    return self.rootViewController.hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return self.rootViewController.tabBarItem;
}

- (NSString *)title {
    return self.rootViewController.title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.rootViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.rootViewController;
}

- (UIViewController *)rootViewController {
    YKWrapNavigationController *wrapNavigationController = self.childViewControllers.firstObject;
    return wrapNavigationController.viewControllers.firstObject;
}

@end


#pragma mark - YKNavigationController
@interface YKNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation YKNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.yk_navigationController = self;
        self.viewControllers = @[[YKWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.yk_navigationController = self;
        self.viewControllers = @[[YKWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isRootViewController = (viewController == navigationController.viewControllers.firstObject);

    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = !isRootViewController;
    if (viewController.canNotUseInteractivePopGestureRecognizer) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark - UIGestureRecognizerDelegate
//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ![gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - getter
- (NSArray *)yk_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (YKWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}


@end
