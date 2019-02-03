/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

// Generated, do not modify

#import <Foundation/Foundation.h>

#import "PHSBridgeDiscoveryResult.h"

#import "PHSReturnCode.h"

/**
 * Bridge Discovery Option enum
 * Use this enum to get the Bridge Discovery method options.
 */
typedef NS_OPTIONS(NSInteger, PHSBridgeDiscoveryOption) {
  /** search for bridges via UPnP on the local network  */
  PHSBridgeDiscoveryOptionUpnp = 1 << 0,
  /**  brute force scanning for bridges on the local network.
    Scans only the last subnet of the ip (IPV4 only).
    If multiple network interfaces are present it picks the first one in the
    list  */
  PHSBridgeDiscoveryOptionIpscan = 1 << 1,
  /** search for bridges via the portal  */
  PHSBridgeDiscoveryOptionNupnp = 1 << 2
};

@interface PHSBridgeDiscoveryOptionalOption : NSObject
@property(nonatomic) PHSBridgeDiscoveryOption value;

- (instancetype)init __attribute__((unavailable("use initWith constructor")));
- (instancetype)initWith:(PHSBridgeDiscoveryOption)value;
@end

typedef NS_ENUM(NSInteger, PHSBridgeDiscoveryReturnCode) {
  /** Search was successful  */
  PHSBridgeDiscoveryReturnCodeSuccess = 0,
  /** A search is already in progress. It's not allowed to start multiple
     searches simultaneously  */
  PHSBridgeDiscoveryReturnCodeBusy = -5,
  PHSBridgeDiscoveryReturnCodeNullParameter = -101,
  /** Search has been stopped  */
  PHSBridgeDiscoveryReturnCodeStopped = -303,
  /** No discovery methods could be found  */
  PHSBridgeDiscoveryReturnCodeMissingDiscoveryMethods = -401
};

@interface PHSBridgeDiscoveryOptionalReturnCode : NSObject
@property(nonatomic) PHSBridgeDiscoveryReturnCode value;

- (instancetype)init __attribute__((unavailable("use initWith constructor")));
- (instancetype)initWith:(PHSBridgeDiscoveryReturnCode)value;
@end

typedef void (^PHSBridgeDiscoveryCallback)(
    NSArray<PHSBridgeDiscoveryResult *> *results,
    PHSBridgeDiscoveryReturnCode returnCode);

@interface PHSBridgeDiscovery : NSObject

/**
 * Search for Hue bridges with default search methods (UPNP and NUPNP)
 * @param cb The callback interface, onFinished will be called when search is
 * done.
 */
- (void)search:(PHSBridgeDiscoveryCallback)cb;
/**
 * Search for Hue Bridges with specific search methods.
 * @param option bridge discovery option
 * @param cb The callback interface, onFinished will be called when search is
 * done.
 */
- (void)search:(PHSBridgeDiscoveryOption)option
            Cb:(PHSBridgeDiscoveryCallback)cb;
/**
 * Get the state of the bridge search.
 * @return Boolean value whether bridge search is active or not.
 */
- (BOOL)isSearching;
/**
 * Stop the bridge search. If a search was still in progress, that the callback
 * will be called with the found results.
 */
- (void)stop;

/**
     Bridge discovery results completion handler block
     The block is used to handle the results when doing a search
     @param results    dictionary with PHSBridgeDiscoveryResult object for each
   bridge that is discovered (unique id as key)
     @param returnCode will return PHSReturnCodeStopped when the search is
   stopped by the user, and PHSReturnCodeSuccess otherwise
     */
typedef void (^PHSBridgeDiscoveryResultsCompletionHandler)(
    NSDictionary<NSString *, PHSBridgeDiscoveryResult *> *results,
    PHSReturnCode returnCode);

- (void)search:(PHSBridgeDiscoveryOption)options
    withCompletionHandler:
        (PHSBridgeDiscoveryResultsCompletionHandler)completionHandler
    __attribute__((deprecated));
@end
