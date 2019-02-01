/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHETimeline.h"
#import "PHEMessageData.h"

@interface PHETimelineMessageData : NSObject<PHEMessageData>

@property (nonatomic, weak, readonly) PHETimeline* timeline;

@end
