
//
//  WTYRefreshHeader.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/7/11.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import "WTYRefreshHeader.h"
#import "SpokenPracticeGifView.h"
@interface WTYRefreshHeader()
{
    /** 动画View */
    __weak UIView *_lastUpdatedTimeView;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation WTYRefreshHeader
#pragma mark - 懒加载

- (UIView *)lastUpdatedTimeView
{
    if (!_lastUpdatedTimeView) {
        NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
        SpokenPracticeGifView *gifLaBa = [[SpokenPracticeGifView alloc] initWithFrame:self.viewForLastBaselineLayout.bounds filePath:gifPath];
        [gifLaBa startAni];
        
        [self addSubview:_lastUpdatedTimeView = gifLaBa];
    }
    return _lastUpdatedTimeView;
}


#pragma mark key的处理
- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey
{
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
}

#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.lastUpdatedTimeView.hidden) return;
    
    if (self.lastUpdatedTimeView.hidden) {
        // 状态
        self.lastUpdatedTimeView.frame = self.bounds;
    } else {
        self.lastUpdatedTimeView.frame = self.bounds;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 重新设置key（重新显示时间）
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
}
@end

