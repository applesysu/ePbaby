//
//  TestScene.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Baby.h"
#import "Problem.h"

@interface TestScene : CCScene {
    
}

@end

@interface TestLayer : CCLayer {
    Baby *baby;
    CCSprite *babyImage;
    CCLabelTTF *problemDesc;
    BOOL curAnswer;
    
    NSMutableArray *problems;
    int problemIndex;
}

@property (nonatomic, retain) Baby *baby;
@property (nonatomic, retain) CCSprite *babyImage;
@property (nonatomic, retain) CCLabelTTF *problemDesc;
@property (nonatomic, readwrite) BOOL curAnswer;
@property (nonatomic, retain) NSMutableArray *problems;
@property (nonatomic, readwrite) int problemIndex;

-(void) retriveBabyInfo:(NSMutableString *) babyName;
-(void) toHome;
-(void) initTheProblem;

@end

