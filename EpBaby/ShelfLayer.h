//
//  ShelfLayer.h
//  EpBaby
//
//  Created by Henry Tse on 12-2-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Baby.h"

@interface ShelfLayer : CCLayer {
    Baby *baby;
}

@property (nonatomic, retain) Baby *baby;

-(id) initWithNumber:(int)number andBaby:(Baby *)mybaby;
-(void) showGoods:(int) number; 

@end
