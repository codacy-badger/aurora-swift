/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHELocation.h"

@class PHEArea;

// defaults
@interface PHEArea : NSObject

@property (class, readonly) PHEArea* All;
@property (class, readonly) PHEArea* FrontHalf;
@property (class, readonly) PHEArea* BackHalf;
@property (class, readonly) PHEArea* LeftHalf;
@property (class, readonly) PHEArea* RightHalf;
@property (class, readonly) PHEArea* Front;
@property (class, readonly) PHEArea* CenterFB;
@property (class, readonly) PHEArea* Back;
@property (class, readonly) PHEArea* Left;
@property (class, readonly) PHEArea* CenterLR;
@property (class, readonly) PHEArea* Right;
@property (class, readonly) PHEArea* FrontLeft;
@property (class, readonly) PHEArea* FrontCenter;
@property (class, readonly) PHEArea* FrontRight;
@property (class, readonly) PHEArea* CenterLeft;
@property (class, readonly) PHEArea* Center;
@property (class, readonly) PHEArea* CenterRight;
@property (class, readonly) PHEArea* BackLeft;
@property (class, readonly) PHEArea* BackCenter;
@property (class, readonly) PHEArea* BackRight;
@property (class, readonly) PHEArea* FrontLeftQuarter;
@property (class, readonly) PHEArea* FrontRightQuarter;
@property (class, readonly) PHEArea* BackRightQuarter;
@property (class, readonly) PHEArea* BackLeftQuarter;
@property (class, readonly) PHEArea* FrontHalfLeft;
@property (class, readonly) PHEArea* FrontHalfCenter;
@property (class, readonly) PHEArea* FrontHalfRight;
@property (class, readonly) PHEArea* LeftHalfFront;
@property (class, readonly) PHEArea* LeftHalfCenter;
@property (class, readonly) PHEArea* LeftHalfBack;
@property (class, readonly) PHEArea* BackHalfLeft;
@property (class, readonly) PHEArea* BackHalfCenter;
@property (class, readonly) PHEArea* BackHalfRight;
@property (class, readonly) PHEArea* RightHalfFront;
@property (class, readonly) PHEArea* RightHalfCenter;
@property (class, readonly) PHEArea* RightHalfBack;

@property (nonatomic, strong) PHELocation* topLeft;
@property (nonatomic, strong) PHELocation* bottomRight;
@property (nonatomic, assign) BOOL         inverted;
@property (nonatomic, strong) NSString*    name;


+ (PHEArea *)knownAreaByName:(NSString*)name;

- (instancetype)initWithTopLeftX:(double)topLeftX
                     andTopLeftY:(double)topLeftY
                 andBottomRightX:(double)bottomRightX
                 andBottomRightY:(double)bottomRightY
                         andName:(NSString *)name
                        inverted:(BOOL)inverted;

- (instancetype)initWithTopLeft:(PHELocation *)topLeft
                 andBottomRight:(PHELocation *)bottomRight
                        andName:(NSString *)name
                       inverted:(BOOL)inverted;

- (BOOL)isInArea:(PHELocation *)location;

@end
