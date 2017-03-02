//
//  SSLFileTool.m
//  Tool
//
//  Created by licy on 14/11/20.
//  Copyright (c) 2014年 licy. All rights reserved.
//

#import "SSLFileTool.h"

@implementation SSLFileTool

+ (BOOL) isExistsAtFile:(NSString *)absPath {
    return [[NSFileManager defaultManager] fileExistsAtPath:absPath];
}

+ (BOOL) isFileTimeout:(NSString *)absUrlPath withTimeout:(NSTimeInterval)timeout {
    // 可以取得文件的属性。比如文件大小  文件上次更新时间。文件创建时间 文件属于谁的
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:absUrlPath error:nil];
    NSLog(@"dict is %@", dict);
    //NSDate * myDate = [myDict objectForKey:@"NSFileModificationDate"];
    
    NSDate *modifyTime = [dict objectForKey:NSFileModificationDate];
    NSTimeInterval modifyTimeSeconds = [modifyTime timeIntervalSinceReferenceDate];
    // 取得modifyTime到计算机元年的秒数
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    if (now - modifyTimeSeconds > timeout) {
        return YES;
    }
    // now - modifyTime > timeout
    //NSLog(@"obj is %@ class is %@", obj, [obj class]);
    //obj is 2013-08-06 04:05:36 +0000 class is __NSDate
    /*
     dict is {
     NSFileCreationDate = "2013-08-06 04:04:59 +0000";
     NSFileExtensionHidden = 0;
     NSFileGroupOwnerAccountID = 20;
     NSFileGroupOwnerAccountName = staff;
     NSFileModificationDate = "2013-08-06 04:04:59 +0000";
     NSFileOwnerAccountID = 503;
     NSFileOwnerAccountName = yang;
     NSFilePosixPermissions = 493;
     NSFileReferenceCount = 3;
     NSFileSize = 102;
     NSFileSystemFileNumber = 16134840;
     NSFileSystemNumber = 16777218;
     NSFileType = NSFileTypeDirectory;
     }
     
     */
    //NSFileModificationDate
    return NO;
}


+ (void) createDirectoryAtPath:(NSString *)absPath {
    if ([[NSFileManager defaultManager] fileExistsAtPath:absPath])
        return;
    
    [[NSFileManager defaultManager] createDirectoryAtPath:absPath withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (long long) fileSizeAtPath:(NSString *)filePath {
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0;
}

+ (long long) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [[self class] fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize;
}

+ (BOOL) removeAtPath:(NSString *)absPath {
    
    NSError *error;
    
    if ([[self class] isExistsAtFile:absPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:absPath error:&error];
    }
    
    if (error) {
        return NO;
    }
    return YES;
}

#pragma mark ------------------沙盒目录------------------
// 取主目录
+ (NSString *)homePath {
    return NSHomeDirectory();
}   

//文档目录
+ (NSString *)documentPathWithPathName:(NSString *)pathName {
    //    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = documents[0];
    NSString *paths = [docDir stringByAppendingPathComponent:pathName];
    return paths;
}

//缓存目录
+ (NSString *)cachePathWithPathName:(NSString *)pathName {
    NSArray *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = caches[0];
    NSString *paths = [cacheDir stringByAppendingPathComponent:pathName];
    return paths;
}

//临时目录
+ (NSString *)tempPathWithPathName:(NSString *)pathName {
    NSString *tmpDir = NSTemporaryDirectory();
    NSString *paths = [tmpDir stringByAppendingPathComponent:pathName];
    return paths;
}

#pragma mark ------------------工程目录------------------
+ (NSString *)bundlePathWithName:(NSString *)name type:(NSString *)type {
    return [[NSBundle mainBundle] pathForResource:name ofType:type];
}   

#pragma mark ------------------归档／解档------------------
+ (void)archive:(id)object toFile:(NSString *)path {
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}
+ (void)unarchive:(id)object withFile:(NSString *)path {
    [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end
