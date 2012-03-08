//
//  MoreInfoScene.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreInfoScene.h"
#import "GameOrStoryScene.h"


@implementation MoreInfoScene

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [self addChild:[MoreInfoLayer node]];
    }
    
    return self;
}

@end

@implementation MoreInfoLayer

-(void) returnTo
{
    CCTransitionCrossFade *trancsition = [CCTransitionCrossFade transitionWithDuration:0.5 scene:[GameOrStoryScene node]];
    [[CCDirector sharedDirector] replaceScene:trancsition];
}

-(id) init
{
    self =  [super init];
    
    if (self != nil)
    {
        CCSprite *sprite = [CCSprite spriteWithFile:@"aboutus.png"];
        [sprite setPosition:ccp(240, 160)];
        [self addChild:sprite];
        
        CCMenuItemImage *returnToMainMenu = [CCMenuItemImage itemFromNormalImage:@"back-green.png" selectedImage:@"back-orange.png" target:self selector:@selector(returnTo)];
        CCMenu *tempMenu = [CCMenu menuWithItems:returnToMainMenu, nil];
        [tempMenu setPosition:ccp(20, 20)];
        [self addChild:tempMenu];
        
    }
    
    return self;
}

@end
