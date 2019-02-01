/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEPoint.h"

@interface PHECurve : NSObject

@property (nonatomic, strong) NSArray<PHEPoint *>* points;
@property (nonatomic, assign) double               clipMin;
@property (nonatomic, assign) double               clipMax;
@property (nonatomic, assign) double               multiplyFactor;

- (instancetype)initWithPoints:(NSArray<PHEPoint *> *)points;

- (void)appendPoints:(NSArray<PHEPoint *> *)points;
- (BOOL)hasPoints;

- (PHEPoint *)interpolated:(double)x;

- (double)begin;
- (double)end;
- (double)length;

- (BOOL)hasClipMin;
- (void)resetClipMin;

- (BOOL)hasClipMax;
- (void)resetClipMax;

@end

