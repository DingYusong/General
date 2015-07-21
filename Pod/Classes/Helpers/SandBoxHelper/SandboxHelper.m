//
//  SandboxHelper.m
//  Yiyuanshe
//
//  Created by GanPu on 11/14/13.
//  Copyright (c) 2013 丁玉松. All rights reserved.
//

#import "SandboxHelper.h"

@implementation SandboxHelper
+ (NSString *)homePath{
    return NSHomeDirectory();
}

+ (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
}


+ (BOOL)hasLive:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return NO;
}

+(BOOL)hasFile:(NSString *)filePath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

//如果由则替换 如果没有则新建(将数据对象sender压缩存储)
+(void)saveFileOnPath:(NSString *)filePath archiver:(id)sender
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];
    }
    [NSKeyedArchiver archiveRootObject:sender toFile:filePath] ;
}

+(id)readFileFromPath:(NSString *)filePath
{
    return  [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
}


+(void)saveFileInTmpWithFolder:(NSString *)folder andName:(NSString *)name archiver:(id)sender
{
    
    NSString *filePath = [self getTmpFilePathWithFolder:folder andName:name];
    
    [self saveFileOnPath:filePath archiver:sender];
}


+(id)readFileInTmpFromFolder:(NSString *)folder andName:(NSString *)name
{
    
    NSString *filePath = [self getTmpFilePathWithFolder:folder andName:name];
    return  [self readFileFromPath:filePath];

}


+(NSString *)getTmpFilePathWithFolder:(NSString *)folder andName:(NSString *)name
{
    
    NSString *filePath;
    if (folder != nil)
    {
        //创建文件夹：

        NSString *imageDir = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), folder];
        
        BOOL isDir = NO;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
        
        if ( !(isDir == YES && existed == YES) )
            
        {
            [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        filePath = [imageDir stringByAppendingPathComponent :name];
    }
    else
    {
        filePath = [NSTemporaryDirectory() stringByAppendingPathComponent: name];
    }

    return filePath;
}

+(NSString *)getFolderPathWithFolderName:(NSString *)folder
{
    NSString *imageDir = [NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), folder];
    
//    NSLog(@"%@",imageDir);
    
    BOOL isDir = NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) )
        
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return imageDir;
}

//获得TMP里面的图片缓存目录（所有的图片都存放在，imageCache 下面）
+(NSString *)getImageCacheFolderPath
{
    return [self getFolderPathWithFolderName:@"imageCache"];
}

// 清理TMP文件夹下folderName文件夹 的所有文件

+(void)clearTmpFolderWithFolderName:(NSString *)FolderName
{
    
    NSString *directory = [self getFolderPathWithFolderName:FolderName];
    
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:NULL];
    
    for (NSString *file in tmpDirectory)
    {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", directory, file] error:NULL];
    }

}



//清空缓存(主要是图片)
+ (void)clearTmpDirectory
{
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
    for (NSString *file in tmpDirectory) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
    }
}
//清空缓存(主要是数据)
+ (void)clearDocDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        NSLog(@"Path: %@", [paths objectAtIndex:0]);
        
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Remove all files in the documents directory
        BOOL deleted = [fileManager removeItemAtPath:[paths objectAtIndex:0] error:&error];
        
        if (deleted != YES || error != nil)
        {
            // Deal with the error...
        }
        else
            // Recreate the Documents directory
            [fileManager createDirectoryAtPath:[paths objectAtIndex:0] withIntermediateDirectories:NO attributes:nil error:&error];
        
    }

}


+(void)clearImageCache
{
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self getImageCacheFolderPath] error:NULL];
    
    for (NSString *file in tmpDirectory)
    {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", [self getImageCacheFolderPath], file] error:NULL];
    }
}


//获得文件夹的大小,返回的是MB
+(float)getSizeOfDirectory:(NSString *)directory
{
    
    NSFileManager *filemgr;
    NSArray *filelist;
    
//    int count;
    float cacheSize = 0;
    
    filemgr =[NSFileManager defaultManager];
    
    filelist = [filemgr contentsOfDirectoryAtPath:directory error:NULL];
    
//    count = [filelist count];
    
    for (NSString *url in filelist)
    {
        NSData *data = [filemgr contentsAtPath:[NSString stringWithFormat:@"%@/%@",directory,url]];
        cacheSize = cacheSize + ([data length]/1000);
    }
    
    NSLog(@"cacheSize: %f KB",cacheSize);
    cacheSize = (cacheSize/1024);
    NSLog(@"cacheSize: %f MB",cacheSize);
    
    return cacheSize;
}

+(void)saveInterfaceCacheWithMethodName:(NSString *)method andData:(NSDictionary *)data
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *interfaceFolder = [[[self class] docPath] stringByAppendingPathComponent:@"interface"];
    if (![fm fileExistsAtPath:interfaceFolder]) {
        [fm createDirectoryAtPath:interfaceFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *cachePath = [interfaceFolder stringByAppendingPathComponent:method];
    if (data != nil) {
        [data writeToFile:cachePath atomically:YES];
    }
}


+(NSDictionary *)readInterfaceCacheWithMethodName:(NSString *)method
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *interfaceFolder = [[[self class] docPath] stringByAppendingPathComponent:@"interface"];
    
//    if (![fm fileExistsAtPath:interfaceFolder]) {
//        [fm createDirectoryAtPath:interfaceFolder withIntermediateDirectories:YES attributes:nil error:nil];
//    }
    
    NSString *cachePath = [interfaceFolder stringByAppendingPathComponent:method];
    
    if ([fm fileExistsAtPath:cachePath])
    {
        NSDictionary *result = [NSDictionary dictionaryWithContentsOfFile:cachePath];
        return result;
    }
    return nil;
}

+(void)clearInterfaceCache{
    
//    NSString *directory = [self getFolderPathWithFolderName:FolderName];
//    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *interfaceFolder = [[[self class] docPath] stringByAppendingPathComponent:@"interface"];

    
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:interfaceFolder error:NULL];
    
    for (NSString *file in tmpDirectory)
    {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", interfaceFolder, file] error:NULL];
    }
    
}


@end
