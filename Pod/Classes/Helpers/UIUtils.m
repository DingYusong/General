//
//  UIUtils.m
//  WXTime
//
//  Created by wei.chen on 12-7-22.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联ios开发培训中心 All rights reserved.
//

#import "UIUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UIUtils

+ (NSString *)getDocumentsPath:(NSString *)fileName {
    
    //两种获取document路径的方式
//    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [paths objectAtIndex:0];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    
    return path;
}

+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	return str;
}

+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}

//Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    return text;
}

+ (UILabel *)createNavigationBarTitle:(NSString *)title {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:17.0];
//    label.font = [UIFont fontWithName:@"Arial" size:17];
    label.font = [UIFont boldSystemFontOfSize:19.0];
    label.text = title;
//    label.shadowColor = [UIColor colorWithHue:0 saturation:0 brightness:0.46 alpha:1.0];
//    label.shadowOffset = CGSizeMake(0, 1);
    
    return label ;
}

+ (UIView *)createGTitleView:(NSString *)title {
    
    // Init views with rects with height and y pos
//    CGFloat titleHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat titleHeight = 44;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:19.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // Set the width of the views according to the text size
    
    CGFloat desiredWidth = [title boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] applicationFrame].size.width, titleLabel.frame.size.height) options:0 attributes:[NSDictionary dictionaryWithObjectsAndKeys:titleLabel.font, NSFontAttributeName, nil] context:nil].size.width;
    CGRect frame;
    
    frame = titleLabel.frame;
    frame.size.height = titleHeight;
    frame.size.width = desiredWidth;
    titleLabel.frame = frame;
    
    frame = titleView.frame;
    frame.size.height = titleHeight;
    frame.size.width = desiredWidth;
    titleView.frame = frame;
    
    // Use autoresizing to restrict the bounds to the area that the titleview allows
    titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    titleView.autoresizesSubviews = YES;
    titleLabel.autoresizingMask = titleView.autoresizingMask;
    
    // Set the text
    titleLabel.text = title;
    
    // Add as the nav bar's titleview
    [titleView addSubview:titleLabel];
    return titleView;
}


+ (UIView *)createNavigationBarTitle:(NSString *)title subTitle:(NSString *)subTitle {
    
    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.autoresizesSubviews = YES;
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    titleLabel.text = title;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UILabel* subLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 12)];
    subLabel.backgroundColor = [UIColor clearColor];
    subLabel.textColor = [UIColor whiteColor];
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.font = [UIFont fontWithName:@"Arial" size:11];
    subLabel.text = subTitle;
    subLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [titleView addSubview:titleLabel];
    [titleView addSubview:subLabel];
    
    
    return titleView;
}

@end
