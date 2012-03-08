//
//  GameOverLayer.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"
#import "GameOrStoryScene.h"

#define HGameLayer 10001
#define HControlLayer 10002
#define HPauseLayer 10003
#define HGameOverlayer 10004


@implementation GameOverLayer

@synthesize replayItem, goToMainMenuItem;

-(id) initWithMyColor:(ccColor4B)color
{
    self = [super initWithColor:color];
    
    if (self != nil)
    {
        CCSprite *gameOverImg = [CCSprite spriteWithFile:@"pauseLabel.png"];
        [gameOverImg setPosition:ccp(230,210)];
        [self addChild:gameOverImg];
        
        
        self.replayItem = 
        [CCMenuItemImage itemFromNormalImage:@"retry.png" selectedImage:@"retry.png" target:self selector:@selector(replay)];
        
        self.goToMainMenuItem = 
        [CCMenuItemImage itemFromNormalImage:@"gohome.png" selectedImage:@"gohome.png" target:self selector:@selector(goToMainMenu)];
        
        CCMenu *gameOverMenu = [CCMenu menuWithItems:replayItem, goToMainMenuItem, nil];
        [gameOverMenu alignItemsHorizontallyWithPadding:5];
        [self addChild:gameOverMenu z:0];
        [gameOverMenu setPosition:ccp(240, 140)];
        
    }
    
    return  self;
}

-(void) replay
{
    GameLayer *gl = (GameLayer *)[[[CCDirector sharedDirector] runningScene] getChildByTag:HGameLayer];
    [gl gameRestart];
}

-(void) goToMainMenu
{
    [GameOrStoryLayer playBgMusic:@"bg1.mp3"];
    
    [[CCDirector sharedDirector] replaceScene:[StartMenuScene node]];
}

@end
