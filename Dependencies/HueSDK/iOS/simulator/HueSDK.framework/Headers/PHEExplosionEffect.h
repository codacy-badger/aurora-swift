/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEExplosionEffect.h"
#import "PHELightSourceEffect.h"

@interface PHEExplosionEffect : PHELightSourceEffect

- (instancetype)initWithName:(NSString *)name andLayer:(int)layer;

- (void)prepareEffectWithColor:(PHEColor *)color
                   andLocation:(PHELocation *)location
                   andDuration:(double)duration
                     andRadius:(double)radius
        andRadiusExpansionTime:(double)radiusExpansionTime
     andIntensityExpansionTime:(double)intensityExpansionTime;

@end


