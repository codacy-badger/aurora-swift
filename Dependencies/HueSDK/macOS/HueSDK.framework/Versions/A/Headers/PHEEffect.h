/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHSObject.h"
#import "PHEColor.h"
#import "PHELight.h"

@class PHEEffect;

@protocol PHEEffectDelegate
- (PHEColor *)colorForEffect:(PHEEffect*) effect andLight:(PHELight*)light;
- (void)render:(PHEEffect*) effect;
- (NSString*) typeName;
@end

@interface PHEEffect : NSObject

@property (nonatomic, strong)   NSString* name;
@property (nonatomic, assign)   int       layer;

- (instancetype)init METHOD_UNAVAILABLE("use initWithDelegate");
- (instancetype)initWithDelegate:(id<PHEEffectDelegate>) delegate;
- (instancetype)initWithName:(NSString*)name andLayer:(int)layer andDelegate:(id<PHEEffectDelegate>) delegate;

- (void)enable;
- (void)disable;
- (void)finish;

- (BOOL)isEnabled;
- (BOOL)isDisabled;
- (BOOL)isFinished;

- (id<PHEEffectDelegate>) getDelegate;

- (PHEColor *)colorForLight:(PHELight*)light;
- (void)render;
- (NSString*) typeName;

@end


