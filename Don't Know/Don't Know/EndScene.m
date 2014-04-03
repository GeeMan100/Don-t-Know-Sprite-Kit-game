//
//  EndScene.m
//  BreakingBricks
//
//  Created by Gurmit Singh on 2/19/14.
//  Copyright (c) 2014 Gurmit Singh. All rights reserved.
//

#import "EndScene.h"
#import "DKMyScene.h"

@implementation EndScene
@synthesize myBannerView = _myBannerView;
@synthesize bannerIsNotVisible = _bannerIsNotVisible;
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    if (self.bannerIsNotVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame                     = CGRectOffset(banner.frame, 0, 0);
        [UIView commitAnimations];
        self.bannerIsNotVisible          = NO;
    }
}
-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    if (!self.bannerIsNotVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame                     = CGRectOffset(banner.frame, 0, 0);
        [UIView commitAnimations];
        self.bannerIsNotVisible          = YES;
    }
    
    
}
-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        label.text = @"GAME OVER";
        label.fontColor = [SKColor whiteColor];
        label.fontSize = 44;
        label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:label];
        _bannerIsNotVisible = NO;
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    SKScene *start = [DKMyScene sceneWithSize:self.size];
    [self.view presentScene:start transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
}
@end
