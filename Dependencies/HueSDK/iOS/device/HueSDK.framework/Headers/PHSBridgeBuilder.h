/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHSBridge.h"
#import "PHSBridgeConnectionType.h"
#import "PHSBridgeState.h"
#import "PHSBridgeConnection.h"
#import "PHSBridgeConnectionProtocol.h"

@interface PHSBridgeBuilder : NSObject

/**
 IP address of the bridge
 */
@property (strong, nonatomic) NSString *ipAddress;

/**
 The bridge's ID (required for fast connection mode)
 */
@property (strong, nonatomic) NSString *bridgeID;

/**
 the type of connections that will be requested: PHSBridgeConnectionTypeLocal, PHSBridgeConnectionTypeRemote, or PHSBridgeConnectionTypeLocalRemote
 */
@property (nonatomic) PHSBridgeConnectionType connectionTypes;

/**
 The bridge connection observer
 */
@property (strong, nonatomic) id<PHSBridgeConnectionObserver> bridgeConnectionObserver;

/**
 Define whether the local connection (if any) is http or httpS
 */
@property (nonatomic) PHSBridgeConnectionProtocol localConnectionProtocol;

/**
 Define whether to use fast connection mode (need to set bridge id too)
 */
@property (nonatomic) BOOL fastConnectionMode;

/**
 * Forbid loading the bridge state cache from persistence (default false)
 * Setting to true prevents constructing the full object tree during initialization/connection
 * Useful for lowering the memory footprint of the SDK
 * Setting this to true only works on fast connection mode:
 *   slow connection mode will perform a full heartbeat and populate the cache.
 */
@property (nonatomic) BOOL forbidLoadPersistence;

/**
 * Prevents saving the bridge state, authentication data, and certificates to persistence (default false)
 */
@property (nonatomic) BOOL forbidStorePersistence;

/**
 The device name
 */
- (instancetype)initWithAppName:(NSString *)appName withDeviceName:(NSString *)deviceName;

/**
 setup parameters for remote connection
 if any non-optional parameter is nullptr, all will be ignored
 @param appID        ID of the application
 @param deviceID     ID of the device
 @param accountGUID  Global Unique portal account ID
 @param callbackURL  URL to which www.meethue.com should redirect after login
 */
- (void)setupRemoteWithAppID:(NSString*)appID withDeviceID:(NSString*)deviceID withAccountGUID:(NSString*)accountGUID withcallbackURL:(NSString*)callbackURL;

/**
 Setup parameters for remote connection
 @param appID        ID of the application
 @param deviceID     ID of the device
 @param accountGUID  Global Unique portal account ID
 @param callbackURL  URL to which www.meethue.com should redirect after login
 @param clientID     developer username for remote API login (basic authentication)
 @param clientSecret developer password for remote API login (basic authentication)
 */
- (void)setupRemoteWithAppID:(NSString*)appID withDeviceID:(NSString*)deviceID withAccountGUID:(NSString*)accountGUID withcallbackURL:(NSString*)callbackURL withclientID:(NSString*)clientID withClientSecret:(NSString*)clientSecret;

/**
 @deprecated: use PHSBridgeState::addStateUpdateObserver instead
 */
- (void)addStateUpdateObserver:(id<PHSBridgeStateUpdateObserver>)observer __attribute__((deprecated));

/**
 @return a newly built bridge with connections of all requested connection types
 */
- (PHSBridge*) build;

@end
