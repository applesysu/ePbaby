//
//  Problem.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Problem.h"

@implementation Problem

@synthesize problem_id, problemDesc, correctAnswer;

-(id) initWithProblemDesc:(NSString *)desc theCorrectAnswer:(BOOL)correct theProblemID:(int)ppid
{
    self = [super init];
    
    if (self != nil)
    {
        self.problemDesc = desc;
        self.problem_id = ppid;
        self.correctAnswer = correct;
    }
    
    return self;
}

@end
