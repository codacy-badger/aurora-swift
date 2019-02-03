/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEMessageEnums.h"
#import "PHEMessageData.h"

@interface PHEMessage : NSObject

@property (nonatomic, assign, readonly) PHEMessageType        type;
@property (nonatomic, strong, readonly) NSString*             tag;
@property (nonatomic, strong, readonly) NSString*             userMessage;
@property (nonatomic, strong, readonly) NSString*             debugMessage;
@property (nonatomic, assign, readonly) PHEMessageId          messageId;
@property (nonatomic, strong, readonly) NSString*             bridgeId;
@property (nonatomic, strong, readonly) id<PHEMessageData>    data;

@end
