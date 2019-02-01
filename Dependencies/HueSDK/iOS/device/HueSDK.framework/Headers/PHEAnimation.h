/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import <float.h>

#import "PHSObject.h"
#import "PHEAnimation.h"
#import "PHEEffect.h"

@class PHEAnimation;

@protocol PHEAnimationDelegate
- (double)updateValue:(PHEAnimation*) animation positionMs:(double)position;
- (double)lengthMs:(PHEAnimation*) animation;
- (id<PHEAnimationDelegate>)copy;
- (NSString*) typeName;
@end

@interface PHEAnimation : NSObject

@property (nonatomic, assign) double marker;
@property (nonatomic, assign) double value;
@property (class, readonly) double Infinite;

- (instancetype) init METHOD_UNAVAILABLE("use initWithDelegate");
- (instancetype) initWithDelegate:(id<PHEAnimationDelegate>) delegate;

- (void)rewind;
- (double)totalLength;
- (BOOL)isEndless;
- (BOOL)isPlaying;
- (double)positionFromValue:(double)value;

- (double)updateValue:(double)positionMs;
- (double)lengthMs;
- (PHEAnimation *)copy;
- (NSString*) typeName;

- (id<PHEAnimationDelegate>) delegate;

@end


