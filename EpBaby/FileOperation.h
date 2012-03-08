//
//  FileOperation.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOperation : NSObject 

+(NSString *) getAbsolutePathOfFile:(NSString *)fileName;
+(BOOL) createSpecifiedFile:(NSString *)fileName;

@end
