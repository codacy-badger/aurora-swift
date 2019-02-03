/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHSColor.h"
#import "PHSLightPoint.h"

@interface PHSLightPointCluster : NSObject

@property (nonatomic, strong, readonly) PHSColor* centroid;
@property (nonatomic, strong, readonly) NSArray<PHSLightPoint *> * lightPoints;

-(instancetype) init METHOD_UNAVAILABLE("Creation of light point cluster is not permitted");

@end

