/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEMessageData.h"
#import "PHELight.h"

@interface PHERenderMessageData : NSObject<PHEMessageData>

@property (nonatomic, strong, readonly) NSArray<PHELight*>* lights;

@end
