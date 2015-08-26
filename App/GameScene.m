//
//  GameScene.m
//  App
//
//  Created by Ma-Kun on 2015/04/21.
//  Copyright (c) 2015年 TEAM 2. All rights reserved.
//

#import "GameScene.h"
#import "GameViewController.h"
@implementation GameScene {
    
   
}

-(void)didMoveToView:(SKView *)view {
    SKLabelNode  *Title = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    SKLabelNode  *StartButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    StartButton.text = @"はじめる";
    StartButton.position = CGPointMake(self.frame.size.width /2, self.frame.size.height / 2 - 100);
    StartButton.fontColor = [SKColor whiteColor];
    Title.text = @"Title";
    Title.fontColor = [SKColor whiteColor];
    Title.fontSize = 50;
    Title.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 150);
    [self addChild:Title];
    [self addChild:StartButton];
    
    SKAction* fadein = [SKAction fadeInWithDuration:0.8];
    SKAction* fadeout = [SKAction fadeOutWithDuration:0.8];
    NSArray * actions = [NSArray arrayWithObjects:fadeout,fadein,nil];
    SKAction* fadeinout = [SKAction sequence:actions];
    [StartButton runAction:[SKAction repeatActionForever:fadeinout]];
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    GameScene *scene = [[GameScene alloc]initWithSize:self.size];
    SKTransition *transition = [SKTransition crossFadeWithDuration:2];
    [self.view presentScene:scene transition:transition];
    
}
-(void)update:(CFTimeInterval)currentTime {

}

@end
