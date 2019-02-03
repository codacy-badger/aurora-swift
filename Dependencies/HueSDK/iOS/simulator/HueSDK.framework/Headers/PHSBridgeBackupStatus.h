/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PHSBridgeBackupStatus) {
    PHSBridgeBackupStatusUnknown = -1,
    PHSBridgeBackupStatusIdle = 0,
    PHSBridgeBackupStatusStartMigration,
    PHSBridgeBackupStatusFilereadyDisabled,
    PHSBridgeBackupStatusPrepareRestore,
    PHSBridgeBackupStatusRestoring,
};
