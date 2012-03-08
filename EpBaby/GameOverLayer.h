//
//  GameOverLayer.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "StartMenuScene.h"
#import "GameScene.h"

@interface GameOverLayer : CCLayerColor {
    CCMenuItemImage *replayItem;
    CCMenuItemImage *goToMainMenuItem;
}

@property (nonatomic, retain) CCMenuItemImage *replayItem;
@property (nonatomic, retain) CCMenuItemImage *goToMainMenuItem;

-(id) initWithMyColor:(ccColor4B)color;
-(void) replay;
-(void) goToMainMenu;

@end
