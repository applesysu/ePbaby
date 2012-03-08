//
//  TestScene.m
//  EpBaby
//
//  Created by Henry Tse on 12-2-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestScene.h"
#import "StartMenuScene.h"
#import "GameOrStoryScene.h"

#define HTestLayer 11001

@implementation TestScene

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [self addChild:[TestLayer node] z:0 tag:HTestLayer];
    }
    
    return self;
}

-(void) dealloc
{
    [super dealloc];
}

@end

@implementation TestLayer

@synthesize baby, curAnswer, problemDesc, problems, babyImage, problemIndex;

-(NSString *)getBabyImageName:(int)babyType
{
    NSString *valueString;
    
    switch (babyType) {
        case 1:
            valueString = @"blue1-120.png";
            break;
        case 2:
            valueString = @"green1-120.png";
            break;
        case 3:
            valueString = @"grey1-120.png";
            break;
        case 4:
            valueString = @"yellow1-120.png";
    }
    
    return valueString;
}

-(NSString *)getBabyCry:(int)babyType
{
    NSString *valueString;
    
    switch (babyType) {
        case 1:
            valueString = @"blue2-120.png";
            break;
            
        case 2:
            valueString = @"green2-120.png";
            break;
            
        case 3:
            valueString = @"grey2-120.png";
            break;
        
        case 4:
            valueString = @"yellow2-120.png";
            break;
    }
    
    return valueString;
}

-(void) selectYES
{
    NSLog(@"i choose yes");
    if(self.curAnswer != YES)
    {
        [self.babyImage setTexture:[[CCTextureCache sharedTextureCache] addImage:[self getBabyCry:self.baby.babyType]]];
    }
    else
    {
        [self.babyImage setTexture:[[CCTextureCache sharedTextureCache] addImage:[self getBabyImageName:self.baby.babyType]]];
    }
    
    self.problemIndex++;
    
    if (self.problemIndex < 20)
    {
        [self.problemDesc setString:[[self.problems objectAtIndex:self.problemIndex] problemDesc]];
        self.curAnswer = [[self.problems objectAtIndex:self.problemIndex] correctAnswer];
    }
    
}

-(void) selectNO
{
    NSLog(@"i choose no");
    if (self.curAnswer != NO)
    {
        [self.babyImage setTexture:[[CCTextureCache sharedTextureCache] addImage:[self getBabyCry:self.baby.babyType]]];
    }
    else
    {
        [self.babyImage setTexture:[[CCTextureCache sharedTextureCache] addImage:[self getBabyImageName:self.baby.babyType]]];
    }
    
    self.problemIndex++;
    
    if (self.problemIndex < 20)
    {
        [self.problemDesc setString:[[self.problems objectAtIndex:self.problemIndex] problemDesc]];
        self.curAnswer = [[self.problems objectAtIndex:self.problemIndex] correctAnswer];
    }
    
}

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [GameOrStoryLayer playBgMusic:@"bg3.mp3"];
        
        [self initTheProblem];
        
        self.baby = [[Baby alloc] init];
        NSMutableString *babyName = [[NSMutableString alloc] initWithString:[Baby getCurrentPlayerName]];
        NSLog(@"this is in the test secne. and the file of the baby is %@", babyName);
        [babyName appendString:@".plist"];
        NSLog(@"this is in the test secne.  after and the file of the baby is %@", babyName);
        [self retriveBabyInfo:babyName];
        
        NSLog(@"%@, %d, %ld, %ld, %d", self.baby.name, self.baby.babyType, self.baby.assets, self.baby.experience ,self.baby.moveSpeed);
        
        NSLog(@"this is in the test secne. and the name of the baby is %@", babyName);
        
        CCSprite *backGround = [CCSprite spriteWithFile:@"quizBG.jpg"];
        [backGround setPosition:ccp(240, 160)];
        [self addChild:backGround];
        
        babyImage = [CCSprite spriteWithFile:[self getBabyImageName:self.baby.babyType]];
        [babyImage setPosition:ccp(190, 100)];
        [self addChild:babyImage];
        
        CCMenuItemImage *toHome = [CCMenuItemImage itemFromNormalImage:@"back-brown.png" selectedImage:@"back-orange.png" target:self selector:@selector(toHome)];
        CCMenu *homeMenu = [CCMenu menuWithItems:toHome, nil];
        [homeMenu setPosition:ccp(20, 300)];
        [self addChild:homeMenu];
        
        CCMenuItemImage *yesItem = [CCMenuItemImage itemFromNormalImage:@"yes.png" selectedImage:@"yes.png" target:self selector:@selector(selectYES)];
        CCMenu *yesMenu = [CCMenu menuWithItems:yesItem, nil];
        [yesMenu setPosition:ccp(380,150)];
        [self addChild:yesMenu];
        
        CCMenuItemImage *noItem = [CCMenuItemImage itemFromNormalImage:@"no.png" selectedImage:@"no.png" target:self selector:@selector(selectNO)];
        CCMenu *noMenu = [CCMenu menuWithItems:noItem, nil];
        [noMenu setPosition:ccp(380,100)];
        [self addChild:noMenu];
        
        self.problemIndex = 0;
        
        self.problemDesc = [CCLabelTTF labelWithString:[[self.problems objectAtIndex:0] problemDesc] fontName:@"AppleGothic" fontSize:10];
        [self.problemDesc setColor:ccRED];
        [self.problemDesc setPosition:ccp(370, 250)];
        [self addChild:self.problemDesc];
        self.curAnswer = [[self.problems objectAtIndex:self.problemIndex] correctAnswer];
    }
    
    return self;
}

