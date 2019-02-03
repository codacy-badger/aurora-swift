/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEAreaEffect.h"
#import "PHEColorAnimationEffect.h"
#import "PHEArea.h"

@interface PHEAreaEffect : PHEColorAnimationEffect

- (instancetype)initWithName:(NSString *)name andLayer:(int)layer;

- (void)addArea:(PHEArea *)area;
- (void)setArea:(PHEArea *)area;

@end


