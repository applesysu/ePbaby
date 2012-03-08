//
//  FileOperation.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FileOperation.h"

@implementation FileOperation

+(NSString *) getAbsolutePathOfFile:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    return  filePath;
}

+(BOOL) createSpecifiedFile:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:[FileOperation getAbsolutePathOfFile:fileName]])
    {
        [fileManager createFileAtPath:[FileOperation getAbsolutePathOfFile:fileName] contents:nil attributes:nil];
        return YES;
    }
    else
    {
        return NO;
    }
    
}

@end
