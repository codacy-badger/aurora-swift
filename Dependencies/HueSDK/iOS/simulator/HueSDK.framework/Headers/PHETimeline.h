/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

@interface PHETimeline : NSObject

@property (nonatomic, assign) int64_t length;

- (instancetype)initWithLatencyCompensation:(int)latencyCompensation;

- (void)start;
- (void)pause;
- (void)resume;
- (void)stop;

- (void)setPosition:(int64_t)position;

- (BOOL)isRunning;
- (int64_t)now;

@end
