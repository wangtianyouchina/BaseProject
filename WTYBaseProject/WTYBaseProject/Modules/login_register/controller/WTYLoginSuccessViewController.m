


//
//  WTYLoginSuccessViewController.m
//  WTYBaseProject
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 xiaomaguohe. All rights reserved.
//

#import "WTYLoginSuccessViewController.h"
#import "WTYCurveView.h"
#import "UIImage+GIF.h"
#import "MJRefresh.h"
#import "WTYRefreshHeader.h"
@interface WTYLoginSuccessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSArray *items;

@end

@implementation WTYLoginSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    label.textColor = [UIColor greenColor];
    label.text = @"登录成功";
    [self.view addSubview:label];
    
    [self configSubViews];
    
    NSMutableArray *arrar = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < 10; i ++) {
        NSString *string = [NSString stringWithFormat:@"%d",i];
        [arrar addObject:string];
    }
    self.items = [arrar copy];
   
}
-(void)configSubViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.header;
    WTYRefreshHeader *header = [WTYRefreshHeader headerWithRefreshingBlock:^{
        NSLog(@"---------- ");
        [self.tableView.header endRefreshing];
    }];
    self.tableView.header = header;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *celliD = @"sdfsdf";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:celliD];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celliD];
    }
    NSString *string = self.items[indexPath.row];
    cell.textLabel.text = string;
    return cell;
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
