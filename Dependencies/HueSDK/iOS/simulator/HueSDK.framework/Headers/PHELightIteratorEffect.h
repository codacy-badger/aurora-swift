/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import "PHELightIteratorEffect.h"
#import "PHEColorAnimationEffect.h"
#import "PHELightIteratorEffectEnums.h"

@interface PHELightIteratorEffect : PHEColorAnimationEffect

@property (nonatomic, assign) PHELightIteratorEffectOrder order;
@property (nonatomic, assign) PHELightIteratorEffectMode  mode;
@property (nonatomic, assign) double                      offset;
@property (nonatomic, assign) BOOL                        hasPreamble;
@property (nonatomic, assign) BOOL                        hasInvertedOrder;

- (instancetype)initWithName:(NSString *)name andLayer:(int)layer;

- (instancetype)initWithName:(NSString *)name
                    andLayer:(int)layer
                    andOrder:(PHELightIteratorEffectOrder)order
                     andMode:(PHELightIteratorEffectMode)mode
                   andOffset:(double)offset
              andHasPreamble:(BOOL)preamble
         andHasInvertedOrder:(BOOL)invertedIterationOrder;

@end
