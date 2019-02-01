/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import "PHSObject.h"

@class PHSManufacturer;

@interface PHSDeviceInfo : PHSObject

/**
 The product name
 */
@property (strong, nonatomic, readonly) NSString *productName;

/**
 The manufacturer of the device
 */
@property (strong, nonatomic, readonly) PHSManufacturer *manufacturer;

/**
 The supported features for the device
 */
@property (strong, nonatomic, readonly) NSArray *supportedFeatures;

/**
 The friendly name of the device
 */
@property (strong, nonatomic, readonly) NSString *friendlyName;

/**
 The Hue-certified flag of the device
 */
@property (nonatomic, readonly) BOOL certified;

/**
 Check whether a feature is supported by the device
 @param feature requested feature
 @return whether the device supports a feature
 */
-(BOOL) doesSupport:(NSString*) feature;

@end

