/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHSColorXY.h"

@interface PHSCustomStartUpSettings : NSObject

@property(nonatomic, strong) NSNumber* bri;
@property(nonatomic, strong) NSNumber* ct;
@property(nonatomic, strong) PHSColorXY* xy;

- (instancetype)initWithBri:(NSNumber*)bri;
- (instancetype)initWithBri:(NSNumber*)bri andCt:(NSNumber*)ct;
- (instancetype)initWithBri:(NSNumber*)bri andXy:(PHSColorXY*)xy;

@end