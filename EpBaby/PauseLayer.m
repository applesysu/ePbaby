//
//  PauseLayer.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"
#import "Rubbish.h"
#import "StartMenuScene.h"

#define HGameLayer 10001
#define HControlLayer 10002
#define HPauseLayer 10003

@implementation PauseLayer

@synthesize resumeItem, replayItem, homeItem;

-(id) initWithMyColor:(ccColor4B)color
{
    if ((self = [super initWithColor:color]))
    {
        self.resumeItem = [CCMenuItemImage itemFromNormalImage:@"goon.png" selectedImage:@"goon.png" target:self selector:@selector(gameResume)];
        self.replayItem = [CCMenuItemImage itemFromNormalImage:@"retry.png" selectedImage:@"retry.png" target:self selector:@selector(gameRestart)];
        self.homeItem = [CCMenuItemImage itemFromNormalImage:@"gohome.png" selectedImage:@"gohome.png" target:self selector:@selector(goHome)];
        
        CCMenu *resumeMenu = [CCMenu menuWithItems:resumeItem, nil];
        [resumeMenu setPosition:ccp(180, 185)];
        [self addChild:resumeMenu];
        
        CCMenu *replayMenu = [CCMenu menuWithItems:replayItem, nil];
        [replayMenu setPosition:ccp(300, 185)];
        [self addChild:replayMenu];
        
        CCMenu *homeMenu = [CCMenu menuWithItems:homeItem, nil];
        [homeMenu setPosition:ccp(240, 130)];
        [self addChild:homeMenu];
        
        CCSprite *paused = [CCSprite spriteWithFile:@"pauseLabel.png"];
        [paused setPosition:ccp(242, 240)];
        [self addChild:paused];
        
    }
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

-(void) gameResume
{
    GameLayer *gl = (GameLayer *)[[self parent] getChildByTag:HGameLayer];
    [gl gameResume];
    [self removeFromParentAndCleanup:YES];
    [[CCDirector sharedDirector] resume];
    
}

-(void) gameRestart
{
    GameLayer *gl = (GameLayer *)[[self parent] getChildByTag:HGameLayer];
    [gl gameRestart];
    [self removeFromParentAndCleanup:YES];
    [[CCDirector sharedDirector] resume];
}

-(void) goHome
{
    [[CCDirector sharedDirector] replaceScene:[StartMenuScene node]];
    [[CCDirector sharedDirector] resume];
}

@end
