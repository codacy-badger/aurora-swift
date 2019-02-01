/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import "PHSObject.h"

@interface PHSGamutColor : PHSObject

- (instancetype) init __attribute__((unavailable("init not available")));

/**
 The identifier
 @deprecated
 */
@property (strong, nonatomic, readonly) NSString *identifier __attribute__((deprecated));

/**
 The x value
 */
@property (strong, nonatomic, readonly) NSNumber *x;

/**
 The y value
 */
@property (strong, nonatomic, readonly) NSNumber *y;

@end
