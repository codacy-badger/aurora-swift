/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHELocation.h"
#import "PHEAnimation.h"

@interface PHEChannel : NSObject

@property (nonatomic, strong) PHELocation* position;
@property (nonatomic, strong) PHEAnimation* r;
@property (nonatomic, strong) PHEAnimation* g;
@property (nonatomic, strong) PHEAnimation* b;
@property (nonatomic, strong) PHEAnimation* a;

- (instancetype)initWithLocation:(PHELocation *)position
                               r:(PHEAnimation *)r
                               g:(PHEAnimation *)g
                               b:(PHEAnimation *)b
                               a:(PHEAnimation *)a;

@end
