/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PHSSceneType) {
    PHSSceneTypeUnknown, // It is unkown what the current scene type is
    PHSSceneTypeLight,   // Scene is a light scene
    PHSSceneTypeGroup    // Scene is a group scene
};
