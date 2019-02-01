/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHELocation.h"
#import "PHETimeline.h"
#import "PHEAction.h"

@interface PHELightScript : NSObject

@property (nonatomic, strong, readonly) NSString*                   name;
@property (nonatomic, assign, readonly) int64_t                     length;
@property (nonatomic, strong)           NSArray<PHEAction *>* actions;
@property (nonatomic, strong)           NSArray<PHELocation*>* idealSetup;

- (instancetype)initWithName:(NSString *)name andLength:(int64_t)length;
- (instancetype)initWithName:(NSString *)name andLength:(int64_t)length andIdealSetup:(NSArray<PHELocation *> *)idealSetup;

- (void)bindTimeLine:(PHETimeline *)timeLine;
- (void)finish;

- (void)addAction:(PHEAction *)action;

- (void) load:(NSString *) content;

- (NSString*) toString;
+ (PHELightScript*) fromString: (NSString*) content;

@end
    
