//
//  BeginningScene.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BeginningScene.h"
#import "StartMenuScene.h"
#import "GameOrStoryScene.h"
#import "FileOperation.h"
#import "Baby.h"


@implementation BeginningScene

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [self addChild:[BeginningLayer node] z:0];
    }
    
    return self;
}

@end


@implementation BeginningLayer

@synthesize babyName, playerName, index, babyType, babyDesc, babyHead;

-(void) finish
{
    [self.babyName resignFirstResponder];
    [self.playerName resignFirstResponder];
}

-(void) changeType
{
    CCTexture2D *texture;
    
    self.index++;
    
    switch (self.index % 4) {
        case 1:
        {
            texture = [[CCTextureCache sharedTextureCache] addImage:@"blue15.png"];
            [self.babyType setTexture:texture];
            texture = [[CCTextureCache sharedTextureCache] addImage:@"bdesc.png"];
            [self.babyDesc setTexture:texture];
            texture = [[CCTextureCache sharedTextureCache] addImage:@"bhead.png"];
            [self.babyHead setTexture:texture];
            
            [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        }
            break;
        case 2:
        {
            texture = [[CCTextureCache sharedTextureCache] addImage:@"green15.png"];
            [self.babyType setTexture:texture];
            texture = [[CCTextureCache sharedTextureCache] addImage:@"gredesc.png"];
            [self.babyDesc setTexture:texture];
            texture = [[CCTextureCache sharedTextureCache] addImage:@"grehead.png"];
            [self.babyHead setTexture:texture];
            
            [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        }
            break;
        case 3:
        {
            texture = [[CCTextureCache sharedTextureCache] addImage:@"grey15.png"];
            [self.babyType setTexture:texture];
            texture = [[CCTextureCache sharedTextureCache] addImage:@"gradesc.png"];
            [self.babyDesc setTexture:texture];
            texture = [[CCTextureCache sharedTextureCache] addImage:@"grahead.png"];
            [self.babyHead setTexture:texture];
            
            [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        }
            break;
        case 0:
        {
            texture = [[CCTextureCache sharedTextureCache] addImage:@"yellow15.png"];
            [self.babyType setTexture:texture];
            texture = [[CCTextureCache sharedTextureCache] addImage:@"ydesc.png"];
            [self.babyDesc setTexture:texture];
            texture = [[CCTextureCache sharedTextureCache] addImage:@"yhead.png"];
            [self.babyHead setTexture:texture];
            
            [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        }
            break;
    }
}

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
        self.index = 1;
        
        CCSprite *backGround = [CCSprite spriteWithFile:@"initcharacter.jpg"];
        [backGround setPosition:ccp(240, 160)];
        [self addChild:backGround];
        
        CCMenuItemImage *playItem = [CCMenuItemImage itemFromNormalImage:@"play.png" selectedImage:@"play2.png" target:self selector:@selector(playGame)];
        CCMenu *playMenu = [CCMenu menuWithItems:playItem, nil];
        [playMenu setPosition:ccp(420,25)];
        [self addChild:playMenu];
        
        CCMenuItemImage *cancelItem = [CCMenuItemImage itemFromNormalImage:@"cancel.png" selectedImage:@"cancel2.png" target:self selector:@selector(cancelSetting)];
        CCMenu *cancelMenu = [CCMenu menuWithItems:cancelItem, nil];
        [cancelMenu setPosition:ccp(340,20)];
        [self addChild:cancelMenu];
        
        babyType = [CCSprite spriteWithFile:@"blue15.png"];
        [babyType setPosition:ccp(140,210)];
        [self addChild:babyType];
        
        babyDesc= [CCSprite spriteWithFile:@"bdesc.png"];
        [babyDesc setPosition:ccp(380,80)];
        [self addChild:babyDesc];
        
        babyHead = [CCSprite spriteWithFile:@"bhead.png"];
        [babyHead setPosition:ccp(370,230)];
        [self addChild:babyHead];
        
        self.babyName = [[UITextField alloc] initWithFrame:CGRectMake(115, 173, 200, 40)];
        self.babyName.returnKeyType = UIReturnKeyDone;
        [self.babyName addTarget:self action:@selector(finish) forControlEvents:UIControlEventEditingDidEndOnExit];
        [[[CCDirector sharedDirector] openGLView] addSubview:self.babyName];
        
        CCSprite *babyNameInput = [CCSprite spriteWithFile:@"square.png"];
        [babyNameInput setPosition:ccp(180, 137)];
        [self addChild:babyNameInput];
        
        self.playerName = [[UITextField alloc] initWithFrame:CGRectMake(80, 250, 200, 40)];
        self.playerName.returnKeyType = UIReturnKeyDone;
        [self.playerName addTarget:self action:@selector(finish) forControlEvents:UIControlEventEditingDidEndOnExit];
        [[[CCDirector sharedDirector] openGLView] addSubview:self.playerName];
        
        CCSprite *playNameInput = [CCSprite spriteWithFile:@"square.png"];
        [playNameInput setPosition:ccp(140, 60)];
        [self addChild:playNameInput];
        
        CCMenuItemImage *select = [CCMenuItemImage itemFromNormalImage:@"space.png" selectedImage:@"space.png" target:self selector:@selector(changeType)];
        CCMenu *selectMenu = [CCMenu menuWithItems:select, nil];
        [selectMenu setPosition:ccp(190, 210)];
        [self addChild:selectMenu];
        
        [self createTheCurrentPlayerFile];
        
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    }
    
    return self;
}

-(void) createCharacter
{
    Baby *baby = [[Baby alloc] init];
    baby.babyType = self.index;
    baby.name = self.babyName.text;
    baby.assets = 0;
    baby.experience = 0;
    baby.moveSpeed = 10;
    baby.purchaseTools = [[NSMutableArray alloc] init];
    
    NSMutableString *fileName = [[NSMutableString alloc] initWithString:baby.name];
    [fileName appendString:@".plist"];
    
    if ([FileOperation createSpecifiedFile:fileName])
    {
        [baby persistBabyInfo:fileName];
        [baby persistCurrentPlayerName];
        
        NSLog(@"%@", [Baby getCurrentPlayerName]);
    }
}

-(void) playGame
{
    [self createCharacter];
    [FileOperation createSpecifiedFile:@"haveCreateBaby"];
    [self.babyName removeFromSuperview];
    [self.playerName removeFromSuperview];
    CCTransitionFlipAngular *transitionScene = [CCTransitionFlipAngular transitionWithDuration:0.5 scene:[StartMenuScene node]];
    [[CCDirector sharedDirector] replaceScene:transitionScene];
}


-(void) cancelSetting
{
    [self.babyName removeFromSuperview];
    [self.playerName removeFromSuperview];
    CCTransitionFadeTR *transitionScene = [CCTransitionFadeTR transitionWithDuration:0.5 scene:[GameOrStoryScene node]];
    [[CCDirector sharedDirector] replaceScene:transitionScene];
}

@end
