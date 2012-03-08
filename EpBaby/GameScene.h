//
//  GameScene.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Baby.h"

enum GameState
{
    GamePlaying,
    GamePaused
};

@interface GameScene : CCScene {
    
}


@end


@interface GameLayer : CCLayer {
    Baby *baby;
    NSMutableArray *rubbishs;
    long highestScore;
    enum GameState gameState;
    NSTimer *timer;
    int gameTimeLeft;
    CCLabelAtlas *timeLabel;
    
    CCMenuItemImage *pauseItem;
    
}

@property (nonatomic, retain) Baby *baby;
@property (nonatomic, retain) NSMutableArray *rubbishs;
@property (nonatomic, readwrite) long highestScore;
@property (nonatomic, readwrite) int gameTimeLeft;
@property (nonatomic, readwrite) enum GameState gameState;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) CCLabelAtlas *timeLabel;
@property (nonatomic, retain) CCMenuItemImage *pauseItem;

-(void) initGameData;
-(void) initBaby;
-(void) beforeGameStarted;
-(void) setupTimer;
-(void) trashAppear;
-(void) gameStarted;
-(void) gameEnded;
-(void) gamePause;
-(void) gameResume;
-(void) gameRestart;


@end