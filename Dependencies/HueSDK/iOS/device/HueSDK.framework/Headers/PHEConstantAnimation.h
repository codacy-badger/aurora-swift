/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEAnimation.h"
#import "PHEConstantAnimation.h"

@interface PHEConstantAnimation : PHEAnimation

- (instancetype) init;
- (instancetype) initWithValue:(double)value;
- (instancetype) initWithValue:(double)value andLength:(double)length;

@end


