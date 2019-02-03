/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHSLightPointCluster.h"

@interface PHSLightPointClustering : NSObject

- (NSArray<PHSLightPointCluster *> *) cluster:(NSArray<PHSLightPoint *> *)lightPoints;

@end
