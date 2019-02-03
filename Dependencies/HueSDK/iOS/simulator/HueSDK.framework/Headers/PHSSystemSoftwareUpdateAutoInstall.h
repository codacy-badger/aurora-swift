/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHSDomainObject.h"
#import "PHSTruncatedTimePattern.h"

@interface PHSSystemSoftwareUpdateAutoInstall : PHSDomainObject

@property (strong, nonatomic) NSNumber *on;

@property (strong, nonatomic) PHSTruncatedTimePattern *updateTime;

@property (assign, nonatomic) BOOL isSupported;

@end
