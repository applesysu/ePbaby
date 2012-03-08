//
//  ControllLayer.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ControllLayer.h"

#define HGameLayer 10001
#define HControlLayer 10002
#define HPauseLayer 10003


@implementation ControllLayer

@synthesize goLeft, goRight, baby, leftSelected, rightSelected, leftIndex, rightIndex, acc, acc2, curDirection;

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [self initControlPanel];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"babymoveframe_default.plist"];
        
        CCSpriteBatchNode *babys = [CCSpriteBatchNode batchNodeWithFile:@"babymoveframe_default.png"];
        [self addChild:babys];
    }
    
    return self;
}

-(NSString *)getBabyImage:(int)babyType
{
    NSString *valueString;
    
    switch (babyType) {
        case 1:
            valueString = @"bluemove";
            break;
            
        case 2:
            valueString = @"greenmove";
            break;
            
        case 3:
            valueString = @"greymove";
            break;
            
        case 4:
            valueString = @"yellowmove";
            break;
    }
    
    return valueString;
}

-(void) initControlPanel
{
    self.goLeft = [CCMenuItemImage itemFromNormalImage:@"left.png" selectedImage:@"left.png" disabledImage:@"left.png" target:self selector:@selector(moveBabyToLeft)];
    
    self.goRight = [CCMenuItemImage itemFromNormalImage:@"right.png" selectedImage:@"right.png" disabledImage:@"right.png" target:self selector:@selector(moveBabyToRight)];
    
    CCMenu *controlLeft = [CCMenu menuWithItems:goLeft, nil];
    [self addChild:controlLeft z:0];
    [controlLeft setPosition:ccp(40, 30)];
    
    CCMenu *controlRight = [CCMenu menuWithItems:goRight, nil];
    [self addChild:controlRight z:0];
    [controlRight setPosition:ccp(440, 30)];
    
    self.leftIndex = 2;
    self.rightIndex = 2;
    acc = 0;
    acc2 = 0;
    curDirection = 0;
    
    [self schedule:@selector(checkMenuItemSelected)];
}

-(Baby *)getMyBaby
{
    GameLayer *gameLayer = (GameLayer *)[[self parent] getChildByTag:HGameLayer];
    return gameLayer.baby;
}

-(void) checkMenuItemSelected
{
    if ([self.goLeft isSelected] || [self.goRight isSelected])
    {
        if ([self.goLeft isSelected])
        {
            [self moveBabyToLeft];
        }
        else
        {
            [self moveBabyToRight];
        }
    }
}


-(void) moveBabyToLeft
{
    
    self.baby = [self getMyBaby];
    
    if (curDirection == 1 || curDirection == 0)
    {
        [self.baby setFlipX:YES];
        curDirection = -1;
    }
    
    CGPoint pos = self.baby.position;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
	float imageWidthHalved = [baby texture].contentSize.width * 0.5f;
	float leftBorderLimit = imageWidthHalved;
	float rightBorderLimit = screenSize.width - imageWidthHalved;
	
	if(pos.x < leftBorderLimit){
		pos.x = leftBorderLimit;
	}else if(pos.x > rightBorderLimit){
		pos.x = rightBorderLimit;
	}
    
    pos.x -= 1.3;
    
    acc++;
    if (acc / 8 >= 1)
    {
        if (self.leftIndex % 5 != 1 && self.leftIndex % 5 != 0)
        {
            NSMutableString *imageName = [[NSMutableString alloc] initWithString:[self getBabyImage:self.baby.babyType]];
            [imageName appendFormat:@"%d.png",self.rightIndex % 5];
            NSLog(@"%@", imageName);
            if (![imageName isEqualToString:@"bluemove0.png"]&&![imageName isEqualToString:@"greymove0.png"] && ![imageName isEqualToString:@"greenmove0.png"] && ![imageName isEqualToString:@"yellowmove0.png"])
            {
                [self.baby setTexture:[[CCTextureCache sharedTextureCache]  addImage:imageName]];
            }
            NSLog(@"left %d", self.leftIndex % 5);
            
        }
        
        self.leftIndex++;
        acc = 0;
    }
     
    [self.baby setPosition:pos];
}

-(void) moveBabyToRight
{
    
    self.baby = [self getMyBaby]; 
    
    if (curDirection == -1)
    {
        [self.baby setFlipX:NO];
        curDirection = 1;
    }
    
    CGPoint pos = self.baby.position;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
	float imageWidthHalved = [baby texture].contentSize.width * 0.5f;
	float leftBorderLimit = imageWidthHalved;
	float rightBorderLimit = screenSize.width - imageWidthHalved;
	
	if(pos.x < leftBorderLimit){
		pos.x = leftBorderLimit;
	}else if(pos.x > rightBorderLimit){
		pos.x = rightBorderLimit;
	}
    
    pos.x += 1.3;
    
    acc2++;
    if (acc2 / 8 >= 1)
    {
        if (self.rightIndex % 5 != 1 && self.rightIndex % 5 != 0)
        {
            NSMutableString *imageName = [[NSMutableString alloc] initWithString:[self getBabyImage:self.baby.babyType]];
            [imageName appendFormat:@"%d.png",self.rightIndex % 5];
            NSLog(@"%@", imageName);
            if (![imageName isEqualToString:@"bluemove0.png"]&&![imageName isEqualToString:@"greymove0.png"] && ![imageName isEqualToString:@"greenmove0.png"] && ![imageName isEqualToString:@"yellowmove0.png"])
            {
                [self.baby setTexture:[[CCTextureCache sharedTextureCache]  addImage:imageName]];
            }
            NSLog(@"right %d", self.rightIndex % 5);
        }
        
        self.rightIndex++;
        acc2 = 0;
    }
    
    [self.baby setPosition:pos];
}




@end
