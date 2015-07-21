//
//  DYLog.m
//  NSLogDemo
//
//  Created by 丁玉松 on 12/26/13.
//  Copyright (c) 2013 dys90@qq.com. All rights reserved.
//

#import "DYLog.h"

@implementation DYLog

+(void)logtext:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    [[self sharedInstance]logtext:format,args];
    va_end(args);
}

-(void)logtext:(NSString *)format, ...
{
    NSString* text = format?format:@"";
    
    if (text.length>0)
    {
        va_list args;
        va_start(args, format);
#ifdef DEBUG
        NSLogv(text, args);
#endif
        va_end(args);
    }
}

//单例
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


@end
