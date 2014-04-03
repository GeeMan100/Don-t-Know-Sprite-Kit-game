//
//  EndScene.h
//  BreakingBricks
//
//  Created by Gurmit Singh on 2/19/14.
//  Copyright (c) 2014 Gurmit Singh. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@import iAd;
@interface EndScene : SKScene<ADBannerViewDelegate>
@property (strong, nonatomic) ADBannerView *myBannerView;
@property (nonatomic) BOOL bannerIsNotVisible;

@end
