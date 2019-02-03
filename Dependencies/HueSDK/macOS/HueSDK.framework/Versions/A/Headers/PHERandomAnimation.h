/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEAnimation.h"
#import "PHETweenType.h"

@interface PHERandomAnimation : PHEAnimation

@property (nonatomic, assign) double       minValue;
@property (nonatomic, assign) double       maxValue;
@property (nonatomic, assign) double       minInterval;
@property (nonatomic, assign) double       maxInterval;
@property (nonatomic, assign) PHETweenType tweenType;
@property (nonatomic, assign) double       length;

- (instancetype) init;
- (instancetype) initWithMinValue:(double)minValue
                      andMaxValue:(double)maxValue
                   andMinInterval:(double)minInterval
                   andMaxInterval:(double)maxInterval
                     andTweenType:(PHETweenType)tweenType
                        andLength:(double)length;

@end
