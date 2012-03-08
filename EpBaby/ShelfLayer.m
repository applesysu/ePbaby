//
//  ShelfLayer.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShelfLayer.h"
#import "StartMenuScene.h"


@implementation ShelfLayer

@synthesize baby;

-(id)initWithNumber:(int)number andBaby:(Baby *)mybaby
{
    self = [super init];
    
    if (self != nil)
    {
        CCSprite *backGround = [CCSprite spriteWithFile:@"storePage.jpg"];
        [self addChild:backGround];
        [backGround setPosition:ccp(240, 160)];
        
        self.baby = mybaby;
        
        [self showGoods:number];
    }
    
    return self;
}

-(void) notBuy
{
    [self removeChildByTag:501 cleanup:YES];
    [self removeChildByTag:502 cleanup:YES];
    [self removeChildByTag:503 cleanup:YES];
}

-(void) buyIt
{
    [self removeChildByTag:501 cleanup:YES];
    [self removeChildByTag:502 cleanup:YES];
    [self removeChildByTag:503 cleanup:YES];
}

-(void) confirmToBuy
{
    CCSprite *tips = [CCSprite spriteWithFile:@"sure.png"];
    [tips setPosition:ccp(240, 160)];
    [self addChild:tips z:3 tag:501];
    
    CCMenuItemImage *admit = [CCMenuItemImage itemFromNormalImage:@"admitn.png" selectedImage:@"admit.png" target:self selector:@selector(buyIt)];
    CCMenu *admitMenu = [CCMenu menuWithItems:admit, nil];
    [admitMenu setPosition:ccp(200, 130)];
    [self addChild:admitMenu z:4 tag:502];
    
    CCMenuItemImage *refuse = [CCMenuItemImage itemFromNormalImage:@"refusen.png" selectedImage:@"refuse.png" target:self selector:@selector(notBuy)];
    CCMenu *refuseMenu = [CCMenu menuWithItems:refuse, nil];
    [refuseMenu setPosition:ccp(280,130)];
    [self addChild:refuseMenu z:4 tag:503];
    
    
}

-(void) dismiss
{
    [self removeChildByTag:100 cleanup:YES];
}

-(void) canNotAfford
{
    CCMenuItemImage *notafford = [CCMenuItemImage itemFromNormalImage:@"notafford.png" selectedImage:@"notafford.png" target:self selector:@selector(dismiss)];
    CCMenu *menu = [CCMenu menuWithItems:notafford, nil];
    [menu setPosition:ccp(240, 160)];
    [self addChild:menu z:1 tag:100];
}

-(void) purchaseMilk
{
    
    if(self.baby.assets < 80)
    {
        [self canNotAfford];
    }
    
    [self confirmToBuy];
    [self.baby.purchaseTools addObject:@"milk"];
}

-(void) purchaseCandy
{
    if (self.baby.assets < 80)
    {
        [self canNotAfford];
    }
    
    [self confirmToBuy];
    [self.baby.purchaseTools addObject:@"candy"];
}

-(void) purchaseBall
{
    if (self.baby.assets)
    {
        [self canNotAfford];
    }
    
    [self confirmToBuy];
    [self.baby.purchaseTools addObject:@"ball"];
}

-(void) purchaseTrojan
{
    if (self.baby.assets < 250)
    {
        [self canNotAfford];
    }
    
    [self confirmToBuy];
    [self.baby.purchaseTools addObject:@"trojan"];
}

-(void) purchaseLamp
{
    if (self.baby.assets < 120)
    {
        [self canNotAfford];
    }
    
    [self confirmToBuy];
    [self.baby.purchaseTools addObject:@"lamp"];
}

-(void) purchaseClock
{
    if (self.baby.assets < 60)
    {
        [self canNotAfford];
    }
    
    [self confirmToBuy];
    [self.baby.purchaseTools addObject:@"clock"];
}

-(void) purchaseWall1
{
    if (self.baby.assets < 85)
    {
        [self canNotAfford];
    }
    
    [self confirmToBuy];
    [self.baby.purchaseTools addObject:@"wall1"]; 
}

-(void) purchaseWall2
{
    if (self.baby.assets < 90)
    {
        [self canNotAfford];
    }
    
    [self confirmToBuy];
    [self.baby.purchaseTools addObject:@"wall2"];
}

-(void) purchaseWall3
{
    if (self.baby.assets < 90)
    {
        [self canNotAfford];
    }
    
    [self confirmToBuy];
    [self.baby.purchaseTools addObject:@"wall3"];
}

-(void) goHome
{
    NSMutableString *fileName = [[NSMutableString alloc] initWithString:self.baby.name];
    [fileName appendString:@".plist"];
    [self.baby persistBabyInfo:fileName];
    [[CCDirector sharedDirector] replaceScene:[StartMenuScene node]];
}

