//
//  PauseLayer.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@interface PauseLayer : CCLayerColor {
    CCMenuItemImage *resumeItem;
    CCMenuItemImage *replayItem;
    CCMenuItemImage *homeItem;
}

@property (nonatomic, retain) CCMenuItemImage *resumeItem;
@property (nonatomic, retain) CCMenuItemImage *replayItem;
@property (nonatomic, retain) CCMenuItemImage *homeItem;

-(id) initWithMyColor:(ccColor4B)color;
-(void) gameResume;
-(void) gameRestart;
-(void) goHome;

@end
