//
//  StoryScene.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface StoryScene : CCScene {
    
}

@end

@interface StoryLayer : CCLayer {
    int pageNumber;
    CCSprite *sprite;
}

@property (nonatomic, readwrite) int pageNumber;
@property (nonatomic, retain) CCSprite *sprite;

@end
