/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEManualEffect.h"
#import "PHEEffect.h"

@interface PHEManualEffect : PHEEffect

- (instancetype)initWithName:(NSString *)name andLayer:(int)layer;

- (void)setLightToColor:(NSString *)identifier color:(PHEColor *)color;

@end


