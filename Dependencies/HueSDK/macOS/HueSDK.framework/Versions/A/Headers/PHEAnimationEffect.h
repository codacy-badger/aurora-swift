/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEAnimationEffect.h"
#import "PHEAnimation.h"
#import "PHEEffect.h"

@protocol PHEAnimationEffectRenderDelegate <PHEEffectDelegate>
- (void) renderUpdate:(PHEEffect*) effect;
@end

@protocol PHEAnimationEffectDelegate <PHEAnimationEffectRenderDelegate>
- (NSArray<PHEAnimation *> *)animations:(PHEEffect*) effect;
@end

@interface PHEAnimationEffect : PHEEffect

- (instancetype)initWithName:(NSString *)name andLayer:(int)layer andDelegate:(id<PHEAnimationEffectDelegate>) delegate;

- (void)setSpeedAnimation:(PHEAnimation *)speed;
- (double)length;
- (BOOL)isEndless;
- (void)render;

- (id<PHEEffectDelegate>) getDelegate;

- (NSArray<PHEAnimation *> *)animations;
- (void) renderUpdate;

@end


