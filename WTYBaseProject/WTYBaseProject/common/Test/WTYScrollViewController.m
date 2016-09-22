//
//  WTYScrollViewController.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/8/8.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import "WTYScrollViewController.h"
#import "WTYTestScrollView.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height  //屏幕的高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width    //屏幕的宽度
@interface WTYScrollViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet UIView *headView;//100
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *items;
@property (weak, nonatomic) IBOutlet WTYTestScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation WTYScrollViewController
{
    BOOL hasOrientation;
}
- (IBAction)buttonAction:(id)sender {
    
    //强制旋转
    if (!hasOrientation) {//18910739865
        self.view.layer.anchorPoint = CGPointMake(0.5, 1);
        
//        self.view.layer.position = CGPointMake(375 , 300);
//        self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
//        self.view.bounds = CGRectMake(0, 0, 100, 200);
        [UIView animateWithDuration:0.5 animations:^{
            hasOrientation = YES;
            
//            self.view.bounds = CGRectMake(0, 0, kScreenHeight, kScreenWidth);
        }];
    } else {
        hasOrientation = NO;
//        [UIView animateWithDuration:0.5 animations:^{
//            self.view.transform = CGAffineTransformInvert(CGAffineTransformMakeRotation(0));
//            self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//        }];
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *items = @[
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       @"wang",
                       ];
    self.items = items;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.scrollView.delegate = self;
    [self.tableView reloadData];
}




#pragma mark - UITableVIewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"UTLPracticeBriefTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"indexpath - %@",indexPath];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *array = [[_items objectAtIndex:section] objectForKey:@"questions"];
    return _items.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        self.scrollView.scrollEnabled = NO;
        
    }
    else {
        
        if (scrollView.contentOffset.y  == -50) {
            self.tableView.scrollEnabled = NO;

        }
        else {
            self.tableView.scrollEnabled = YES;
        }
        
        
    }
    
    
}
@end