-(void) showGoods:(int) number
{
    CCMenuItemImage *leaveShop = [CCMenuItemImage itemFromNormalImage:@"back-brown.png" selectedImage:@"back-orange.png" target:self selector:@selector(goHome)];
    CCMenu *leaveShopMenu = [CCMenu menuWithItems:leaveShop, nil];
    [leaveShopMenu setPosition:ccp(20, 300)];
    [self addChild:leaveShopMenu];    
    
    if (number == 1)
    {
        CCSprite *milk = [CCSprite spriteWithFile:@"milk.png"];
        [milk setPosition:ccp(210, 240)];
        [self addChild:milk];
        
        CCMenuItemImage *buymilk = [CCMenuItemImage itemFromNormalImage:@"buybutton.png" selectedImage:@"buybutton.png" target:self selector:@selector(purchaseMilk)];
        CCMenu *buymilkMenu = [CCMenu menuWithItems:buymilk, nil];
        [buymilkMenu setPosition:ccp(320, 240)];
        [self addChild:buymilkMenu];
        
        CCSprite *candy = [CCSprite spriteWithFile:@"candy.png"];
        [candy setPosition:ccp(200, 160)];
        [self addChild:candy];
        
        CCMenuItemImage *buycandy = [CCMenuItemImage itemFromNormalImage:@"buybutton.png" selectedImage:@"buybutton.png" target:self selector:@selector(purchaseCandy)];
        CCMenu *buycandyMenu = [CCMenu menuWithItems:buycandy, nil];
        [buycandyMenu setPosition:ccp(320, 160)];
        [self addChild:buycandyMenu];
        
        CCSprite *ball = [CCSprite spriteWithFile:@"ball.png"];
        [ball setPosition:ccp(210, 75)];
        [self addChild:ball];
        
        CCMenuItemImage *buyball = [CCMenuItemImage itemFromNormalImage:@"buybutton.png" selectedImage:@"buybutton.png" target:self selector:@selector(purchaseBall)];
        CCMenu *buyballMenu = [CCMenu menuWithItems:buyball, nil];
        [buyballMenu setPosition:ccp(320, 75)];
        [self addChild:buyballMenu];
        
    }
    else if (number == 2)
    {
        CCSprite *trojan = [CCSprite spriteWithFile:@"trojan.png"];
        [trojan setPosition:ccp(210, 240)];
        [self addChild:trojan];
        
        CCMenuItemImage *buytrojan = [CCMenuItemImage itemFromNormalImage:@"buybutton.png" selectedImage:@"buybutton.png" target:self selector:@selector(purchaseTrojan)];
        CCMenu *buytrojanMenu = [CCMenu menuWithItems:buytrojan, nil];
        [buytrojanMenu setPosition:ccp(320, 240)];
        [self addChild:buytrojanMenu];
        
        CCSprite *lamp = [CCSprite spriteWithFile:@"lamp.png"];
        [lamp setPosition:ccp(210, 160)];
        [self addChild:lamp];
        
        CCMenuItemImage *buylamp = [CCMenuItemImage itemFromNormalImage:@"buybutton.png" selectedImage:@"buybutton.png" target:self selector:@selector(purchaseLamp)];
        CCMenu *buylampMenu = [CCMenu menuWithItems:buylamp, nil];
        [buylampMenu setPosition:ccp(320, 160)];
        [self addChild:buylampMenu];
        
        CCSprite *clock = [CCSprite spriteWithFile:@"clock.png"];
        [clock setPosition:ccp(210, 75)];
        [self addChild:clock];
        
        CCMenuItemImage *buyclock = [CCMenuItemImage itemFromNormalImage:@"buybutton.png" selectedImage:@"buybutton.png" target:self selector:@selector(purchaseClock)];
        CCMenu *buyclockMenu = [CCMenu menuWithItems:buyclock, nil];
        [buyclockMenu setPosition:ccp(320, 75)];
        [self addChild:buyclockMenu];
    }
    else
    {
        CCSprite *wall1 = [CCSprite spriteWithFile:@"wallpaper.png"];
        [wall1 setPosition:ccp(210, 240)];
        [self addChild:wall1];
        
        CCMenuItemImage *buywall1 = [CCMenuItemImage itemFromNormalImage:@"buybutton.png" selectedImage:@"buybutton.png" target:self selector:@selector(purchaseWall1)];
        CCMenu *buywall1Menu = [CCMenu menuWithItems:buywall1, nil];
        [buywall1Menu setPosition:ccp(320, 240)];
        [self addChild:buywall1Menu];
        
        CCSprite *wall2 = [CCSprite spriteWithFile:@"wallpaper2.png"];
        [wall2 setPosition:ccp(210, 160)];
        [self addChild:wall2];
        
        CCMenuItemImage *buywall2 = [CCMenuItemImage itemFromNormalImage:@"buybutton.png" selectedImage:@"buybutton.png" target:self selector:@selector(purchaseWall2)];
        CCMenu *buywall2Menu = [CCMenu menuWithItems:buywall2, nil];
        [buywall2Menu setPosition:ccp(320, 160)];
        [self addChild:buywall2Menu];
        
        CCSprite *wall3 = [CCSprite spriteWithFile:@"wallpaper3.png"];
        [wall3 setPosition:ccp(210, 75)];
        [self addChild:wall3];
        
        CCMenuItemImage *buywall3 = [CCMenuItemImage itemFromNormalImage:@"buybutton.png" selectedImage:@"buybutton.png" target:self selector:@selector(purchaseWall3)];
        CCMenu *buywall3Menu = [CCMenu menuWithItems:buywall3, nil];
        [buywall3Menu setPosition:ccp(320, 75)];
        [self addChild:buywall3Menu];
    }
}


@end
