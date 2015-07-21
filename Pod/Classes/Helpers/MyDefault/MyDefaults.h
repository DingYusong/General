//
//  MyDefaults.h
//  Yiyuanshe
//
//  Created by DingYusong on 10/17/13.
//  Copyright (c) 2013 Ganpu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDefaults : NSObject

+(void)saveValue:(id) v forKey:(NSString *)key;
+(void)saveIntValue:(int) v forKey:(NSString *)key;
+(id)readKey:(NSString *)key;
+(int)readintKey:(NSString *)key;

+(void)removeKey:(NSString *)key;

//+(NSString *)getUserID;
//+(NSString *)getGuid;

@end
