/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import "PHSDeviceInfo.h"

@class PHSGamut;

@interface PHSLightInfo : PHSDeviceInfo

- (instancetype) init __attribute__((unavailable("init not available")));

/**
 The friendly name of the light
 */
@property (strong, nonatomic, readonly) PHSGamut *gamut;

/**
 The model id of the light
 */
@property (strong, nonatomic, readonly) NSString *modelId;

/**
 The sw version
 */
@property (strong, nonatomic, readonly) NSString *swVersion;

/**
 The light type
 */
@property (strong, nonatomic, readonly) NSString *lightType;

/**
 The param ranges of attributes which are settable on the light
 */
@property (strong, nonatomic, readonly) NSDictionary *parameterRanges  __deprecated_msg("Not in use anymore.");

/**
 The images
 */
@property (strong, nonatomic, readonly) NSDictionary *images;

/**
 capabilities: max-lumen
 */
@property (strong, nonatomic, readonly) NSNumber *maximumLumen;

/**
 capabilities: min-dimming-level
 */
@property (strong, nonatomic, readonly) NSNumber *minimumDimmingLevel;

/**
 capabilities: minimum-color-temperature
 */
@property (strong, nonatomic, readonly) NSNumber *minimumCT;

/**
 capabilities: maximum-color-temperature
 */
@property (strong, nonatomic, readonly) NSNumber *maximumCT;

@end
