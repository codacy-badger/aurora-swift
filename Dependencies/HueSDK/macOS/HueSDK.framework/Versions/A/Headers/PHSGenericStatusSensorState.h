/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import "PHSSensorState.h"

@interface PHSGenericStatusSensorState : PHSSensorState

/**
 sensor status, expressed as integer
 */
@property (strong, nonatomic) NSNumber* status;

@end
