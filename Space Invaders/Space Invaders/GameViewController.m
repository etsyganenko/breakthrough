//
//  GameViewController.m
//  Space Invaders
//
//  Created by Yevgen on 12/29/15.
//  Copyright (c) 2015 IDAP. All rights reserved.
//

#import "GameViewController.h"

#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SKView *skView = (SKView *)self.view;
    GameScene *scene = [[GameScene alloc] initWithSize:skView.bounds.size];

    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
