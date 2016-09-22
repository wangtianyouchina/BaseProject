//
//  WTYGCDTest.m
//  WTYBaseProject
//
//  Created by wang.tianyou on 16/6/12.
//  Copyright © 2016年 xiaomaguohe. All rights reserved.
//

#import "WTYGCDTest.h"

@interface WTYGCDTest ()
@property(nonatomic,strong) NSMutableArray *array;
@end

@implementation WTYGCDTest

-(void)start {
    //测试
//    [self dispatch_syncTest];
    //测试
//    [self dispatch_queue];
    
//    [self dispatch_groupTest];
    
//    [self blockOperationTest];
    self.array = [NSMutableArray array];
    
//    [self threadLock1];
    [self banrr_disPatch_syn_test];
}

-(void)threadLock1 {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0 ; i < 100000; i ++) {
            @synchronized (self) {
            [self.array addObject:[NSNumber numberWithInt:i]];
            dispatch_semaphore_signal(semaphore);
            }
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 200000; i < 300000; i ++) {
            @synchronized (self) {
                [self.array addObject:[NSNumber numberWithInt:i]];
            }
        }
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"self.array.count = %d",self.array.count);
        NSLog(@"%@",self.array);
    });
}

-(void)threadLock2 {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0 ; i < 100000; i ++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [self.array addObject:[NSNumber numberWithInt:i]];
            dispatch_semaphore_signal(semaphore);
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 200000; i < 300000; i ++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [self.array addObject:[NSNumber numberWithInt:i]];
            dispatch_semaphore_signal(semaphore);
        }
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"self.array.count = %d",self.array.count);
        NSLog(@"%@",self.array);
    });
}

-(void)threadLock3 {
    
    
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0 ; i < 100000; i ++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [self.array addObject:[NSNumber numberWithInt:i]];
            dispatch_semaphore_signal(semaphore);
            
            //            }
        }
    });
    
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 200000; i < 300000; i ++) {
            //            @synchronized (self) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [self.array addObject:[NSNumber numberWithInt:i]];
            dispatch_semaphore_signal(semaphore);
        }
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"self.array.count = %d",self.array.count);
        NSLog(@"%@",self.array);
    });
}

-(void)banrr_disPatch_test {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(concurrentQueue, ^(){

        NSLog(@"dispatch-1 - %@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-2- %@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-3- %@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-4- %@",[NSThread currentThread]);
    });
//        dispatch_barrier_async(concurrentQueue, ^(){
//            NSLog(@"dispatch-barrier");
//        });
    dispatch_async(concurrentQueue, ^{
              NSLog(@"dispatch-barrier- %@",[NSThread currentThread]);

    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-5- %@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-6- %@",[NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-7- %@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-8- %@",[NSThread currentThread]);
    });

}

-(void)banrr_disPatch_syn_test {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(concurrentQueue, ^(){
        
        NSLog(@"dispatch-1 - %@",[NSThread currentThread]);
    });
    dispatch_sync(concurrentQueue, ^(){
        NSLog(@"dispatch-2- %@",[NSThread currentThread]);
    });
    dispatch_sync(concurrentQueue, ^(){
        NSLog(@"dispatch-3- %@",[NSThread currentThread]);
    });
    dispatch_async(dispatch_get_main_queue(), ^(){
        NSLog(@"dispatch-4- %@",[NSThread currentThread]);
    });
    //        dispatch_barrier_async(concurrentQueue, ^(){
    //            NSLog(@"dispatch-barrier");
    //        });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"dispatch-barrier- %@",[NSThread currentThread]);
        
    });
    dispatch_sync(concurrentQueue, ^(){
        NSLog(@"dispatch-5- %@",[NSThread currentThread]);
    });
    dispatch_sync(concurrentQueue, ^(){
        NSLog(@"dispatch-6- %@",[NSThread currentThread]);
    });
    
    dispatch_sync(concurrentQueue, ^(){
        NSLog(@"dispatch-7- %@",[NSThread currentThread]);
    });
    
    dispatch_sync(concurrentQueue, ^(){
        NSLog(@"dispatch-8- %@",[NSThread currentThread]);
    });
    
}



-(void)creatQueue {
    
    //主对列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    // 串行对列
    dispatch_queue_t queue = dispatch_queue_create("tk.boure.testQueue", NULL);
    dispatch_queue_t queue1 = dispatch_queue_create("tk.boure1.testQueue1", DISPATCH_QUEUE_SERIAL);
    //并行对列
    dispatch_queue_t queue2 = dispatch_queue_create("tk.boure2.testQueue2", DISPATCH_QUEUE_CONCURRENT);
    
    // 全局并行对列
    dispatch_queue_t globlQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

-(void)dispatch_syncTest {
    NSLog(@"之前 -- %@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"sync -- %@",@"sdf");
    });
    NSLog(@"之后 -- %@",[NSThread currentThread]);
}
-(void)dispatch_queue {
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"之前 - %@", [NSThread currentThread]);
    
    dispatch_async(queue, ^{
        NSLog(@"sync之前 - %@",[NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"sync - %@", [NSThread currentThread]);
        });
        NSLog(@"sync之后 - %@", [NSThread currentThread]);
    });

    NSLog(@"之后 - %@",[NSThread currentThread]);
}

-(void)dispatch_groupTest {
    
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //3.多次使用队列组的方法执行任务, 只有异步方法
    //3.1.执行3次循环
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"group-01 - %@", [NSThread currentThread]);
        }
    });
    
    //3.2.主队列执行8次循环
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 8; i++) {
            NSLog(@"group-02 - %@", [NSThread currentThread]);
        }
    });
    
    //3.3.执行5次循环
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"group-03 - %@", [NSThread currentThread]);
        }
    });
    
    //4.都完成后会自动通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成 - %@", [NSThread currentThread]);
    });
    
    
}

-(void)blockOperationTest {
    //1.任务一：下载图片
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片 - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    
    //2.任务二：打水印
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"打水印   - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    
    //3.任务三：上传图片
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"上传图片 - %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    
    //4.设置依赖
    [operation2 addDependency:operation1];      //任务二依赖任务一
    [operation3 addDependency:operation2];      //任务三依赖任务二
    
    //5.创建队列并加入任务
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operation3, operation2, operation1] waitUntilFinished:NO];
}

// 回到主线程的方法
-(void)comeBackMainQueue {
    
    // NSThread
    [self performSelectorOnMainThread:@selector(mainQueueAction) withObject:nil waitUntilDone:NO];
    //GCD
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueAction];
    });
    //NSOperationQueue
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self mainQueueAction];
    }];
}

-(void)mainQueueAction {
    
}

/**
 *  延迟执行
 */
-(void)afterRunTest {
    //perform
    [self performSelector:@selector(afterAction) withObject:nil afterDelay:3];
    //GCD
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self afterAction];
    });
    //timer
    [NSTimer timerWithTimeInterval:3 target:self selector:@selector(afterAction) userInfo:nil repeats:NO];
}
-(void)afterAction {
    
}
@end
