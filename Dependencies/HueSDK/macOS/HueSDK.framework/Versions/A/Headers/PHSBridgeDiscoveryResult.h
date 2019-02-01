/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

// Generated, do not modify

#import <Foundation/Foundation.h>

@interface PHSBridgeDiscoveryResult : NSObject

/**
 the unique id of the bridge
 */
@property(nonnull, nonatomic, strong) NSString *uniqueId;
/**
 ip address of the bridge
 */
@property(nonnull, nonatomic, strong) NSString *ip;
/**
 api version of the bridge
 */
@property(nonnull, nonatomic, strong) NSString *apiVersion;
/**
 the model ID of the bridge
 */
@property(nonnull, nonatomic, strong) NSString *modelId;

- (nonnull instancetype)initWithUniqueId:(nonnull NSString *)uniqueId
                                      ip:(nonnull NSString *)ip
                              apiVersion:(nonnull NSString *)apiVersion
                                 modelId:(nonnull NSString *)modelId;

@end
