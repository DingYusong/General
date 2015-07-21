//
//  NSString+DYSFormat.m
//  ALC
//
//  Created by 丁玉松 on 8/14/14.
//  Copyright (c) 2014 Ganpu. All rights reserved.
//

#import "NSString+DYSFormat.h"

@implementation NSString (DYSFormat)

-(NSString *)removeWrapSpaceAndTab
{
    NSString *MonifyString = self;
    MonifyString =  [MonifyString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    MonifyString =  [MonifyString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    MonifyString =  [MonifyString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    MonifyString =  [MonifyString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    return MonifyString;
    //切记self 是不能的！！！和外面的不一样
}

-(NSString *)UppercaseFirstLetter
{
    return [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[self substringWithRange:NSMakeRange(0, 1)]uppercaseString]];
}

@end
