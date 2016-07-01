//
//  GameScene.m
//  Space Invaders
//
//  Created by Yevgen on 12/29/15.
//  Copyright (c) 2015 IDAP. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

#import "GameScene.h"

@interface GameScene ()
@property (nonatomic, strong)   SKSpriteNode        *startButton;
@property (nonatomic, strong)   SKSpriteNode        *spaceShip;

@property (nonatomic, strong)   CMMotionManager     *motionManager;

@property (nonatomic, assign)   CGFloat             accelerationX;

@property (nonatomic, strong)   SKSpriteNode        *background1;
@property (nonatomic, strong)   SKSpriteNode        *background2;

@end

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    
    if (self) {
        [self setupMotionManager];
        [self setupMenu];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    }
    
    return self;
}

- (void)setupMenu {
    self.backgroundColor = [UIColor colorWithRed:20.0/255 green:25.0/255 blue:60.0/255 alpha:1.0];
    
    [self setupStartButton];
}

- (void)setupStartButton {
    SKSpriteNode *startButton = [SKSpriteNode spriteNodeWithImageNamed:@"button_play1.png"];
    
    startButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    startButton.name = @"startButton";
    [startButton setScale:0.08];
    
    [self addChild:startButton];
    self.startButton = startButton;
}

- (void)setupSpaceShip {
    SKSpriteNode *spaceShip = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship2.png"];
    
    [spaceShip setScale:0.5];
    spaceShip.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.1);
    
    spaceShip.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spaceShip.frame.size];
    spaceShip.physicsBody.dynamic = YES;
    spaceShip.physicsBody.affectedByGravity = NO;
    spaceShip.physicsBody.mass = 0.02;
    
    [self addChild:spaceShip];
    self.spaceShip = spaceShip;
}

- (void)setupMotionManager
{
    CMMotionManager *motionManager = [CMMotionManager new];
    
    motionManager.accelerometerUpdateInterval = 0.012;
    
    //    if ([motionManager isAccelerometerAvailable] == YES) {
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                            self.spaceShip.physicsBody.velocity = CGVectorMake(0.0, 0.0);
                                            
                                            self.accelerationX = accelerometerData.acceleration.x;
                                            
//                                            [self.spaceShip.physicsBody applyImpulse:CGVectorMake(0, 0)];
                                            
                                            if (accelerometerData.acceleration.x > 0.0012) {
                                                //                                                    [self.spaceShip.physicsBody applyImpulse:CGVectorMake(0.1, 0)];
                                            }
                                            
                                            if (accelerometerData.acceleration.x < -0.0012) {
                                                //                                                    [self.spaceShip.physicsBody applyImpulse:CGVectorMake(-0.1, 0)];
                                            }
                                        }];
    //    }
    
    self.motionManager = motionManager;
}

- (void)setupBackground {
    NSString *backgroundImageName = @"Space.jpg";
    UIImage *backgroundImage = [UIImage imageNamed:backgroundImageName];
    
    SKSpriteNode *background1 = [SKSpriteNode spriteNodeWithImageNamed:backgroundImageName];
    SKSpriteNode *background2 = [SKSpriteNode spriteNodeWithImageNamed:backgroundImageName];
    
    CGFloat ratio = self.frame.size.width / backgroundImage.size.width;
    
    background1.size = CGSizeMake(backgroundImage.size.width * ratio, backgroundImage.size.height * ratio);
    
    background1.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background1];
    
    background2.size = background1.size;
    background2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + background1.size.height);
    
    [self addChild:background2];
    
    self.background1 = background1;
    self.background2 = background2;
}

- (void)setupBarriers {
    SKSpriteNode *asteroid = [SKSpriteNode spriteNodeWithImageNamed:@"asteroid.png"];
    [asteroid setScale:2];
    asteroid.position = CGPointMake(0, 50);
    asteroid.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:asteroid.size];
    asteroid.physicsBody.dynamic = NO;
    [self addChild:asteroid];
}

-(void)didMoveToView:(SKView *)view {
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if (node == self.startButton) {
        [self startGame];
    }
}

- (void)startGame {
    self.startButton.hidden = YES;
    
    [self setupBackground];
    [self setupSpaceShip];
}

- (void)update:(CFTimeInterval)currentTime {
    SKSpriteNode *background1 = self.background1;
    SKSpriteNode *background2 = self.background2;
    
    background1.position = CGPointMake(background1.position.x, background1.position.y - 1);
    background2.position = CGPointMake(background2.position.x, background2.position.y - 1);
    
    if (background1.position.y < CGRectGetMidY(self.frame) - background1.size.height){
        background1.position = CGPointMake(background1.position.x, background2.position.y + background2.size.height);
    }
    
    if (background2.position.y < CGRectGetMidY(self.frame) - background2.size.height) {
        background2.position = CGPointMake(background2.position.x, background1.position.y + background1.size.height);
    }
}

- (void)didSimulatePhysics {
    self.spaceShip.physicsBody.velocity = CGVectorMake(self.accelerationX * 300, 0.0);
}

@end
