/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

@interface PHELocation : NSObject

@property (nonatomic, assign) double x;
@property (nonatomic, assign) double y;

- (instancetype)initWithX:(double)x andY:(double)y;

@end
