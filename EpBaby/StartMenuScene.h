//
//  StartMenuScene.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Baby.h"

@interface StartMenuScene : CCScene {
    
}

@end

@interface StartMenuLayer : CCLayer {
    CCMenu *feedMenu;
    CCMenu *shopMenu;
    CCMenu *quizMenu;
    CCMenu *gameMenu;
    CCSprite *line;
    
    BOOL menu;
    
    Baby *baby;
    CCLabelBMFont *assnumber;
    CCLabelBMFont *expnumber;
    
    CCMenuItemImage *star;
}

@property (nonatomic, retain) CCMenu *feedMenu;
@property (nonatomic, retain) CCMenu *shopMenu;
@property (nonatomic, retain) CCMenu *quizMenu;
@property (nonatomic, retain) CCMenu *gameMenu;
@property (nonatomic, retain) CCSprite *line;
@property (nonatomic, readwrite) BOOL menu;
@property (nonatomic, retain) Baby *baby;
@property (nonatomic, retain) CCLabelBMFont *assnumber;
@property (nonatomic, retain) CCLabelBMFont *expnumber;
@property (nonatomic, retain) CCMenuItemImage *star;

-(void) initTheMenu;
-(void) showMenu;
-(void) hideMenu;
-(void) startGame:(id) sender;
-(void) beginQ_A:(id) sender;
-(void) shopping:(id) sender;
-(void) feed: (id) sender;
-(void) menuControl;
-(void) toHome;

@end
