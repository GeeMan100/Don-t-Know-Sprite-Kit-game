//
//  DKMyScene.h
//  Don't Know
//

//  Copyright (c) 2014 RuleOnSix. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@import iAd;

@interface DKMyScene : SKScene <ADBannerViewDelegate, SKPhysicsContactDelegate>
@property (strong, nonatomic) ADBannerView *myBannerView;
@property (nonatomic) BOOL bannerIsNotVisible;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@end
