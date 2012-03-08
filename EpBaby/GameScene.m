//
//  GameScene.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "Rubbish.h"
#import "PauseLayer.h"
#import "GameOverLayer.h"
#import "ControllLayer.h"
#import "GameOrStoryScene.h"

#define HGameLayer 10001
#define HControlLayer 10002
#define HPauseLayer 10003
#define HGameOverlayer 10004

#define RubbishType 4
#define RubbishValue 10

@implementation GameScene

-(id) init
{
    self = [super init];
    
    if (self != nil) {
        [self addChild:[GameLayer node] z:0 tag:HGameLayer];
        [self addChild:[ControllLayer node] z:0 tag:HControlLayer];
        [GameOrStoryLayer playBgMusic:@"bg2.mp3"];
    }
    
    return self;
}

-(void) dealloc
{
    [super dealloc];
}

@end



@implementation GameLayer

@synthesize baby, rubbishs, gameTimeLeft, highestScore, timer, timeLabel, pauseItem, gameState;

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [[CCTextureCache sharedTextureCache] removeUnusedTextures];
        
        [GameOrStoryLayer playBgMusic:@"bg2.mp3"];
        
        self.isAccelerometerEnabled = NO;
        [self initGameData];
        [self initBaby];
        [self beforeGameStarted];
    }
    
    return self;
}

-(void) initGameData
{
    self.gameState = GamePlaying;
    self.gameTimeLeft = 30;
    self.highestScore = 0;
    self.rubbishs = [[NSMutableArray alloc] init];
    
    CCSprite *backGround = [CCSprite spriteWithFile:@"gameScene2.jpg"];
    [self addChild:backGround];
    [backGround setPosition:ccp(240, 160)];
    
    self.pauseItem = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause.png" target:self selector:@selector(gamePause)];
    CCMenu *pauseMenu = [CCMenu menuWithItems:pauseItem, nil];
    [self addChild:pauseMenu z:0];
    [pauseMenu setPosition:ccp(460, 300)];
    
    CCSprite *sprite = [CCSprite spriteWithFile:@"timeclock.png"];
    [sprite setPosition:ccp(20, 300)];
    [self addChild:sprite];
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
}

-(void) initBaby
{
    Baby *cbaby = [[Baby alloc] init];
    NSMutableString *fileName = [[NSMutableString alloc] initWithString:[Baby getCurrentPlayerName]];
    [fileName appendString:@".plist"];
    [cbaby retriveBabyInfo:fileName];
    
    switch (cbaby.babyType) {
        case 1:
        {
            self.baby = [[Baby alloc] initWithImage:@"bluemove1.png" theName:cbaby.name theType:cbaby.babyType];
        }
            break;
            
        case 2:
        {
            self.baby = [[Baby alloc] initWithImage:@"greenmove1.png" theName:cbaby.name theType:cbaby.babyType];
        }
            break;
            
        case 3:
        {
            self.baby = [[Baby alloc] initWithImage:@"greymove1.png" theName:cbaby.name theType:cbaby.babyType];
        }
            break;
            
        case 4:
        {
            self.baby = [[Baby alloc] initWithImage:@"yellowmove1.png" theName:cbaby.name theType:cbaby.babyType];
        }
            break;
    }
    
    self.baby.assets = cbaby.assets;
    self.baby.experience = cbaby.experience;
    self.baby.moveSpeed = cbaby.moveSpeed;
    self.baby.purchaseTools = cbaby.purchaseTools;
    
    [self addChild:self.baby];
    [self.baby setPosition:ccp(240, 35)];
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
}

-(void) beforeGameStarted
{
    float timeInterval = 0.5;

    for (int i = 3; i >= 1; i--)
    {
        CCSprite *number = [CCSprite spriteWithFile:[NSString stringWithFormat:@"backward%d.png", i]];
        [self addChild:number z:0];
        [number setPosition:ccp(240, 160)];
        [number setOpacity:0];
        
        [number runAction:[CCSequence actions:[CCDelayTime actionWithDuration:timeInterval], 
                          [CCSpawn actions:
                           [CCFadeIn actionWithDuration:0.4], [CCScaleTo actionWithDuration:0.4 scale:1.2], nil],
                          [CCDelayTime actionWithDuration:0.2],
                          [CCFadeOut actionWithDuration:0.4],
                          [CCCallFuncN actionWithTarget:self selector:@selector(removeSprite:)],
                          nil]];
        timeInterval += 1.0;
    }
    
    CCSprite *go = [CCSprite spriteWithFile:@"go.png"];
    [self addChild:go z:0];
    [go setPosition:ccp(240, 160)];
    [go setOpacity:0];
    
    [go runAction:[CCSequence actions:[CCDelayTime actionWithDuration:timeInterval], 
                      [CCSpawn actions:
                       [CCFadeIn actionWithDuration:0.4], [CCScaleTo actionWithDuration:0.4 scale:1.2], nil],
                      [CCDelayTime actionWithDuration:0.2],
                      [CCFadeOut actionWithDuration:0.4],
                      [CCCallFuncN actionWithTarget:self selector:@selector(removeSpriteAndBegin:)],
                      nil]];
    
    self.timeLabel = [CCLabelAtlas labelWithString:@"30" charMapFile:@"fps_images.png" itemWidth:16 itemHeight:24 startCharMap:'.']; 
    [self addChild:timeLabel z:0];
    [timeLabel setPosition:ccp(35,290)];
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
}

-(void) removeSprite:(CCNode *) n
{
    [self removeChild:n cleanup:YES];
}
-(void) removeSpriteAndBegin:(CCNode *) n
{
    [self removeChild:n cleanup:YES];
    [self gameStarted];
    
}

