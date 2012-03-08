//
//  StartMenuScene.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "StartMenuScene.h"
#import "GameScene.h"
#import "TestScene.h"
#import "StoreScene.h"
#import "GameOrStoryScene.h"
#import "FileOperation.h"


@implementation StartMenuScene

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        [self addChild:[StartMenuLayer node]];
        
    }
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end



@implementation StartMenuLayer

@synthesize shopMenu, quizMenu, gameMenu, feedMenu, line, menu, baby, assnumber, expnumber,star;

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [self initTheMenu];
    }
    
    return self;
}

-(void) saveTheBabyData
{
    NSMutableString *fileName = [[NSMutableString alloc] initWithString:[Baby getCurrentPlayerName]];
    [fileName appendString:@".plist"];
    
    [self.baby persistBabyInfo:fileName];
}

-(NSString *)getBabyImageName:(int)babyType
{
    NSString *valueString;
    switch (babyType) {
        case 1:
            valueString = @"blue1-120.png";
            break;
        case 2:
            valueString = @"green1-120.png";
            break;
        case 3:
            valueString = @"grey1-120.png";
            break;
        case 4:
            valueString = @"yellow1-120.png";
    }
    return valueString;
}

-(void) showTools
{
    for (int i = 0; i < [self.baby.purchaseTools count]; i++)
    {
        NSMutableString *imageName = [[NSMutableString alloc] initWithString:[self.baby.purchaseTools objectAtIndex:i]];
        [imageName appendString:@".png"];
        if ([imageName isEqualToString:@"wall1.png"] || [imageName isEqualToString:@"wall2.png"] || [imageName isEqualToString:@"wall3.png"])
        {
            [(CCSprite *)[self getChildByTag:100] setTexture:[[CCTextureCache sharedTextureCache] addImage:imageName]];
            [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        }
        else
        {
            CCSprite *toolSprite = [CCSprite spriteWithFile:imageName];
            [toolSprite setPosition:ccp(20+i*15,10)];
            [self addChild:toolSprite z:5];
        }
    }
}

-(void) initTheMenu
{
    menu = NO;
    
    baby = [[Baby alloc] init];
    NSMutableString *fileName = [[NSMutableString alloc] initWithString:[Baby getCurrentPlayerName]];

    [fileName appendString:@".plist"];
    NSLog(@"this is in the start secne.  after and the file of the baby is %@", fileName);
    [baby retriveBabyInfo:fileName];
    
    NSLog(@"%@, %d, %ld, %ld, %d", baby.name, baby.babyType, baby.assets, baby.experience ,baby.moveSpeed);
    
    NSLog(@"this is in the start secne. and the name of the baby is %@", fileName);
    
    [self showTools];
    
    CCMenuItemImage *game = [CCMenuItemImage itemFromNormalImage:@"gamebutton.png" selectedImage:@"gamebutton.png" target:self selector:@selector(startGame:)];
    gameMenu = [CCMenu menuWithItems:game, nil];
    [gameMenu setPosition:ccp(230, 358)];
    [self addChild:gameMenu z:2];
    
    CCMenuItemImage *feed = [CCMenuItemImage itemFromNormalImage:@"feedbutton.png" selectedImage:@"feedbutton.png" target:self selector:@selector(feed:)];
    feedMenu = [CCMenu menuWithItems:feed, nil];
    [feedMenu setPosition:ccp(290, 358)];
    [self addChild:feedMenu z:2];
    
    CCMenuItemImage *quiz = [CCMenuItemImage itemFromNormalImage:@"quizbutton.png" selectedImage:@"quizbutton.png" target:self selector:@selector(beginQ_A:)];
    quizMenu = [CCMenu menuWithItems:quiz, nil];
    [quizMenu setPosition:ccp(350, 356)];
    [self addChild:quizMenu z:2];
    
    CCMenuItemImage *shop = [CCMenuItemImage itemFromNormalImage:@"shopbutton.png" selectedImage:@"shopbutton.png" target:self selector:@selector(shopping:)];
    shopMenu = [CCMenu menuWithItems:shop, nil];
    [shopMenu setPosition:ccp(410, 360)];
    [self addChild:shopMenu z:2];

    CCSprite *startline = [CCSprite spriteWithFile:@"starline.png"];
    [startline setPosition:ccp(460, 303)];
    [self addChild:startline z:3];
    
    star = [CCMenuItemImage itemFromNormalImage:@"star2.png" selectedImage:@"star2.png" target:self selector:@selector(menuControl)];
    CCMenu *starMenu = [CCMenu menuWithItems:star, nil];
    [starMenu setPosition:ccp(460, 268)];
    [self addChild:starMenu z:2];
    
    [star runAction:[CCRepeatForever actionWithAction:[CCBlink actionWithDuration:1.5 blinks:1]]];
    
    line = [CCSprite spriteWithFile:@"line.png"];
    [line setPosition:ccp(320, 390)];
    [self addChild:line z:2];
    
    
    CCSprite *backGround = [CCSprite spriteWithFile:@"unmove.png"];
    [backGround setPosition:ccp(240, 140)];
    [self addChild:backGround z:1];
    
    CCSprite *initWallPaper = [CCSprite spriteWithFile:@"wall4.png"];
    [initWallPaper setPosition:ccp(240, 180)];
    [self addChild:initWallPaper z:0 tag:100];
    
    CCSprite *vase = [CCSprite spriteWithFile:@"vase.png"];
    [vase setPosition:ccp(90, 161)];
    [self addChild:vase];
    
    CCSprite *vaseLamp = [CCSprite spriteWithFile:@"vaselamp.png"];
    [vaseLamp setPosition:ccp(50, 170)];
    [self addChild:vaseLamp];
    
    CCSprite *health = [CCSprite spriteWithFile:@"heart.png"];
    [health setPosition:ccp(20, 245)];
    [self addChild:health];
    
    CCSprite *mood = [CCSprite spriteWithFile:@"mood.png"];
    [mood setPosition:ccp(20, 215)];
    [self addChild:mood];
    
    CCSprite *babyImage = [CCSprite spriteWithFile:[self getBabyImageName:baby.babyType]];
    [babyImage setPosition:ccp(240, 80)];
    [self addChild:babyImage z:2];
    
    CCMenuItemImage *homeButton = [CCMenuItemImage itemFromNormalImage:@"homebutton.png" selectedImage:@"homebutton.png" target:self selector:@selector(toHome)];
    CCMenu *homeMenu = [CCMenu menuWithItems:homeButton, nil];
    [homeMenu setPosition:ccp(30,290)];
    [self addChild:homeMenu];
    
    expnumber = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%d", self.baby.experience] fntFile:@"hud_font.fnt"];
    [expnumber setColor:ccRED];
    [expnumber setPosition:ccp(40,245)];
    [self addChild:expnumber z:0];
    
    assnumber = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%d", self.baby.assets] fntFile:@"hud_font.fnt"];
    [assnumber setColor:ccRED];
    [assnumber setPosition:ccp(40, 215)];
    [self addChild:assnumber z:0];
    
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
}

-(void) startGame : (id) sender
{
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [self saveTheBabyData];
    
    GameScene *gameScene = [GameScene node];
    [[CCDirector sharedDirector] replaceScene:gameScene];
}

-(void) beginQ_A : (id) sender
{
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [self saveTheBabyData];
    
    TestScene *testScene = [TestScene node];
    [[CCDirector sharedDirector] replaceScene:testScene];
}

-(void) shopping:(id)sender
{
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [self saveTheBabyData];
    
    StoreScene *storeScene = [StoreScene node];
    [[CCDirector sharedDirector] replaceScene:storeScene];
}

-(void) feed:(id)sender
{
    //补上喂养效果
    baby.assets -= 15;
    baby.experience += 15;
}

-(void) showMenu
{
    [self.line runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(320, 310)]];
    [self.gameMenu runAction:[CCMoveTo actionWithDuration:0.7 position:ccp(230, 278)]];
    [self.feedMenu runAction:[CCMoveTo actionWithDuration:0.9 position:ccp(290, 278)]];
    [self.quizMenu runAction:[CCMoveTo actionWithDuration:1.1 position:ccp(350, 276)]];
    [self.shopMenu runAction:[CCMoveTo actionWithDuration:1.3 position:ccp(410, 280)]];
    
}

-(void) hideMenu
{
    [self.line runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(320, 390)]];
    [self.gameMenu runAction:[CCMoveTo actionWithDuration:0.7 position:ccp(230, 358)]];
    [self.feedMenu runAction:[CCMoveTo actionWithDuration:0.9 position:ccp(290, 358)]];
    [self.quizMenu runAction:[CCMoveTo actionWithDuration:1.1 position:ccp(350, 356)]];
    [self.shopMenu runAction:[CCMoveTo actionWithDuration:1.3 position:ccp(410, 360)]];
}

-(void) menuControl
{
    if (self.menu)
    {
        [self hideMenu];
        self.menu = NO;
        [self.star runAction:[CCRepeatForever actionWithAction:[CCBlink actionWithDuration:1.5 blinks:1]]];
        
    }
    else
    {
        [self showMenu];
        self.menu = YES;
        [self.star stopAllActions];
    }
}

-(void) toHome
{
    [self saveTheBabyData];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:[GameOrStoryScene node]]];
}

@end
