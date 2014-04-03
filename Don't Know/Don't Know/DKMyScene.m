//
//  DKMyScene.m
//  Don't Know
//  A paddle and ball type game
//  Created by Gurmit Singh on 03/04/2014.
//  Copyright (c) 2014 RuleOnSix. All rights reserved.
//

// TODO: use AI to control the top paddle

#import "DKMyScene.h"
#import "EndScene.h"
#import "Victor.h"
SKSpriteNode *computer;
SKSpriteNode *player;
SKSpriteNode *ball;
SKLabelNode *myLabelTime;
BOOL startMove;
int directionFrom;
int directionTo;
static int myTime;
int randX, randY;
int movement;
CGRect screenRect;
#pragma mark - imported
#define LED_PONG_CPU_THROTTLE   0.845f
static const uint32_t ballCategory       = 1; // 00000000000000000000000000000001
static const uint32_t computerCategory   = 2; // 00000000000000000000000000000010
static const uint32_t playerCategory     = 4; // 00000000000000000000000000000100
static const uint32_t edgeCategory       = 8; // 00000000000000000000000000001000
static const uint32_t bottomEdgeCategory = 16;
static const uint32_t topEdgeCategory    = 32;
#pragma mark - end import

@implementation DKMyScene
@synthesize myBannerView                 = _myBannerView;
@synthesize bannerIsNotVisible           = _bannerIsNotVisible;
#pragma mark - my Methods
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
- (void)addBall:(CGSize)size {
    // create a new sprite node from an image
    ball                                 = [SKSpriteNode spriteNodeWithImageNamed         :@"greenBall"];
    
    // create a CGPoint for position
    CGPoint myPoint                      = CGPointMake(size.width/2,size.height/2);
    ball.position                        = myPoint;
    
    // add a physics body
    ball.physicsBody                     = [SKPhysicsBody bodyWithCircleOfRadius:ball.frame.size.width/2];
    ball.physicsBody.friction            = 0;
    ball.physicsBody.linearDamping       = 0;
    ball.physicsBody.restitution         = 1.0f;
    ball.physicsBody.categoryBitMask     = ballCategory;
    ball.physicsBody.contactTestBitMask  = computerCategory | playerCategory | bottomEdgeCategory | topEdgeCategory;
   
  
    // ball.physicsBody.collisionBitMask = edgeCategory | brickCategory;
    ball.xScale                          = 0.70;
    ball.yScale                          = 0.70;
    
    // add the sprite node to the scene
    [self addChild:ball];
                                   randX = (arc4random() % 30) + 25;
                                   randY = (arc4random() % 30) + 25;
    // create the vector
    CGVector myVector                    = CGVectorMake(randX, randY);
    // apply the vector
    [ball.physicsBody applyImpulse:myVector];
}
-(void) addComputer:(CGSize)size  {
    
    // create paddle sprite
    computer                             = [SKSpriteNode spriteNodeWithImageNamed         :@"computerPaddle"];
    // position it
    computer.position                    = CGPointMake(screenRect.size.width/2, screenRect.size.height- 70);
    // add a physics body
    computer.physicsBody                 = [SKPhysicsBody bodyWithRectangleOfSize:computer.frame.size];
    // make it static
    computer.physicsBody.dynamic         = NO;
    computer.physicsBody.categoryBitMask = computerCategory;
    
    
    // add to scene
    [self addChild:computer];
}
-(void) addTopEdge:(CGSize) size {
    SKNode *topEdge                     = [SKNode node];
    topEdge.physicsBody                 = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, CGRectGetHeight(self.frame)) toPoint:CGPointMake(size.width, CGRectGetHeight(self.frame)-1)];
    topEdge.physicsBody.categoryBitMask = topEdgeCategory;
    [self addChild:topEdge];
    
}
-(void) addBottomEdge:(CGSize) size {
    SKNode *bottomEdge                     = [SKNode node];
    bottomEdge.physicsBody                 = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 1) toPoint:CGPointMake(size.width, 1)];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    [self addChild:bottomEdge];
    
}
-(void) addPlayer:(CGSize)size  {
    
    // create paddle sprite
    player                              = [SKSpriteNode spriteNodeWithImageNamed:@"playerPaddle"];
    // position it
    player.position                     = CGPointMake(size.width/2,50);
    // add a physics body
    player.physicsBody                  = [SKPhysicsBody bodyWithRectangleOfSize:player.frame.size];
    // make it static
    player.physicsBody.dynamic          = NO;
    player.physicsBody.categoryBitMask  = playerCategory;
    
    
    // add to scene
    [self addChild:player];
}
-(void)didBeginContact:(SKPhysicsContact *)contact {
    // create placeholder reference for the "non ball" object
    SKPhysicsBody *notTheBall;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        notTheBall = contact.bodyB;
    } else {
        notTheBall = contact.bodyA;
    }
    
    if (notTheBall.categoryBitMask == computerCategory) {
        //  SKAction *playSFX = [SKAction playSoundFileNamed:@"brickhit.caf" waitForCompletion:NO];
        // [self runAction:playSFX];
       // [notTheBall.node removeFromParent];
    }
    
    if (notTheBall.categoryBitMask == playerCategory) {
        // SKAction *playSFX = [SKAction playSoundFileNamed:@"blip.caf" waitForCompletion:NO];
        //  [self runAction:playSFX];
        
    }
    
    if (notTheBall.categoryBitMask == bottomEdgeCategory) {
        EndScene *end = [EndScene sceneWithSize:self.size];
        [self.view presentScene:end transition:[SKTransition flipVerticalWithDuration:0.5]];
        
    }
    if (notTheBall.categoryBitMask == topEdgeCategory) {
        EndScene *end = [EndScene sceneWithSize:self.size];
        [self.view presentScene:end transition:[SKTransition doorsCloseHorizontalWithDuration:0.5]];
        
    }
    
    
}
#pragma mark - end of my Method

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor            = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        myTime                          = 0;
        screenRect                      = [[UIScreen mainScreen] bounds];
        _myBannerView.tag               = 5;
        
        _myBannerView.frame             = CGRectMake(0,0, self.frame.size.width, 70);
        _myBannerView                   = [[ADBannerView alloc]init];
        _myBannerView.delegate          = self;
        _bannerIsNotVisible             = NO;
        
 
        [self addBall       :self.frame.size];
        [self addPlayer     :self.frame.size];
        [self addComputer   :self.frame.size];
        [self addBottomEdge:size];
        [self addTopEdge:size];
        
        self.physicsBody                 = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = edgeCategory;
        
        
        // change gravity settings of the physics world
        self.physicsWorld.gravity         = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        myLabelTime = [[SKLabelNode alloc]initWithFontNamed:@"Helvetica"];
        myLabelTime.name = @"NewGame";
        //myLabelTime.text = @"New Game";
        myLabelTime.fontSize = 25;
        myLabelTime.fontColor = [SKColor redColor];
        myLabelTime.position = CGPointMake(screenRect.size.width - 50, screenRect.size.height - 100);
        [self addChild:myLabelTime];
        
    }
    return self;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location                = [touch locationInNode:self];
        CGPoint newPosition             = CGPointMake(location.x, 50);
        
        // stop the paddle from going too far
        if (newPosition.x               < player.size.width / 2) {
            newPosition.x               = player.size.width / 2;
            
        }
        if (newPosition.x               > self.size.width - (player.size.width/2)) {
            newPosition.x               = self.size.width - (player.size.width/2);
            
        }
        
        player.position                 = newPosition;
    }
    
    
    
}
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 1) {
        self.lastSpawnTimeInterval = 0;
        myTime += 1;
        //[self addMonster];
        myLabelTime.text =  [NSString stringWithFormat:@"%d",myTime];
    }
    if (myTime == 10) {
        player.xScale = 0.75;
    }
    if (myTime == 19) {
        player.xScale = 0.7;
    }
    if (myTime == 32) {
        player.xScale = 0.6;
    }
    if (myTime == 90) {
        
        SKScene *victory = [Victor sceneWithSize:self.size];
        [self.view presentScene:victory transition:[SKTransition doorsCloseHorizontalWithDuration:0.4]];
    }
  
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    computer.position = CGPointMake(ball.position.x * LED_PONG_CPU_THROTTLE, screenRect.size.height- 70);
}

@end