-(void) retriveBabyInfo:(NSMutableString *)babyName
{
    [self.baby retriveBabyInfo:babyName];
}

-(void) saveBabyData
{
    NSMutableString *fileName = [[NSMutableString alloc] initWithString:[Baby getCurrentPlayerName]];
    [fileName appendString:@".plist"];
    [self.baby persistBabyInfo:fileName];
}

-(void) toHome
{
    [GameOrStoryLayer playBgMusic:@"bg1.mp3"];
    
    self.baby.experience += 15;
    self.baby.assets += 100;
    
    [self saveBabyData];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:[StartMenuScene node]]];
}

-(void) initTheProblem
{
    problems = [[NSMutableArray alloc] init];
    Problem *problem1 = [[Problem alloc] initWithProblemDesc:@"可回收垃圾主要包括废纸、塑料" theCorrectAnswer:NO theProblemID:1];
    [problems addObject:problem1];
    Problem *problem2 = [[Problem alloc] initWithProblemDesc:@"过期药品属于有害垃圾。" theCorrectAnswer:YES theProblemID:2];
    [problems addObject:problem2];
    Problem *problem3 = [[Problem alloc] initWithProblemDesc:@"厨余垃圾应做到袋装、密闭投放。" theCorrectAnswer:YES theProblemID:3];
    [problems addObject:problem3];
    Problem *problem4 = [[Problem alloc] initWithProblemDesc:@"花生壳属于厨房垃圾。" theCorrectAnswer:YES theProblemID:4];
    [problems addObject:problem4];
    Problem *problem5 = [[Problem alloc] initWithProblemDesc:@"每年6月5日是世界环境日。" theCorrectAnswer:YES theProblemID:5];
    [problems addObject:problem5];
    Problem *problem6 = [[Problem alloc] initWithProblemDesc:@"电池属于有毒垃圾。" theCorrectAnswer:YES theProblemID:6];
    [problems addObject:problem6];
    Problem *problem7 = [[Problem alloc] initWithProblemDesc:@"上街购物最好自备环保购物袋。" theCorrectAnswer:YES theProblemID:7];
    [problems addObject:problem7];
    Problem *problem8 = [[Problem alloc] initWithProblemDesc:@"塑料做的纽扣，是可回收物" theCorrectAnswer:YES theProblemID:8];
    [problems addObject:problem8];
    Problem *problem9 = [[Problem alloc] initWithProblemDesc:@"多种植绿色植物，有益于环保。" theCorrectAnswer:YES theProblemID:9];
    [problems addObject:problem9];
    Problem *problem10 = [[Problem alloc] initWithProblemDesc:@"多使用电子书刊比用印刷书刊更加环保。" theCorrectAnswer:YES theProblemID:10];
    [problems addObject:problem10];
    
    Problem *problem11 = [[Problem alloc] initWithProblemDesc:@"餐厨垃圾可装袋扔进桶 " theCorrectAnswer:NO theProblemID:11];
    [problems addObject:problem11];
    Problem *problem12 = [[Problem alloc] initWithProblemDesc:@"所有垃圾都没必要回收使用。" theCorrectAnswer:NO theProblemID:12];
    [problems addObject:problem12];
    Problem *problem13 = [[Problem alloc] initWithProblemDesc:@"温室效应可以帮助我们取暖，是好的现象。" theCorrectAnswer:NO theProblemID:13];
    [problems addObject:problem13];
    Problem *problem14 = [[Problem alloc] initWithProblemDesc:@"包装纸属于有毒垃圾。" theCorrectAnswer:NO theProblemID:14];
    [problems addObject:problem14];
    Problem *problem15 = [[Problem alloc] initWithProblemDesc:@"“水的富营养化”有利于鱼儿生长。" theCorrectAnswer:NO theProblemID:15];
    [problems addObject:problem15];
    Problem *problem16 = [[Problem alloc] initWithProblemDesc:@"夏天空调开得越冷越好。" theCorrectAnswer:NO theProblemID:16];
    [problems addObject:problem16];
    Problem *problem17 = [[Problem alloc] initWithProblemDesc:@"多使用含磷洗涤剂。" theCorrectAnswer:NO theProblemID:17];
    [problems addObject:problem17];
    Problem *problem18 = [[Problem alloc] initWithProblemDesc:@"吸烟虽然有害健康，但不影响环境。" theCorrectAnswer:NO theProblemID:18];
    [problems addObject:problem18];
    Problem *problem19 = [[Problem alloc] initWithProblemDesc:@"节日来临时多买贺卡互相祝福。" theCorrectAnswer:NO theProblemID:19];
    [problems addObject:problem19];
    Problem *problem20 = [[Problem alloc] initWithProblemDesc:@"花生壳算其他垃圾 " theCorrectAnswer:NO theProblemID:20];
    [problems addObject:problem20];
    
}

