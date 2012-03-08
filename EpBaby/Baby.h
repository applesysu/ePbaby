//
//  Baby.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Baby : CCSprite {
    NSString *name;
    int babyType;
    long assets;
    long experience;
    int moveSpeed;
    
    NSMutableArray *purchaseTools;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, readwrite) int babyType;
@property (nonatomic, readwrite) long assets;
@property (nonatomic, readwrite) long experience;
@property (nonatomic, readwrite) int moveSpeed;
@property (nonatomic, retain) NSMutableArray *purchaseTools;

-(id) initWithImage:(NSString *)image theName:(NSString *)babyName theType:(int)type;
-(CGRect) getSpriteRect;
-(void) retriveBabyInfo:(NSString *)fileName;
-(BOOL) persistBabyInfo:(NSString *)fileName;
-(void) persistCurrentPlayerName;

+(NSString *) getCurrentPlayerName;

@end
