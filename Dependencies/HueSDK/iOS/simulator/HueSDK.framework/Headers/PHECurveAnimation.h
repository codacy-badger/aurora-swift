/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHERepeatableAnimation.h"
#import "PHECurveAnimation.h"
#import "PHECurve.h"

@interface PHECurveAnimation : PHERepeatableAnimation

@property (nonatomic, strong) PHECurve* curve;

- (instancetype) init;
- (instancetype)initWithRepeatCount:(double)repeatCount;
- (instancetype)initWithCurve:(PHECurve *)curve;
- (instancetype)initWithCurve:(PHECurve *)curve andRepeatCount:(double)repeatCount;

- (void)appendCurve:(PHECurve *)curve;

@end
