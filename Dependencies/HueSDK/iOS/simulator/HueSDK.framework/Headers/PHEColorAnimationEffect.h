/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEAnimationEffect.h"
#import "PHEColor.h"
#import "PHEAnimation.h"

@protocol PHEColorAnimationEffectDelegate <PHEAnimationEffectRenderDelegate>
@end

@interface PHEColorAnimationEffect : PHEAnimationEffect

@property (nonatomic, strong) PHEAnimation* redAnimation;
@property (nonatomic, strong) PHEAnimation* greenAnimation;
@property (nonatomic, strong) PHEAnimation* blueAnimation;
@property (nonatomic, strong) PHEAnimation* intensityAnimation;
@property (nonatomic, strong) PHEAnimation* opacityAnimation;
@property (nonatomic, assign) BOOL          opacityBoundToIntensity;

- (instancetype)initWithName:(NSString *)name andLayer:(int)layer andDelegate:(id<PHEColorAnimationEffectDelegate>) delegate;

- (void)setColorAnimation:(PHEAnimation *)r g:(PHEAnimation *)g b:(PHEAnimation *)b;
- (void)setFixedColor:(PHEColor *)color;
- (void)setFixedOpacity:(double)opacity;

- (id<PHEEffectDelegate>) getDelegate;
@end


