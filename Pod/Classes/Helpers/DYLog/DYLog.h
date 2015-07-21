//
//  DYLog.h
//  NSLogDemo
//
//  Created by 丁玉松 on 12/26/13.
//  Copyright (c) 2013  dys90@qq.com . All rights reserved.
//
/*
    在Debug模式下，能够打印输出，NSLog所在的类，方法，行号，和输出
    方便之处在于直接import到pch文件后，原来所有的输出模式都将改变，很方便的知道什么地方打印了什么东西
    欢迎邮件交流
 */


#import <Foundation/Foundation.h>

@interface DYLog : NSObject

#if DEBUG

#define DY_MethodName  [NSString stringWithUTF8String:__PRETTY_FUNCTION__]
#define DY_LineNum  [NSNumber numberWithInt:__LINE__]

#define NSLog( s, ... ) [DYLog logtext: \
[NSString stringWithFormat:@"\n\n方法：%@:\n行号：%@\n输出：%@\n\n",DY_MethodName,DY_LineNum,[NSString stringWithFormat:(s), ##__VA_ARGS__]]\
]

#else

# define NSLog(...) {}

#endif

+ (void)logtext:(NSString *)format, ...;

@end
