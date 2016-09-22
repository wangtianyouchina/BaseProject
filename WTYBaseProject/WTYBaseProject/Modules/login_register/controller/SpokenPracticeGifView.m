//
//  SpokenPracticeGifView.m
//  UniverseTOEFL
//
//  Created by fengfei on 16/5/20.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import "SpokenPracticeGifView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SpokenPracticeGifView

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath
{
    self = [super initWithFrame:frame];
    if (self) {
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount] forKey:(NSString *)kCGImagePropertyGIFDictionary];
        
        gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:_filePath], (CFDictionaryRef)gifProperties);
        count = CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(play) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [self pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame data:(NSData *)_data
{
    self = [super initWithFrame:frame];
    if (self) {
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount] forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gif = CGImageSourceCreateWithData((CFDataRef)_data, (CFDictionaryRef)gifProperties);
        count = CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.12 target:self selector:@selector(play) userInfo:nil repeats:YES];
        //[timer fire];
    }
    return self;
}

- (void)startAni
{
    [self resumeTimer];
}

- (void)stopAni
{
    [self pauseTimer];
}

-(void)pauseTimer
{
    if (![timer isValid]) {
        return ;
    }
    
    [timer setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
    
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, 3, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}


- (void)resumeTimer
{
    if (![timer isValid]) {
        return ;
    }
    
    //[self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [timer setFireDate:[NSDate date]];
}

- (void)play
{
    index ++;
    index = index%count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}

- (void)removeFromSuperview
{
    NSLog(@"removeFromSuperview");
    [timer invalidate];
    timer = nil;
    [super removeFromSuperview];
}

- (void)dealloc
{
    NSLog(@"dealloc");
    CFRelease(gif);
}
@end
