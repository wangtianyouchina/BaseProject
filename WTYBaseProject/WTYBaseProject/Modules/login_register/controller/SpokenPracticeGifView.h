//
//  SpokenPracticeGifView.h
//  UniverseTOEFL
//
//  Created by fengfei on 16/5/20.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface SpokenPracticeGifView : UIView
{
    CGImageSourceRef gif;
    NSDictionary *gifProperties;
    size_t index;
    size_t count;
    NSTimer *timer;
}

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath;
- (id)initWithFrame:(CGRect)frame data:(NSData *)_data;

- (void)startAni;
- (void)stopAni;

@end
