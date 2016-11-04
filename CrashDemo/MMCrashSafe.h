//
//  MMCrashSafe.h
//  CrashDemo
//
//  Created by 马扬 on 2016/11/4.
//  Copyright © 2016年 马扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MMCrashSafe : NSObject

/** 
 *获取调用堆栈
 */
+ (NSArray *)backtrace;
/** 注册崩溃拦截 */
+ (void)installExceptionHandler;



@end
