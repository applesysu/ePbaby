//
//  GameOrStoryScene.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface GameOrStoryScene : CCScene {
    
}

@end


@interface GameOrStoryLayer : CCLayer {
    
}

-(void) GameMode;
-(void) StoryMode;
-(void) moreInfo;

+(void)loadBgMusic;
+(void)playBgMusic:(NSString*)fileName;
+(void)pauseBgMusic;
+(void)resumeBgMusic;
+(void)stopBgMusic;

@end