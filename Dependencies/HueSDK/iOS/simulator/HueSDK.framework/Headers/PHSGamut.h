/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import "PHSObject.h"


typedef NS_ENUM(NSInteger, PHSGamutType) {
        PHSGamutTypeA = 0,
        PHSGamutTypeB = 1,
        PHSGamutTypeC = 2,
        PHSGamutTypeOther = 3
};

@interface PHSGamut : PHSObject

- (instancetype) init __attribute__((unavailable("init not available")));

/**
 The identifier
 @deprecated
 */
@property (strong, nonatomic, readonly) NSString *identifier __attribute__((deprecated));

@property (nonatomic, readonly) PHSGamutType type;

/**
 The colors
 @deprecated
 */
@property (strong, nonatomic, readonly) NSDictionary *colorPoints __attribute__((deprecated));

@property (strong, nonatomic, readonly) NSArray *points;

@end
