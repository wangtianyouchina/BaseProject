//
//  WTYBaseViewController.h
//  WTYBaseProject
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import "WTYClient.h"
#import "Constant.h"
@interface WTYBaseViewController : UIViewController
{
@private
    MBProgressHUD *_HUD;
    UIView *_noContentView;
    UIImageView *_noContentImageView;
    UILabel *_noContentLabel;
    UIView *_loadingView;
    UILabel *_loadingLabel;
    UIActivityIndicatorView *_loadingActivityIndicatorView;
@protected
    WTYClient *_kwdClient;

}
@property (nonatomic, copy) NSString *noContentString;
@property (nonatomic, copy) NSString *loadingString;

-(void)showHUDWithTitle:(NSString *)title;
- (void)backAction:(id)sender;

- (void)setNavigationBarLeftTitle:(NSString *)title target:(id)target action:(SEL)action;
- (void)setNavigationBarCenterTitle:(NSString *)title;
- (void)setNavigationBarRightTitle:(NSString *)title target:(id)target action:(SEL)action;
- (UIButton *)setNavigationBarLeftImage:(UIImage *)image target:(id)target action:(SEL)action;
- (void)setNavigationBarLeftImage:(UIImage *)image target:(id)target action:(SEL)action title2:(NSString *)title2 target2:(id)target2 action2:(SEL)action2;
- (void)hideNavigationBar;
- (void)showNavigationBar;
- (void)showLoadingHUD;
- (void)showLoadingHUDWithLabel:(NSString *)label;
- (void)hideHUD;
- (void)makeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration;
- (void)showErrorMessage:(NSError *)error;
- (void)showNoContentView;
- (void)hideNoContentView;
- (void)showLoadingView;
- (void)hideLoadingView;

- (CGFloat)subviewTopY;

@end
