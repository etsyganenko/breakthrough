//
//  TSYScrollingNode.h
//  TSYTestGame
//
//  Created by Yevgen on 12/24/15.
//  Copyright © 2015 IDAP. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TSYScrollingNode : SKSpriteNode

- (id)initWithBackground:(NSString *)background
                    size:(CGSize)size
                   speed:(CGFloat)speed;

- (void)update:(NSTimeInterval)currentTime;

@end
