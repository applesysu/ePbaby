//
//  Baby.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Baby.h"
#import "FileOperation.h"


@implementation Baby

@synthesize babyType, name, assets, experience, moveSpeed, purchaseTools;

-(id) initWithImage:(NSString *)image theName:(NSString *)babyName theType:(int)type
{
    self = [super initWithFile:image];
    
    if (self != nil)
    {
        
        NSMutableString *fileName = [[NSMutableString alloc] initWithString:babyName];
        [fileName appendString:@".plist"];
        NSLog(@" init baby %@", fileName);
        
        if ([FileOperation createSpecifiedFile:fileName])
        {
            self.name = babyName;
            self.babyType = type;
            self.assets = 0;
            self.experience = 100;
            self.moveSpeed = 10;
            self.purchaseTools = [[NSMutableArray alloc] init];
            
            [self persistBabyInfo:fileName];
            [self persistCurrentPlayerName];
        }
        else
        {
            [self retriveBabyInfo:fileName];
        }
        
    }
    
    return self;
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

-(void) retriveBabyInfo:(NSString *)fileName
{
    NSString *filePath = [FileOperation getAbsolutePathOfFile:fileName];
    NSMutableDictionary *totalInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSMutableDictionary *babyInfo = [totalInfo objectForKey:@"babyInfo"];
    self.name = (NSString *)[babyInfo objectForKey:@"name"];
    self.babyType = [(NSNumber *)[babyInfo objectForKey:@"babyType"] intValue];
    self.assets = [(NSNumber *)[babyInfo objectForKey:@"assets"] longValue];
    self.experience = [(NSNumber *)[babyInfo objectForKey:@"experience"] longValue];
    self.moveSpeed = [(NSNumber *)[babyInfo objectForKey:@"moveSpeed"] intValue];
    self.purchaseTools = [totalInfo objectForKey:@"purchaseTools"];
    
    NSLog(@"%@, %d, %ld, %ld, %d", self.name, self.babyType, self.assets, self.experience ,self.moveSpeed);
    NSLog(@"%d", [self.purchaseTools count]);
    for (int i = 0; i < [self.purchaseTools count]; i++)
    {
        NSLog(@"%@", [self.purchaseTools objectAtIndex:i]);
    }
    
}

-(BOOL) persistBabyInfo:(NSString *)fileName
{
    NSMutableDictionary *babyInfo = [[NSMutableDictionary alloc] init];
    [babyInfo setObject:self.name forKey:@"name"];
    [babyInfo setObject:[NSNumber numberWithInt:self.babyType] forKey:@"babyType"];
    [babyInfo setObject:[NSNumber numberWithLong:self.assets] forKey:@"assets"];
    [babyInfo setObject:[NSNumber numberWithLong:self.experience] forKey:@"experience"];
    [babyInfo setObject:[NSNumber numberWithInt:self.moveSpeed] forKey:@"moveSpeed"];
    
    NSMutableDictionary *totalInfo = [[NSMutableDictionary alloc] init];
    [totalInfo setObject:babyInfo forKey:@"babyInfo"];
    [totalInfo setObject:self.purchaseTools forKey:@"purchaseTools"];
    
    NSString *filePath = [FileOperation getAbsolutePathOfFile:fileName];
    [totalInfo writeToFile:filePath atomically:YES];
    
    [babyInfo release];
    [totalInfo release];
    
    return YES;
}

-(void) persistCurrentPlayerName
{
    NSMutableDictionary *currentPlayer = [[NSMutableDictionary alloc] init];
    [currentPlayer setObject:self.name forKey:@"currentPlayer"];
    
    NSString *fileName = [[NSString alloc] initWithString:@"currentPlayer.plist"];
    NSString *filePath = [FileOperation getAbsolutePathOfFile:fileName];
    [currentPlayer writeToFile:filePath atomically:YES];
}

+(NSString *) getCurrentPlayerName
{
    NSString *fileName = [[NSString alloc] initWithString:@"currentPlayer.plist"];
    NSString *filePath = [FileOperation getAbsolutePathOfFile:fileName];
    NSMutableDictionary *currentPlayer = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSString *playerName = [currentPlayer objectForKey:@"currentPlayer"];
    
    return playerName;
}

@end
