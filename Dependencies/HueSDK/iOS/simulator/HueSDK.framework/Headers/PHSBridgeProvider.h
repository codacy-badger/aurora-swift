/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>
#import "PHSObject.h"

@class PHSBridge;

@interface PHSBridgeProvider : PHSObject

/**
 Provides a Bridge object
 @return a new instance of the PHSBridge
 */
+ (PHSBridge *)getBridge;

/**
 Provides a Bridge object filled with a persisted bridge state
 @deprecated As of release 1.28, due to duplication of BridgeBuilder functionality and preventing
             function use as a singleton (it returns Bridge clones, which leads to unavoidable cache
             inconsistency between returned Bridge instances).
             Use PHSBridgeBuilder instead.
 @param bridgeId The unique identifier of the bridge
 @return a new instance of the PHSBridge, filles with data from persistence for the specified bridge id
 */
+ (PHSBridge *)getBridgeWithBridgeID:(NSString *)bridgeId __attribute__((deprecated));

@end
