//
//  WTYBaseViewController.m
//  WTYBaseProject
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYBaseViewController.h"
#import <UIView+Toast.h>
#import "ZToastView.h"
@interface WTYBaseViewController ()

@end

@implementation WTYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark - Actions

- (void)backAction:(id)sender
{
    UIViewController *viewcontroller = [self.navigationController popViewControllerAnimated:YES];
    if (viewcontroller == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (void)showLoadingHUD
{
    [self showLoadingHUDWithLabel:@"正在加载..."];
}

- (void)showLoadingHUDWithLabel:(NSString *)label
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    
    _HUD.delegate = self;
    _HUD.labelText = label;
    
    [_HUD show:YES];
}

- (void)hideHUD
{
    [_HUD hide:YES];
}

- (void)makeToast:(NSString *)message
{
    [self makeToast:message duration:2.0f];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration
{
    ZToastView *toastView = [[ZToastView alloc] initWithFrame:CGRectMake(0, 0, 248, 80)];
    [toastView setMessage:message];
    [toastView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
    
    [self.view showToast:toastView
                duration:duration
                position:CSToastPositionCenter];
}

- (void)showErrorMessage:(NSError *)error
{
    NSString *errorMessage = [NSString stringWithFormat:@"错误码：%ld\n%@", (long)error.code, [error localizedDescription]];
    
    [self makeToast:errorMessage duration:2.0f];
}


-(void)showHUDWithTitle:(NSString *)title {
    
   MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = title;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}
@end
