//
//  StoreScene.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "StoreScene.h"
#import "ShelfLayer.h"


@implementation StoreScene

@synthesize baby;

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        self.baby = [[Baby alloc] init];
        NSMutableString *babyName = [[NSMutableString alloc] initWithString:[Baby getCurrentPlayerName]];
        NSLog(@"this is in the store secne. and the file of the baby is %@", babyName);
        [babyName appendString:@".plist"];
        NSLog(@"this is in the store secne.  after and the file of the baby is %@", babyName);
        [self retriveBabyInfo:babyName];
        
        NSLog(@"%@, %d, %ld, %ld, %d", self.baby.name, self.baby.babyType, self.baby.assets, self.baby.experience ,self.baby.moveSpeed);
        
        NSLog(@"this is in the store secne. and the name of the baby is %@", babyName);
        
        ShelfLayer *layer1 = [[ShelfLayer alloc] initWithNumber:1 andBaby:self.baby];
        ShelfLayer *layer2 = [[ShelfLayer alloc] initWithNumber:2 andBaby:self.baby];
        ShelfLayer *layer3 = [[ShelfLayer alloc] initWithNumber:3 andBaby:self.baby];
        NSArray *layers = [[NSArray alloc] initWithObjects:layer1, layer2, layer3, nil];
        StoreLayer *storeLayer = [[StoreLayer alloc] initWithLayers:layers widthOffset:0];
        [storeLayer moveToPage:1];
        
        
        [self addChild:storeLayer z:0 tag:HStoreLayer];
    }
    
    return self;
}


-(void) retriveBabyInfo:(NSMutableString *)babyName
{
    [self.baby retriveBabyInfo:babyName];
}

@end

@implementation StoreLayer

-(id) initWithLayers:(NSArray *)layers widthOffset:(int)widthOffset
{
    self = [super initWithLayers:layers widthOffset:widthOffset];
    
    if (self != nil)
    {
        
    }
    
    return self;
}

@end
