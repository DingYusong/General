//
//  MyDefaults.m
//  Yiyuanshe
//
//  Created by DingYusong on 10/17/13.
//  Copyright (c) 2013 Ganpu. All rights reserved.
//

#import "MyDefaults.h"

@implementation MyDefaults
+(void)saveValue:(id) v forKey:(NSString *)key
{
    
    
    [[NSUserDefaults standardUserDefaults]setObject:v forKey:key];
    //同步
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(void)saveIntValue:(int) v forKey:(NSString *)key
{
    [self saveValue:[NSNumber numberWithInt:v] forKey:key];
}
+(id)readKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}
+(int)readintKey:(NSString *)key
{
    NSNumber *n = [self readKey:key];
    return n.intValue;
}

+(void)removeKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


@end
