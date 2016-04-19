//
//  RootViewController.m
//  NavigationControllerDemo
//
//  Created by wanyakun on 16/4/7.
//  Copyright © 2016年 wanyakun. All rights reserved.
//

#import "RootViewController.h"
#import "NormalViewController.h"
#import "NoTitleViewController.h"
#import "YKNavigationController.h"

@interface RootViewController ()

@end

@implementation RootViewController

#pragma mark - life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"自定义NavigationControllerDemo";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
#pragma mark - private method

#pragma mark - getter setter

@end
