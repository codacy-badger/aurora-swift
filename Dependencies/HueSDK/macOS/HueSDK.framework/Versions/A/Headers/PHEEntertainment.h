/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHSObject.h"
#import "PHSBridge.h"
#import "PHELightScript.h"
#import "PHEEffect.h"
#import "PHEEntertainmentObserver.h"
#import "PHEStartStatus.h"

typedef void (^PHEEntertainmentCompletionHandler) (void);
typedef void (^PHEEntertainmentStartCompletionHandler) (PHEStartStatus status);

@interface PHEEntertainment : NSObject

-(instancetype) init METHOD_UNAVAILABLE("use initWithBridge");
-(instancetype) initWithBridge:(PHSBridge*)bridge withGroup:(NSString*)groupId withResult:(PHEStartStatus*)result;
-(instancetype) initWithBridge:(PHSBridge*)bridge withStreamingPort:(unsigned int)streamingPort withGroup:(NSString*)groupId withResult:(PHEStartStatus*)result;

-(void)startWithCompletionHandler:(PHEEntertainmentStartCompletionHandler)completionHandler;
-(void)stopWithCompletionHandler:(PHEEntertainmentCompletionHandler)completionHandler;
-(void)shutDownWithCompletionHandler:(PHEEntertainmentCompletionHandler)completionHandler;
-(void)lockMixer;
-(void)unlockMixer;

-(PHEEffect*)getEffectByName:(NSString *)name;
-(void)addEffect:(PHEEffect  *) effect;
-(void)addLightScript:(PHELightScript *) script;
-(void)selectGroup:(NSString *) groupId;

-(void)registerObserver:(id<PHEEntertainmentObserver>)observer forMessageType:(PHEMessageType)messageType;
-(void)unregisterObserver:(id<PHEEntertainmentObserver>)observer forMessageType:(PHEMessageType)messageType;
-(void)registerObserver:(id<PHEEntertainmentObserver>)observer withMessageMask:(unsigned int) messageMask;
-(void)unregisterObserver:(id<PHEEntertainmentObserver>)observer withMessageMask:(unsigned int) messageMask;
-(void)unregisterObserver:(id<PHEEntertainmentObserver>)observer;

@end
