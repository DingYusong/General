//
//  NSString+DYSFormat.h
//  ALC
//
//  Created by 丁玉松 on 8/14/14.
//  Copyright (c) 2014 Ganpu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DYSFormat)

//除去空格 制表符  tab置位符号,主要用于处理网络返回后的json字符串。
-(NSString *)removeWrapSpaceAndTab;

//首字母大写（支持set方法）
-(NSString *)UppercaseFirstLetter;

@end
