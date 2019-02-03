/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHEMessage.h"

typedef void (^PHEEntertainmentObserverBlock)(PHEMessage *message);

@protocol PHEEntertainmentObserver

- (void)onMessage:(PHEMessage *)message;

@end
