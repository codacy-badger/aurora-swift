/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHSCustomStartUpSettings.h"
#import "PHSStartUpMode.h"

@interface PHSLightStartUpState : NSObject

@property(nonatomic) PHSStartUpMode mode;
@property(readonly, nonatomic, strong) NSNumber* configured;
@property(nonatomic, strong) PHSCustomStartUpSettings* settings;

- (instancetype)initWithMode:(PHSStartUpMode)mode andIsConfigured:(NSNumber*)is_configured;
- (instancetype)initWithSettings:(PHSCustomStartUpSettings*)settings andIsConfigured:(NSNumber*)is_configured;

@end