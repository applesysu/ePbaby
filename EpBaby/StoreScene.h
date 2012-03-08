//
//  StoreScene.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCScrollLayer.h"
#import "Baby.h"

#define HStoreLayer 20001
#define HGoodScrollLayer 20002

@interface StoreScene : CCScene {
    Baby *baby;
}

@property (nonatomic, retain) Baby *baby;

-(void) retriveBabyInfo:(NSMutableString *)babyName;

@end

@interface StoreLayer : CCScrollLayer {
    
}

@end
