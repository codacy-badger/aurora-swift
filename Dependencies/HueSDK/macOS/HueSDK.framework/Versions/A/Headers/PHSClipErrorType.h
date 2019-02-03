/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PHSClipErrorType) {
    PHSClipErrorTypeUnknown                                  = -1,   // -1
    
    PHSClipErrorTypeNone                                     = 0,    // 0
    PHSClipErrorTypeUnauthorizedUser                         = 1,    // 1
    PHSClipErrorTypeInvalidJson,                                     // 2
    PHSClipErrorTypeResourceNotAvailable,                            // 3
    PHSClipErrorTypeMethodNotAvailable,                              // 4
    PHSClipErrorTypeMissingParameter,                                // 5
    PHSClipErrorTypeParameterNotAvailable,                           // 6
    PHSClipErrorTypeInvalidParameter,                                // 7
    PHSClipErrorTypeParameterReadOnly,                               // 8
    PHSClipErrorTypeBusyChangingChannel,                             // 9
    PHSClipErrorTypeParameterChangeAlreadyInProgress,                // 10
    PHSClipErrorTypeTooManyItemsInList,                              // 11
    PHSClipErrorTypePortalConnectionRequired,                        // 12
    
    PHSClipErrorTypeLinkButtonNotPressed                     = 101,  // 101
    
    PHSClipErrorTypeCanNotDisableDHCP                        = 110,  // 110
    PHSClipErrorTypeInvalidUpdateState,                              // 111
    
    PHSClipErrorTypeChangeParameterFailedDeviceIsOff         = 201,  // 201
    PHSClipErrorTypeCommissionableLightListFull              = 203,  // 203
    
    PHSClipErrorTypeTooManyGroups                            = 301,  // 301
    PHSClipErrorTypeTooManyDeviceGroups,                             // 302
    PHSClipErrorTypeDeviceToAddToGroupIsUnreachable,                 // 303
    PHSClipErrorTypeDeviceToAddToSceneIsUnreachable,                 // 304
    PHSClipErrorTypeGroupReadOnly,                                   // 305
    PHSClipErrorTypeLightCanOnlyBeInOneRoom,                         // 306
    PHSClipErrorTypeCannotClaimStreamOwnership,                      // 307
    
    PHSClipErrorTypeSceneCreationBusy                        = 401,  // 401
    PHSClipErrorTypeTooManyScenes,                                   // 402
    PHSClipErrorTypeSceneCouldNotBeDeleted,                          // 403
    PHSClipErrorTypeSceneCouldNotBeCreatedGroupIsEmpty,              // 404
    
    PHSClipErrorTypeCreateSensorTypeNotAllowed               = 501,  // 501
    PHSClipErrorTypeTooManySensors,                                  // 502
    PHSClipErrorTypeCommissionableSensorListFull,                    // 503
    
    PHSClipErrorTypeTooManyRules                             = 601,  // 601
    PHSClipErrorTypeNotAResource                             = 603,  // 603
    PHSClipErrorTypeOperatorNotSupported,                            // 604
    PHSClipErrorTypeHttpMethodNotSupported,                          // 605
    PHSClipErrorTypeBoydNotSupported,                                // 606
    PHSClipErrorTypeInvalidRuleCondition,                            // 607
    PHSClipErrorTypeInvalidRuleAction,                               // 608
    PHSClipErrorTypeCanNotActivateRule,                              // 609
    PHSClipErrorTypeRuleNotLocallyModifiable,                        // 610
    
    PHSClipErrorTypeTooManySchedules                         = 701,  // 701
    PHSClipErrorTypeInvalidTimezone,                                 // 702
    PHSClipErrorTypeTimeLocalTimeConflict,                           // 703
    PHSClipErrorTypeInvalidTag,                                      // 704
    PHSClipErrorTypeScheduleHasExpired,                              // 705
    PHSClipErrorTypeCommandOnUnsupportedResource,                    // 706

    PHSClipErrorTypeSourceModelInvalid                       = 801,  // 801
    PHSClipErrorTypeSourceFactoryNew,                                // 802
    PHSClipErrorTypeInvalidState,                                    // 803

    PHSClipErrorTypeInternal                                 = 901,  // 901

    PHSClipErrorTypeSceneCreatedOnUpdate                    = 9001,  // 9001
};
