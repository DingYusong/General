//
//  SandboxHelper.h
//  Yiyuanshe
//
//  Created by GanPu on 11/14/13.
//  Copyright (c) 2013 丁玉松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SandboxHelper : NSObject
+ (NSString *)homePath;         // 程序主目录，可见子目录(3个):Documents、Library、tmp
+ (NSString *)appPath;          // 程序目录，不能存任何东西
+ (NSString *)docPath;          // 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
+ (NSString *)libPrefPath;      // 配置目录，配置文件存这里
+ (NSString *)libCachePath;     // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;          // 临时缓存目录，APP退出后，系统可能会删除这里的内容
+ (BOOL)hasLive:(NSString *)path; //判断目录是否存在，不存在则创建

//检测是否存在文件
+(BOOL)hasFile:(NSString *)filePath;
//如果由则替换 如果没有则新建(将数据对象sender压缩存储)
+(void)saveFileOnPath:(NSString *)filePath archiver:(id)sender;
//读取文件
+(id)readFileFromPath:(NSString *)filePath;


//保存文件到TMP文件加下面
+(void)saveFileInTmpWithFolder:(NSString *)folder andName:(NSString *)name archiver:(id)sender;

+(id)readFileInTmpFromFolder:(NSString *)folder andName:(NSString *)name;


+(void)clearTmpFolderWithFolderName:(NSString *)FolderName;


+(NSString *)getImageCacheFolderPath;


//清空图片缓存
+ (void)clearImageCache;


//返回的是文件夹的大小
+(float)getSizeOfDirectory:(NSString *)directory;


//获得TMP文件夹下面，name文件的路径
+(NSString *)getTmpFilePathWithFolder:(NSString *)folder andName:(NSString *)name;
+(NSString *)getFolderPathWithFolderName:(NSString *)folder;


//接口缓存
+(NSDictionary *)readInterfaceCacheWithMethodName:(NSString *)method;
+(void)saveInterfaceCacheWithMethodName:(NSString *)method andData:(NSDictionary *)data;
+(void)clearInterfaceCache;

//+ (void)clearTmpDirectory;
//+ (void)clearDocDirectory;

@end
