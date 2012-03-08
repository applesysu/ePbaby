//
//  Problem.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Problem : NSObject
{
    NSString *problemDesc;
    BOOL correctAnswer;
    int problem_id;
}

@property (nonatomic, retain) NSString *problemDesc;
@property (nonatomic, readwrite) BOOL correctAnswer;
@property (nonatomic, readwrite) int problem_id;

-(id) initWithProblemDesc:(NSString *)desc theCorrectAnswer:(BOOL)correct theProblemID:(int)pid;
@end
