/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEEffect.h"
#import "PHEAnimationEffect.h"

#define AUTOMATICALLY_DETERMINED_ENDPOSITION -1;

@interface PHEAction : PHEEffect

@property (nonatomic, strong) PHEAnimationEffect* animationEffect;
@property (nonatomic, assign) int64_t             startPosition;
@property (nonatomic, assign) int64_t             endPosition;

- (instancetype)initWithName:(NSString*)name andLayer:(int)layer;

- (instancetype)initWithName:(NSString *)name
                    andLayer:(int)layer
          andAnimationEffect:(PHEAnimationEffect *)animationEffect
             andStartPostion:(int64_t)startPosition;

- (instancetype)initWithName:(NSString *)name
                    andLayer:(int)layer
          andAnimationEffect:(PHEAnimationEffect *)animationEffect
             andStartPostion:(int64_t)startPosition
              andEndPosition:(int64_t)endPosition;

@end


