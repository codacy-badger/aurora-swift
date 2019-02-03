/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHETriggerableAnimation.h"

@interface PHESequenceAnimation : PHETriggerableAnimation

@property (nonatomic, strong) NSArray<PHEAnimation *>* animations;

- (instancetype) init;
- (instancetype) initWithRepeatCount:(double)repeatCount;

- (void)append:(PHEAnimation *)animation bookmark:(NSString *)bookmark;

@end
