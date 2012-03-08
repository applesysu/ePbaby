//
//  ControllLayer.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"


@interface ControllLayer : CCLayer {
    CCMenuItemImage *goLeft;
    BOOL leftSelected;
    CCMenuItemImage *goRight;
    BOOL rightSelected;
    
    Baby *baby;
    
    int leftIndex;
    int rightIndex;
    int acc;
    int acc2;
    int curDirection;
}

@property (nonatomic, retain) CCMenuItemImage *goLeft;
@property (nonatomic, retain) CCMenuItemImage *goRight;
@property (nonatomic, retain) Baby *baby;
@property (nonatomic, readwrite) BOOL leftSelected;
@property (nonatomic, readwrite) BOOL rightSelected;
@property (nonatomic, readwrite) int leftIndex;
@property (nonatomic, readwrite) int rightIndex;
@property (nonatomic, readwrite) int acc;
@property (nonatomic, readwrite) int acc2;
@property (nonatomic, readwrite) int curDirection;

-(void) initControlPanel;
-(void) moveBabyToLeft;
-(void) moveBabyToRight;
-(void) checkMenuItemSelected;

@end