@end

//01.可回收垃圾主要包括废纸、塑料、玻璃、金属和布料五大类。 yes
//02.纸巾和厕所纸由于水溶性太强不可回收。 yes
//03.过期药品属于有害垃圾。 yes
//04.卫生间废纸、纸巾等难以回收的废弃物，可采取卫生填埋。yes
//05.可以利用易拉罐制作笔盒，既环保，又节约资源。yes
//06.纸类应尽量叠放整齐，避免揉团
//07.瓶罐类物品应尽可能将容器内产品用尽后，清理干净后投放；
//08.厨余垃圾应做到袋装、密闭投放。
//09.玻璃类物品应小心轻放，以免破损。
//10.收集垃圾时，应做到密闭收集，分类收集，防止二次污染环境
//11.厨余垃圾：采取就地处理或集中堆肥。
//12.生物垃圾就是剩饭生菜，蛋壳果皮，菜帮菜叶一类的厨房垃圾 。
//13.生物垃圾可以用来制造很好的有机肥料。
//14.废电池里含有多种有用的金属矿才，回收利用的价值很高。
//15.大棒骨因为“难腐蚀”被列入“其它垃圾”。
//16.花生壳属于厨房垃圾。
//17.餐厨垃圾倒入垃圾桶，塑料袋另扔进“可回收垃圾”桶，这是正确做法。
//18.塑料做的纽扣，是可回收物
//19.尘土算其他垃圾
//20.通过综合处理回收利用，可以减少污染，节省资源。
//21.造纸的原料很多都来自于植物，会导致对生态平衡的破坏。
//22.有些包装纸，可以做成手工艺品，美化生活。
//23.可以把用过的但相对比较干净的水冲马桶、擦地板或者浇花。 
//24.尽量节约用纸，无论是手纸还是餐巾纸，能用手帕代替的就用手帕代替。 
//25.没人或没必要的时候，不开灯、不使用空调。
//26.多种植绿色植物，有益于环保。
//27.少量的衣服用手洗，避免洗衣机洗时使用大量的水。
//28.电池属于有毒垃圾。
//29.每年6月5日是世界环境日。
//30.臭氧层可以吸收大部分紫外线，保护地球生物。
//31.洗米的水可以用来洗白衬衫，使衬衫更白。
//32.空调适宜温度设定在24~28摄氏度之间。
//33.上街购物最好自备环保购物袋。
//34.在外用餐最好自备环保筷子。
//35.电池烂在地里，可使一平方米的土壤永久失去利用价值。
//36.多使用电子书刊比用印刷书刊更加环保。
//37.胶水、修正液是含苯的溶剂，对环境造成污染。
//
//
//
//
//NO.
//01.大棒骨是餐厨垃圾 
//02.餐厨垃圾可装袋扔进桶 
//03.花生壳算其他垃圾 
//04.速冻饺子、豆腐包装盒，都是厨房里产生的垃圾，所以是厨房垃圾
//05.尽量多使用一次性碗筷。
//06.废旧电池一直放在家里，对人体健康没影响。
//07.冲马桶的水要用纯净的自来水。
//08.练习册用了一面就要扔，不可循环使用。
//09.没必要讲究垃圾分类，反正有清洁工人会帮忙。
//10.尽可能多使用一次性塑料袋，因为塑料袋干净。
//11.用浴缸洗澡比淋浴洗澡更加环保。
//12.塑料袋易于分解，可随便乱扔。
//13.使用私家车比使用公共交通工具更加环保。
//14.骑自行车是不环保的交通方式。
//15.衣服多或少，都应该用洗衣机来洗。
//16.绿色植物很多，没必要珍惜和保护。
//17.所有垃圾都没有价值。
//18.所有垃圾都没必要回收使用。
//19.剩饭剩菜属于可回收垃圾。
//20.包装纸属于有毒垃圾。
//21.地球的水资源很多，一点儿也不宝贵。
//22.噪声不属于环境污染。
//23.温室效应可以帮助我们取暖，是好的现象。
//24.“白色污染”指的是冬天下雪。
//25.“水的富营养化”有利于鱼儿生长。
//26.臭氧层是污染地球的臭气，应尽可能破坏它。
//27.看完电视后，关了遥控器就不会再耗电了。
//28.吸烟虽然有害健康，但不影响环境。
//29.用洗衣粉来洗衣服比用肥皂洗衣服更加环保。
//30.洗米的水不可用来洗衣服。
//31.夏天空调开得越冷越好。
//32.多使用一次性筷子，用完就扔。
//33.多使用含磷洗涤剂。
//34.多穿野兽毛皮制成的服装，用于冬天最保暖。
//35.充电完成后无需立刻拔掉充电器。
//36.节日来临时多买贺卡互相祝福。
//37.胶水、修正液比回形针、订书钉更加环保。
