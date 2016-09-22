//
//  WTYRegisterViewController.m
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYRegisterViewController.h"
#import "WTYUserInfo.h"
#import "WTYClient.h"
#import "WTYLoginModel.h"
@interface WTYRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTextField;

@end

@implementation WTYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)registerButtonAction:(UIButton *)sender {
    
    NSString *username = self.usernameTextField.text;//@"tian";
    NSString *password = self.passwordTextField.text;//@"123";
    
    if (username.length == 0) {
        [self showHUDWithTitle:@"用户名不能为空!"];
        return;
    }
    
    if (password.length == 0) {
        [self showHUDWithTitle:@"密码不能为空"];
        return;
    }
    
    WTYClient *clinet = [WTYClient shareInstance];
    [clinet registerUserWithUsername:username password:password success:^(WTYUserInfo *userInfo) {
    
        [self showHUDWithTitle:@"注册成功!"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"%@",userInfo.username);
        
    } failure:^(NSError *error) {
        [self showHUDWithTitle:@"注册失败!"];
        NSLog(@"%@",error);
        
    }];
}

@end
