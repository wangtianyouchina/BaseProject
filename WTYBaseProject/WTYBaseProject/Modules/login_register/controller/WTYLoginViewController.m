//
//  WTYLoginViewController.m
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYLoginViewController.h"
#import <AFNetworking.h>
#import "WTYClient.h"
#import "WTYUserInfo.h"
#import "WTYLoginSuccessViewController.h"
#import "WTYCurveView.h"

#import "UIImage+GIF.h"
#import "SpokenPracticeGifView.h"
@interface WTYLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation WTYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%s -- %@",__FUNCTION__,NSStringFromCGRect(self.view.frame));
//    WTYCurveView *curveView = [[WTYCurveView alloc] initWithFrame:CGRectMake(0, 0, 400, 500)];
//    curveView.count = 200000;
//    curveView.tag = 1000;
//    [self.view addSubview:curveView];

//     NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
//    SpokenPracticeGifView *_gifLaBa = [[SpokenPracticeGifView alloc] initWithFrame:CGRectMake(10, 10, 300, 200) filePath:gifPath];
//    [self.view addSubview:_gifLaBa];
//    [_gifLaBa startAni];
//    
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 300, 200)];
////    [imageView setImage:[UIImage imageNamed:@"loading.gif"]];
//    [imageView setImage:[UIImage sd_animatedGIFNamed:@"loading.gif"]];
//    imageView.backgroundColor = [UIColor redColor];
////    [self.view addSubview:imageView];
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"%@",NSStringFromCGAffineTransform(self.view.transform));

}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    NSLog(@"%@",NSStringFromCGAffineTransform(self.view.transform));
    return YES;
}
- (IBAction)loginButton:(UIButton *)sender {
//    self.passwordTextField.frame = CGRectMake(0, 0, 100, 100);
    self.testView.frame = CGRectMake(0, 0, 100, 200);
    return;
    
    NSString *username = self.userNameTextfiled.text;
    NSString *password = self.passwordTextField.text;
    
    if (username.length == 0) {
        [self showHUDWithTitle:@"用户名不能为空!"];
        return;
    }
    
    if (password.length == 0) {
        [self showHUDWithTitle:@"密码不能为空"];
        return;
    }
    
    WTYClient *clinet = [WTYClient shareInstance];
    [clinet loginWithUsername:username password:password success:^(WTYUserInfo *userInfo) {
        
        [self showHUDWithTitle:@"登录成功!"];
        WTYLoginSuccessViewController *vc = [[WTYLoginSuccessViewController alloc] init];
        [self.navigationController pushViewController:vc
                                             animated:YES];
        NSLog(@"%@",userInfo.username);
        
    } failure:^(NSError *error) {
        [self showHUDWithTitle:@"登录失败!"];
        NSLog(@"%@",error);
        
    }];
}

- (IBAction)registerButtonAction:(UIButton *)sender {
    
    WTYUserInfo *userinfon = [[WTYUserInfo alloc] init];
    [userinfon show];
    
    //
    [userinfon hello];
    
}

#pragma mark - life cycle

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s -- %@",__FUNCTION__,NSStringFromCGRect(self.view.frame));

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s -- %@",__FUNCTION__,NSStringFromCGRect(self.view.frame));

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s -- %@",__FUNCTION__,NSStringFromCGRect(self.view.frame));

}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%s -- %@",__FUNCTION__,NSStringFromCGRect(self.view.frame));

}
- (void)viewWillLayoutSubviews  {
    [super viewWillLayoutSubviews];
    NSLog(@"%s -- %@",__FUNCTION__,NSStringFromCGRect(self.view.frame));

}
- (void)viewDidLayoutSubviews  {
    [super viewDidLayoutSubviews];
    NSLog(@"%s -- %@",__FUNCTION__,NSStringFromCGRect(self.view.frame));

}

*/

+(BOOL)resolveInstanceMethod:(SEL)sel {
   BOOL ret = [super resolveInstanceMethod:sel];
    NSLog(@"%d ---222 %@",ret,NSStringFromSelector(sel));
    return YES;
}
+(BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"333 %@",NSStringFromSelector(sel));
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector");
    
    NSString *selectorString = NSStringFromSelector(aSelector);
    
    // 将消息转发给_helper来处理
    id ret =  [super forwardingTargetForSelector:aSelector];
    NSLog(@"%@",ret);
    //    if([selectorString isEqualToString:@"hello"]) {
    //
    //        return [[WTYLoginModel alloc] init];
    //    }
    
    return ret;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];//[[NSMethodSignature alloc] init];
    NSLog(@"%@",sig);
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%@",anInvocation);
}

-(BOOL)shouldAutorotate {
    return YES;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
