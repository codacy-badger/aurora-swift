/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

typedef NS_ENUM(NSInteger, PHEMessageId) {
    PHEMessageIdStreamingDisconnected,
    PHEMessageIdLightsUpdated,  // lights from active streaming group updated
    PHEMessageIdGroupsUpdated,
    PHEMessageIdRendered,
    PHEMessageIdTimelineStarted,
    PHEMessageIdTimelinePaused,
    PHEMessageIdTimelineResumed,
    PHEMessageIdTimelineStopped,
    PHEMessageIdTimelineEnded
};

static const unsigned int MESSAGE_TYPE_ALL = ~0;

typedef NS_ENUM(NSInteger, PHEMessageType) {
    PHEMessageTypeInfo     = 1,
    PHEMessageTypeUser     = 2,
    PHEMessageTypeRender   = 4,
    PHEMessageTypeTimeline = 8
};
