//
//  NoTitleViewController.m
//  NavigationControllerDemo
//
//  Created by wanyakun on 16/4/7.
//  Copyright © 2016年 wanyakun. All rights reserved.
//

#import "NoTitleViewController.h"
#import "NormalViewController.h"
#import "YKNavigationController.h"
#import "UIViewController+YKNavigation.h"

@interface NoTitleViewController ()

@end

@implementation NoTitleViewController

#pragma mark - life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleMemoryWarning {
    //IBOutlet属性和成员变量对象直接赋值为nil
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


#pragma mark - Delegate

#pragma mark - event response
- (IBAction)pushNormalViewController:(UIButton *)sender {
    NormalViewController *normalViewController = [[NormalViewController alloc] initWithNibName:@"NormalViewController" bundle:nil];
    [self.navigationController pushViewController:normalViewController animated:YES];
}

- (IBAction)pushHidenNavViewController:(UIButton *)sender {
    NoTitleViewController *noTitleViewController = [[NoTitleViewController alloc] initWithNibName:@"NoTitleViewController" bundle:nil];
    [self.navigationController pushViewController:noTitleViewController animated:YES];
    
}

- (IBAction)pushHidenNavCannotPopViewController:(UIButton *)sender {
    NoTitleViewController *noTitleViewController = [[NoTitleViewController alloc] initWithNibName:@"NoTitleViewController" bundle:nil];
    noTitleViewController.canNotUseInteractivePopGestureRecognizer = YES;
    [self.navigationController pushViewController:noTitleViewController animated:YES];
}

- (IBAction)popViewController:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - private method
- (void)hideKeyBoard {
    //隐藏键盘
}

#pragma mark - getter setter

@end
