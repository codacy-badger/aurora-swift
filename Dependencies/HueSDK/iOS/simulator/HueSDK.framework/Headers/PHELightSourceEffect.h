/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHELightSourceEffect.h"
#import "PHEColorAnimationEffect.h"

@interface PHELightSourceEffect : PHEColorAnimationEffect

@property (nonatomic, strong) PHEAnimation* radiusAnimation;
@property (nonatomic, strong) PHEAnimation* xAnimation;
@property (nonatomic, strong) PHEAnimation* yAnimation;

- (instancetype)initWithName:(NSString *)name andLayer:(int)layer;

- (void)setPositionAnimationX:(PHEAnimation *)x y:(PHEAnimation *)y;

@end


