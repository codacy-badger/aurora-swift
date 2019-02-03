/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEMessageEnums.h"

@interface PHEColor : NSObject

@property (nonatomic, assign) double r;
@property (nonatomic, assign) double g;
@property (nonatomic, assign) double b;
@property (nonatomic, assign) double a;

- (instancetype)initWithR:(double)r g:(double)g b:(double)b;
- (instancetype)initWithR:(double)r g:(double)g b:(double)b a:(double)a;

- (double)currentBrightness;
- (void)applyBrightness:(double)brightness;

@end
