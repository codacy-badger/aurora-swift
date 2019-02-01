/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHERepeatableAnimation.h"

@interface PHETriggerableAnimation : PHERepeatableAnimation

- (instancetype) init;
- (instancetype) initWithRepeatCount:(double)repeatCount;

- (void)trigger:(NSString*)bookmark;
- (void)triggerOnLevel:(NSString *)bookmark;

- (double)offset;

@end
