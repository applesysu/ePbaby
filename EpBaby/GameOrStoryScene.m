//
//  GameOrStoryScene.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameOrStoryScene.h"
#import "BeginningScene.h"
#import "MoreInfoScene.h"
#import "StoryScene.h"
#import "StartMenuScene.h"
#import "FileOperation.h"


@implementation GameOrStoryScene

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [self addChild:[GameOrStoryLayer node] z:0];
    }
    
    return self;
}

@end


@implementation GameOrStoryLayer

-(void)createTheCurrentPlayerFile
{
    NSString *fileName = [[NSString alloc] initWithString:@"currentPlayer.plist"];
    [FileOperation createSpecifiedFile:fileName];
}

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        CCSprite *backGround = [CCSprite spriteWithFile:@"gameorstory.jpg"];
        [self addChild:backGround];
        [backGround setPosition:ccp(240, 160)];
        
        CCMenuItemImage *game = [CCMenuItemImage itemFromNormalImage:@"playgame.png" selectedImage:@"playgame.png" disabledImage:@"playgame.png" target:self selector:@selector(GameMode)];  
        CCMenu *gameMenu = [CCMenu menuWithItems:game, nil];
        [gameMenu setPosition:ccp(100, 250)];
        [self addChild:gameMenu];
        
        CCMenuItemImage *story = [CCMenuItemImage itemFromNormalImage:@"tellstory.png" selectedImage:@"tellstory.png" disabledImage:@"tellstory.png" target:self selector:@selector(StoryMode)];
        CCMenu *storyMenu = [CCMenu menuWithItems:story, nil];
        [storyMenu setPosition:ccp(185,190)];
        [self addChild:storyMenu];
        
        CCMenuItemImage *more = [CCMenuItemImage itemFromNormalImage:@"i2-30.png" selectedImage:@"i2-30.png" target:self selector:@selector(moreInfo)];
        CCMenu *moreInfoMenu = [CCMenu menuWithItems:more, nil];
        [moreInfoMenu setPosition:ccp(460, 20)];
        [self addChild:moreInfoMenu];
        
        [GameOrStoryLayer playBgMusic:@"bg1.mp3"];
    }
    
    return self;
}

-(void) GameMode
{
    if (![FileOperation createSpecifiedFile:@"currentPlayer.plist"])
    {
        CCTransitionFadeTR *transition = [CCTransitionFadeTR transitionWithDuration:1.5 scene:[StartMenuScene node]];
        [[CCDirector sharedDirector] replaceScene:transition];
    }
    else
    {
        CCTransitionFadeTR *transition = [CCTransitionFadeTR transitionWithDuration:1.5 scene:[BeginningScene node]];
        [[CCDirector sharedDirector] replaceScene:transition];
    }
}

-(void) StoryMode
{
    CCTransitionCrossFade *transition = [CCTransitionCrossFade transitionWithDuration:1.5 scene:[StoryScene node]];
    [[CCDirector sharedDirector] replaceScene:transition];
}

-(void) moreInfo
{
    CCTransitionFadeTR *transition = [CCTransitionFadeTR transitionWithDuration:1.5 scene:[MoreInfoScene node]];
    [[CCDirector sharedDirector] replaceScene:transition];
}

+(void) loadBgMusic
{
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bg1.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bg2.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bg3.mp3"];
}

+(void) playBgMusic:(NSString *)fileName
{
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:fileName];
}

+(void) pauseBgMusic
{
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}

+(void) resumeBgMusic
{
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
}

+(void) stopBgMusic
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

@end
