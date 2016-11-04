//
//  MMCrashSafe.m
//  CrashDemo
//
//  Created by 马扬 on 2016/11/4.
//  Copyright © 2016年 马扬. All rights reserved.
//

#import "MMCrashSafe.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>



/** 系统信号截获处理方法 */
void signalHandler(int signal);

/** 异常截获处理方法 */
void exceptionHandler(NSException *exception);

const int32_t _uncaughtExceptionMaximum = 10;


/** 系统信号截获处理方法 */
void signalHandler(int signal){
    volatile int32_t _uncaughtExceptionCount = 0;
    int32_t exceptionCount = OSAtomicIncrement32(&_uncaughtExceptionCount);
    if (exceptionCount > _uncaughtExceptionMaximum){
        return;
    }
    /** 获取崩溃信息 */
    NSMutableDictionary *userInfo =
    [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:@"UncaughtExceptionHandlerSignalKey"];
    
    NSArray * callStack = [MMCrashSafe backtrace];
    [userInfo  setObject:callStack  forKey:@"SingalExceptionHandlerAddressesKey"];
    /** 做一些处理 */
}

/** 异常截获处理方法 */
void exceptionHandler(NSException *exception){
    
    volatile int32_t _uncaughtExceptionCount = 0;
    int32_t exceptionCount = OSAtomicIncrement32(&_uncaughtExceptionCount);
    if (exceptionCount > _uncaughtExceptionMaximum){
        return;
    }
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    NSArray *models =CFBridgingRelease(CFRunLoopCopyAllModes(runLoop));
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"严重警告" message:@"程序已经崩溃" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertView show];
    while (1) {
        for (NSString *mode in models) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
}




@implementation MMCrashSafe

//获取调用堆栈
+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack,frames);
    
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i=0;i<frames;i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}

+ (void)installExceptionHandler
{
    NSSetUncaughtExceptionHandler(&exceptionHandler);
    signal(SIGHUP, signalHandler);
    signal(SIGINT, signalHandler);
    signal(SIGQUIT, signalHandler);
    signal(SIGABRT, signalHandler);
    signal(SIGILL, signalHandler);
    signal(SIGSEGV, signalHandler);
    signal(SIGFPE, signalHandler);
    signal(SIGBUS, signalHandler);
    signal(SIGPIPE, signalHandler);
}
@end
