/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEMultiChannelEffect.h"
#import "PHEAnimationEffect.h"

#import "PHEChannel.h"

@interface PHEMultiChannelEffect : PHEAnimationEffect

- (instancetype)initWithName:(NSString *)name andLayer:(int)layer;

- (void)addChannel:(PHEChannel *)channel;
- (void)clear;

@end