-(void)changeTime
{
    if(gameTimeLeft == 0)
    {	
        return;
    }
    else
    {	gameTimeLeft--;	
        if(gameTimeLeft == 0)
        {	
            [self gameEnded];
            [timer invalidate];
            [self unschedule:@selector(trashAppear)];
            
            [[CCTextureCache sharedTextureCache] removeUnusedTextures];
            
        }
        
        NSMutableString *timeleft = [[NSMutableString alloc] initWithString:@""];
        NSString *temp = [NSString stringWithFormat:@"%d", gameTimeLeft];
        [timeleft appendString:temp];
        [timeLabel setString:timeleft];
        
    }
}

-(void) setupTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
}

-(void) gameStarted
{
    [self setupTimer];
    
//    self.isAccelerometerEnabled = NO;
//    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
//    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
    
    //开始投掷垃圾的线程
    [self schedule:@selector(trashAppear) interval:1];
}

-(void)trashAppear
{
    int ram_rubbishType = arc4random() % RubbishType + 1;
    NSString *imageName;
    switch (ram_rubbishType) {
        case 1: 
        {
            int ram_rubbish = arc4random() % 4 + 1;
            switch (ram_rubbish) {
                case 1:
                {
                    imageName = @"mud.png";
                }
                    break;
                case 2:
                {
                    imageName = @"zhuan.png";
                }
                    break;
                case 3:
                {
                    imageName = @"film.png";
                }
                    break;
                case 4:
                {
                    imageName = @"cup.png";
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        case 2:
        {
            int ram_rubbish = arc4random() % 3 + 1;
            switch (ram_rubbish) {
                case 1:
                {
                    imageName =  @"skin.png";
                }
                    break;
                case 2:
                {
                    imageName = @"bone.png";
                }
                    break;
                case 3:
                {
                    imageName = @"egg.png";
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        case 3:
        {
            int ram_rubbish = arc4random() % 3 + 1;
            switch (ram_rubbish) {
                case 1:
                {
                    imageName = @"glass.png";
                }
                    break;
                case 2:
                {
                    imageName = @"paper.png";
                }
                    break;
                case 3:
                {
                    imageName = @"cloth.png";
                }
                    break;
                default:
                    break;
            }
        }
            
        case 4:
        {
            int ram_rubbish =  arc4random() % 2 + 1;
            switch (ram_rubbish) {
                case 1:
                {
                    imageName = @"tem.png";
                }
                    break;
                    
                case 2:
                {
                    imageName = @"pill.png";
                }
                    break;
                    
                default:
                    break;
            }
        }
            
        default:
            break;
    }
    Rubbish *rubbish = [[Rubbish alloc] initWithMyImage:imageName withMyBaby:self.baby];
    rubbish.rubbishType = ram_rubbishType;
    [self addChild:rubbish z:0 ];
    CCRotateBy *rotate = [CCRotateBy actionWithDuration:4.0f angle:360];
    [rubbish runAction:rotate];
    [rubbish dropDown];
    
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    float deceleration = 0.4f;
	float sensitivity  = 6.0f;
	float maxVelocity  = 100.0f;
    
    CGPoint pos = baby.position;
    
	baby.moveSpeed = baby.moveSpeed * deceleration + acceleration.y * sensitivity;
	
    if(baby.moveSpeed > maxVelocity){
		baby.moveSpeed = maxVelocity;
	}else if(baby.moveSpeed < -maxVelocity){
		baby.moveSpeed = -maxVelocity;
	}
    
	pos.x -= baby.moveSpeed;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
	float imageWidthHalved = [baby texture].contentSize.width * 0.5f;
	float leftBorderLimit = imageWidthHalved;
	float rightBorderLimit = screenSize.width - imageWidthHalved;
	
	if(pos.x < leftBorderLimit){
		pos.x = leftBorderLimit;
		baby.moveSpeed = 0;
	}else if(pos.x > rightBorderLimit){
		pos.x = rightBorderLimit;
		baby.moveSpeed = 0;
	}
    
    [baby setPosition:pos];
    
}


-(void) gamePause
{
    [GameOrStoryLayer pauseBgMusic];
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [timer invalidate];
    [self setIsAccelerometerEnabled:NO];
    ccColor4B c = {100,100,0,100};
    PauseLayer *pl = [[PauseLayer alloc] initWithMyColor:c];
    [[self parent] addChild:pl z:1 tag:HPauseLayer];
    [[CCDirector sharedDirector] pause];
}

-(void) gameResume
{
    [GameOrStoryLayer resumeBgMusic];
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [self setupTimer];
}

-(void) gameEnded
{
    [GameOrStoryLayer stopBgMusic];
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    ccColor4B mycolor = {100,100,0,100};
    GameOverLayer *gol = [[GameOverLayer alloc] initWithMyColor:mycolor];
    [self addChild:gol z:1 tag:HGameOverlayer];
    
}

-(void) gameRestart
{
    [GameOrStoryLayer playBgMusic:@"bg2.mp3"];
    
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [[self parent] removeChildByTag:HGameOverlayer cleanup:YES];
    [self removeAllChildrenWithCleanup:YES];
    [self initGameData];
    [self initBaby];
    self.timeLabel = [CCLabelAtlas labelWithString:@"30" charMapFile:@"fps_images.png" itemWidth:16 itemHeight:24 startCharMap:'.']; 
    [self addChild:timeLabel z:0];
    [timeLabel setPosition:ccp(35,290)];
    [self gameStarted];
}

@end
