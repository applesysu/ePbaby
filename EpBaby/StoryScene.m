//
//  StoryScene.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "StoryScene.h"
#import "StartMenuScene.h"
#import "FileOperation.h"
#import "BeginningScene.h"


@implementation StoryScene

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [self addChild:[StoryLayer node]];
    }
    
    return self;
}

@end


@implementation StoryLayer

@synthesize pageNumber, sprite;

-(void) changeGameMode
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:[FileOperation getAbsolutePathOfFile:@"haveCreateBaby"]])
    {
        CCTransitionJumpZoom *transition = [CCTransitionJumpZoom transitionWithDuration:1.5 scene:[BeginningScene node]];
        [[CCDirector sharedDirector] replaceScene:transition];
    }
    else
    {
        CCTransitionJumpZoom *transition = [CCTransitionJumpZoom transitionWithDuration:1.5 scene:[StartMenuScene node]];
        [[CCDirector sharedDirector] replaceScene:transition];
    }
    
}

-(void) displayPageByPage 
{
    if (self.pageNumber >= 1 && self.pageNumber <13)
    {
        self.pageNumber++;
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"story%d.png", self.pageNumber]];
        [self.sprite setTexture:texture];
        
    }
    else
    {
        CCMenuItemImage *gameMode = [CCMenuItemImage itemFromNormalImage:@"gamemode.png" selectedImage:@"gamemode.png" target:self selector:@selector(changeGameMode)];
        CCMenu *gameModeMenu = [CCMenu menuWithItems:gameMode, nil];
        [self addChild:gameModeMenu];
        [gameModeMenu setPosition:ccp(240, 20)];
        [self unschedule:@selector(displayPageByPage)];
    }
    
}

-(void) displayStory
{
    [self schedule:@selector(displayPageByPage) interval:2.0];
}

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        self.pageNumber = 1;
        self.sprite = [CCSprite spriteWithFile:@"story1.png"];
        [self addChild:self.sprite];
        [sprite setPosition:ccp(240, 160)];
        [self displayStory];
    }
    
    return self;
}

@end
