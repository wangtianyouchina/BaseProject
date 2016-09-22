//
//  WTYBaseTabBarController.m
//  WTYBaseProject
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYBaseTabBarController.h"

@interface WTYBaseTabBarController ()

@end

@implementation WTYBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.selectedViewController) {
        return self.selectedViewController.supportedInterfaceOrientations;
    }
    return [super supportedInterfaceOrientations];
}

-(BOOL)shouldAutorotate {
    if (self.selectedViewController) {
        return self.selectedViewController.shouldAutorotate;
    }
    return [super shouldAutorotate];
}

@end
