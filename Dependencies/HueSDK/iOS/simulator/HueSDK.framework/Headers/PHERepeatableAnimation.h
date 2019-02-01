/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEAnimation.h"

@interface PHERepeatableAnimation : PHEAnimation

@property (nonatomic, assign) double repeatCount;

- (instancetype) initWithDelegate:(id<PHEAnimationDelegate>)delegate;
- (instancetype) initWithDelegate:(id<PHEAnimationDelegate>)delegate andRepeatCount:(double)repeatCount;
//- (instancetype) initWithDelegate:(PHEAnimation)animation andRepeatCount:(double)repeatCount;

@end
