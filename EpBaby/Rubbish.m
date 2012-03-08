//
//  Rubbish.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#define RubbishType 4
#define RubbishValue 10

#import "Rubbish.h"
#import "Baby.h"

@implementation Rubbish

@synthesize rubbishType, rubbishValue, isPicked, myBaby, x, y, moveSpeed;

-(id) initWithMyImage:(NSString *)image withMyBaby:(Baby *)baby
{
    self = [super initWithFile:image];
    
    if (self != nil)
    {
        self.myBaby = baby;
        self.rubbishValue = arc4random() % RubbishValue + 1;
        self.isPicked = NO;
        self.moveSpeed = 0.05;                              //控制rubbish的下降函数调用时间间隙
        self.x = arc4random() % 400 + 40;
        self.y = 320;
        [self setPosition:ccp(self.x, self.y)];
    }
    
    return self;
}

-(void) dropDown
{
    [self schedule:@selector(updatePosition) interval:self.moveSpeed];
}

-(void) updatePosition
{
    if (self.y + self.contentSize.height < 0)
    {
        [self unschedule:@selector(updatePosition)];
        [self removeFromParentAndCleanup:YES];
        NSLog(@"No.%d rubbish is removed", self.tag);
    }
    else
    {
        self.y--;
        [self setPosition:ccp(self.x, self.y)];
        if ([self isCollisionWithBaby])
        {
            NSLog(@"you got a point");
            [self removeFromParentAndCleanup:YES];
        }
    }
}

-(CGRect) getSpriteRect
{
    CGFloat sx = self.position.x - self.textureRect.size.width / 2;
    CGFloat sy = self.position.y - self.textureRect.size.height / 2;
    CGFloat width = self.textureRect.size.width;
    CGFloat height = self.textureRect.size.height;
    
    CGRect rect = CGRectMake(sx, sy, width, height);
    return rect;
}

-(NSString *)getBabyCry:(int)babyType
{
    NSString *valueString;
    
    switch (babyType) {
        case 1:
            valueString = @"bluemove.png";
            break;
            
        case 2:
            valueString = @"greenmove.png";
            break;
            
        case 3:
            valueString = @"greymove.png";
            break;
            
        case 4:
            valueString = @"yellowmove.png";
            break;
    }
    
    return valueString;
}

-(BOOL) isCollisionWithBaby
{
    CGRect babyRect = [myBaby getSpriteRect];
    CGRect rubbishRect = [self getSpriteRect];
    
    if (CGRectIntersectsRect(rubbishRect, babyRect))
    {
        isPicked = YES;
        if (self.myBaby.babyType != self.rubbishType)
        {
            [self.myBaby setTexture:[[CCTextureCache sharedTextureCache] addImage:[self getBabyCry:self.myBaby.babyType]]];
        }
        
        return YES;
    }
    
    return NO;
}



@end
