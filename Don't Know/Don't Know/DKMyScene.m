//
//  DKMyScene.m
//  Don't Know
//  A paddle and ball type game
//  Created by Gurmit Singh on 03/04/2014.
//  Copyright (c) 2014 RuleOnSix. All rights reserved.
//
// TODO: add in a ball and two paddles
// TODO: put in physics for the ball
// TODO: use AI to control the top paddle
// TODO: put in iADS at the top for above the computer's side
// TODO: 
#import "DKMyScene.h"
SKSpriteNode *computer;
SKSpriteNode *player;
SKSpriteNode *ball;
CGRect screenRect;
@implementation DKMyScene
@synthesize myBannerView = _myBannerView;
@synthesize bannerIsNotVisible = _bannerIsNotVisible;
#pragma mark - my Methods
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    if (self.bannerIsNotVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, 0);
        [UIView commitAnimations];
        self.bannerIsNotVisible = NO;
    }
}
-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    if (!self.bannerIsNotVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, 0);
        [UIView commitAnimations];
        self.bannerIsNotVisible = YES;
    }


}

#pragma mark - end of my Method

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        
         screenRect= [[UIScreen mainScreen] bounds];
        _myBannerView.tag = 5;
       
        _myBannerView.frame = CGRectMake(0,30, self.frame.size.width, 70);
        _myBannerView = [[ADBannerView alloc]init];
         _myBannerView.delegate = self;
        _bannerIsNotVisible = NO;
        float sizeOfBanner = _myBannerView.frame.size.height;
        NSLog(@"sizeofbanner height %f", _myBannerView.frame.size.height);
        player   = [SKSpriteNode spriteNodeWithImageNamed:@"playerPaddle"];
        computer = [SKSpriteNode spriteNodeWithImageNamed:@"computerPaddle"];
        ball     = [SKSpriteNode spriteNodeWithImageNamed:@"greenBall"];
        
        player.position   = CGPointMake(screenRect.size.width/2, 50);
        ball.position     = CGPointMake(screenRect.size.width/2, screenRect.size.height  /2);
        computer.position = CGPointMake(screenRect.size.width/2, screenRect.size.height- (_myBannerView.frame.size.height + 50));
        NSLog(@"screenrect.size.height = %f", screenRect.size.height);
        //player.anchorPoint = CGPointMake(0,0);
        //computer.anchorPoint = CGPointMake(0,0);
        ball.xScale = 0.70;
        ball.yScale = 0.70;
        [self addChild:player];
        [self addChild:computer];
        [self addChild:ball];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        

    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
