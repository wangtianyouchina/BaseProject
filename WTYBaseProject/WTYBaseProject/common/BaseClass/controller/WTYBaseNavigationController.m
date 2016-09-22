//
//  WTYBaseNavigationController.m
//  WTYBaseProject
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYBaseNavigationController.h"

@interface WTYBaseNavigationController ()

@end

@implementation WTYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.visibleViewController.supportedInterfaceOrientations;
}

-(BOOL)shouldAutorotate {
    
    return self.visibleViewController.supportedInterfaceOrientations;
}
@end
