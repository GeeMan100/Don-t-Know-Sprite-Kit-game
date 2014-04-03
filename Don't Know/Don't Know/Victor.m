//
//  EndScene.m
//  BreakingBricks
//
//  Created by Gurmit Singh on 2/19/14.
//  Copyright (c) 2014 Gurmit Singh. All rights reserved.
//

#import "Victor.h"
#import "DKMyScene.h"

@implementation Victor
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
        label.text = @"Congratulations.";
        label.fontColor = [SKColor whiteColor];
        label.fontSize = 44;
        label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:label];
        SKLabelNode *label2 = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
        label2.text = @"You stayed the distance.";
        label2.fontColor = [SKColor whiteColor];
        label2.fontSize = 25;
        label2.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-40);
        [self addChild:label2];
        _bannerIsNotVisible = NO;
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    SKScene *begin = [DKMyScene sceneWithSize:self.size];
    [self.view presentScene:begin transition:[SKTransition fadeWithDuration:0.5]];
}
@end
