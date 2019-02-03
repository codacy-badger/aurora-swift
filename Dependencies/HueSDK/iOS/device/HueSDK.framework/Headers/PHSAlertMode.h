/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PHSAlertMode) {
    PHSAlertModeUnknown = -1, // It is unkown what the current alert value is
    PHSAlertModeNone = 0, // No alert active
    PHSAlertModeSelect, // Select alert (1 breath cycle) is active
    PHSAlertModeLSelect // Select alert (30 seconds of breath cycles) is active
};
