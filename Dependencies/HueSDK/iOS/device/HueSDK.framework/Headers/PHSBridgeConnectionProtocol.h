/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, PHSBridgeConnectionProtocol) {
    PHSBridgeConnectionProtocolHTTP        = 0,
    PHSBridgeConnectionProtocolHTTPS       = 1,
    PHSBridgeConnectionProtocolPreferHTTPS = 2,
    PHSBridgeConnectionProtocolUnavailable /* Represents optionality */
};

@interface PHSOptionalBridgeConnectionProtocol : NSObject
-(instancetype)initWith:(PHSBridgeConnectionProtocol) value;
@property(nonatomic) PHSBridgeConnectionProtocol value;
@end
