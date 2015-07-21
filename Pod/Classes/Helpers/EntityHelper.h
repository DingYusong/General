//
//  EntityHelper.h
//  ALC
//
//  Created by 丁玉松 on 5/29/14.
//  Copyright (c) 2014 Ganpu. All rights reserved.
//

//  使用前提条件是：字典的Key和实体对象属性的单词是一样的，大小可以忽略。
//  capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）,切记自定义实体最多只能首字母大写，其余的字母不能大写

// 关于可能导致内存泄漏的问题参考 http://blog.csdn.net/rbyyyblog/article/details/9467975

#import <Foundation/Foundation.h>

@interface EntityHelper : NSObject

//字典对象转为实体对象
+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity;

//实体对象转为字典对象
+ (NSDictionary *) entityToDictionary:(id)entity;

//字典转为实体对象，实体对象名称。
+(id) transformDictionary:(NSDictionary *)dict withEntityName:(NSString*)entityName;


+(NSString *)folatMoney:(NSString *) money;
+(NSString *)folatWeight:(NSString *) weight;

+(NSAttributedString *)rateString:(NSString *)rateString andFont:(UIFont *) orginFont;
+(NSAttributedString *)rateString:(NSString *)rateString andFont:(UIFont *) orginFont  andAdjustSize:(CGFloat) adjust;


@end
