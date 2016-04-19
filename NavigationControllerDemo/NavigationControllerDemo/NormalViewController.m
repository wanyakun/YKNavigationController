//
//  NormalViewController.m
//  NavigationControllerDemo
//
//  Created by wanyakun on 16/4/7.
//  Copyright © 2016年 wanyakun. All rights reserved.
//

#import "NormalViewController.h"
#import "NoTitleViewController.h"
#import "YKNavigationController.h"
#import "UIViewController+YKNavigation.h"

@interface NormalViewController ()

@end

@implementation NormalViewController

#pragma mark - life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"正常ViewController";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self setUpLeftBarButtonItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - getter setter

@end
