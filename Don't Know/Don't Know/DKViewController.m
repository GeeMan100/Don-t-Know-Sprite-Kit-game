//
//  DKViewController.m
//  Don't Know
//
//  Created by Gurmit Singh on 03/04/2014.
//  Copyright (c) 2014 RuleOnSix. All rights reserved.
//

#import "DKViewController.h"
#import "DKMyScene.h"

@implementation DKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    //skView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60);
    // Create and configure the scene.
    SKScene * scene = [DKMyScene sceneWithSize:skView.bounds.size];
    NSLog(@"skview.bounds.size = %g", skView.bounds.size.height);
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
