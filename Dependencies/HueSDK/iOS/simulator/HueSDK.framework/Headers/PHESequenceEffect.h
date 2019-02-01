/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEEffect.h"
#import "PHEAnimationEffect.h"
#import "PHEColor.h"
#import "PHEArea.h"
#import "PHESequenceEffectEnums.h"

@interface PHESequenceEffect : PHEEffect

@property (nonatomic, assign) double                brightness;
@property (nonatomic, assign) PHESequenceEffectMode mode;

- (instancetype)initWithName:(NSString *)name andLayer:(int)layer;

- (void)addColor:(PHEColor *)color;
- (BOOL)addArea:(PHEArea *)area;

- (void)step;

- (void)increaseBrightness:(double)brightness;
- (void)decreaseBrightness:(double)brightness;

@end


