/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEAnimation.h"
#import "PHETweenType.h"

@interface PHETweenAnimation : PHEAnimation

@property (nonatomic, assign) double       beginValue;
@property (nonatomic, assign) double       endValue;
@property (nonatomic, assign) double       timeMs;
@property (nonatomic, assign) PHETweenType tweenType;

- (instancetype) init;
- (instancetype) initWithEndValue:(double)endValue
                        andTimeMs:(double)timeMs
                     andTweenType:(PHETweenType)tweenType;

- (instancetype) initWithBeginValue:(double)beginValue
                        andEndValue:(double)endValue
                          andTimeMs:(double)timeMs
                       andTweenType:(PHETweenType)tweenType;

@end
