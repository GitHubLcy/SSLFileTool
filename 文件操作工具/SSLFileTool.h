//
//  SSLFileTool.h
//  Tool
//
//  Created by licy on 14/11/20.
//  Copyright (c) 2014年 licy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSLFileTool : NSObject

//------------------基本操作------------------
// 判断文件是否存在
+ (BOOL) isExistsAtFile:(NSString *)absPath;
//创建目录
+ (void) createDirectoryAtPath:(NSString *)absPath;
// 删除文件
+ (BOOL) removeAtPath:(NSString *)absPath;
// 判断文件absUrlPath上次更新时间到现在当前时间是否超过了timeout
+ (BOOL) isFileTimeout:(NSString *)absUrlPath withTimeout:(NSTimeInterval)timeout;
// 读取文件大小
+ (long long)fileSizeAtPath:(NSString *)absPath;
//整个目录文件大小
+ (long long) folderSizeAtPath:(NSString*) folderPath;

//------------------沙盒目录------------------
//沙盒主目录
+ (NSString *)homePath;
//沙盒document目录
+ (NSString *)documentPathWithPathName:(NSString *)pathName;
//沙盒cache目录
+ (NSString *)cachePathWithPathName:(NSString *)pathName;
//沙盒temp目录
+ (NSString *)tempPathWithPathName:(NSString *)pathName;

//------------------工程目录------------------
+ (NSString *)bundlePathWithName:(NSString *)name type:(NSString *)type;

//------------------归档／解档------------------
+ (void)archive:(id)object toFile:(NSString *)path;
+ (void)unarchive:(id)object withFile:(NSString *)path;

@end









