/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

typedef NS_ENUM(NSInteger, PHEStartStatus) {
PHEStartStatusSuccess,
PHEStartStatusBridgeIsBusy,         // bridge is already streaming
PHEStartStatusBridgeIsNotSupported, // Invalid bridge software version/model
PHEStartStatusBridgeIsNotConnected,
PHEStartStatusInvalidGroupSelected, // selected group is invalid
PHEStartStatusInvalidClientKey,     // user has invalid client key; user should push-link again
PHEStartStatusUnableToCreateStream,
};
