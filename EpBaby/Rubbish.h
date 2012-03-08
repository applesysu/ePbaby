//
//  Rubbish.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Baby;

@interface Rubbish : CCSprite {
    int rubbishType;
    int rubbishValue;
    BOOL isPicked;
    Baby *myBaby;
    
    CGFloat x;
    CGFloat y;
    int moveSpeed;
}

@property (nonatomic, readwrite) int rubbishType;
@property (nonatomic, readwrite) int rubbishValue;
@property (nonatomic, readwrite) BOOL isPicked;
@property (nonatomic, retain) Baby *myBaby;
@property (nonatomic, readwrite) CGFloat x;
@property (nonatomic, readwrite) CGFloat y;
@property (nonatomic, readwrite) int moveSpeed;

-(id) initWithMyImage:(NSString *)image withMyBaby:(Baby *)baby;
-(void) dropDown;
-(CGRect) getSpriteRect;
-(BOOL) isCollisionWithBaby;
@end
