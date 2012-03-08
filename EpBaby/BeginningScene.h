//
//  BeginningScene.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BeginningScene : CCScene {
    
}

@end


@interface BeginningLayer : CCLayer {
    UITextField *babyName;
    UITextField *playerName;
    int index;
    
    CCSprite *babyHead;
    CCSprite *babyDesc;
    CCSprite *babyType;
}

@property (nonatomic, retain) UITextField *babyName;
@property (nonatomic, retain) UITextField *playerName;
@property (nonatomic, readwrite) int index;
@property (nonatomic, retain) CCSprite *babyHead;
@property (nonatomic, retain) CCSprite *babyDesc;
@property (nonatomic, retain) CCSprite *babyType;

-(void) createCharacter;
-(void) playGame;
-(void) cancelSetting;

@end