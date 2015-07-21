//
//  EntityHelper.m
//  ALC
//
//  Created by 丁玉松 on 5/29/14.
//  Copyright (c) 2014 Ganpu. All rights reserved.
//

#import "EntityHelper.h"
#import <objc/runtime.h>
#import "NSString+DYSFormat.h"



@implementation EntityHelper
#pragma mark - Custom Method

+(id) transformDictionary:(NSDictionary *)dict withEntityName:(NSString*)entityName
{
    id  tableObj = [[NSClassFromString(entityName) alloc]init];
    
    [self dictionaryToEntity:dict entity:tableObj];
    
    return tableObj;
}

+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity
{
    if (dict && entity) {
        
        for (NSString *keyName in [dict allKeys]) {
            NSString *monifyString = [keyName UppercaseFirstLetter];
            //构建出属性的set方法
            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",monifyString];
            //capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
            SEL destMethodSelector = NSSelectorFromString(destMethodName);
            
            if ([entity respondsToSelector:destMethodSelector]) {
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                
                [entity performSelector:destMethodSelector withObject:[dict objectForKey:keyName]];
                
#pragma clang diagnostic pop
                
            }
            
        }//end for
        
    }//end if
}

//首字母转换为大写其余的不变

+ (NSDictionary *) entityToDictionary:(id)entity
{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
        //const char* attributeName = property_getAttributes(prop);
        //NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        //NSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        
#pragma clang diagnostic pop
        
        if(value ==nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
        //        NSLog(@"%@",value);
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    NSLog(@"%@", returnDic);
    
    return returnDic;
}

+(NSString *)folatMoney:(NSString *) money
{
    return [NSString stringWithFormat:@"%.2f",(long)[money integerValue]/100.0];
}

+(NSString *)folatWeight:(NSString *) weight
{
    return [NSString stringWithFormat:@"%.3f",(long)[weight integerValue]/1000.0];
}

+(NSAttributedString *)rateString:(NSString *)rateString andFont:(UIFont *) orginFont
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:rateString];
    NSRange range = NSMakeRange(0, 1);
    UIFont  *attrFont = [UIFont fontWithName:orginFont.fontName size:orginFont.pointSize + 3];
    
//    NSLog(@"%@\n%f",attrFont.fontName,attrFont.pointSize);
        
    [attrStr addAttribute:NSFontAttributeName value:attrFont range:range];
    return attrStr;
}



+(NSAttributedString *)rateString:(NSString *)rateString andFont:(UIFont *) orginFont  andAdjustSize:(CGFloat) adjust
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:rateString];
    NSRange range = NSMakeRange(0, 1);
//    UIFont  *attrFont = [UIFont fontWithName:orginFont.fontName size:orginFont.pointSize + adjust];
    
    UIFont  *attrFont = [UIFont fontWithName:orginFont.fontName size: adjust];

    //    NSLog(@"%@\n%f",attrFont.fontName,attrFont.pointSize);
    
    [attrStr addAttribute:NSFontAttributeName value:attrFont range:range];
    return attrStr;
}


@end
