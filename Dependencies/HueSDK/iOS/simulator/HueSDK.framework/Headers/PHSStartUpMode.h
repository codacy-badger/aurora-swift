/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PHSStartUpMode) {
    PHSStartUpModeSafety,
    PHSStartUpModePowerfail,
    PHSStartUpModeLastonstate,
    PHSStartUpModeCustom,
    PHSStartUpModeUnknown,
    PHSStartUpModeUnavailable /* Represents optionality */
};