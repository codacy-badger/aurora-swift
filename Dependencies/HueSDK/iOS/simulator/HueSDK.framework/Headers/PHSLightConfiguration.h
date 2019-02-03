/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>
#import "PHSDeviceConfiguration.h"
#import "PHSLightStartUpState.h"

typedef NS_ENUM(NSInteger, PHSLightArchetype) {
    PHSLightArchetypeClassicBulb = 0,
    PHSLightArchetypeSultanBulb = 1,
    PHSLightArchetypeFloodBulb = 2,
    PHSLightArchetypeSpotBulb = 3,
    PHSLightArchetypeCandleBulb = 4,
    PHSLightArchetypePlug = 5,
    PHSLightArchetypePendantRound = 6,
    PHSLightArchetypePendantLong = 7,
    PHSLightArchetypeCeilingRound = 8,
    PHSLightArchetypeCeilingSquare = 9,
    PHSLightArchetypeFloorShade = 10,
    PHSLightArchetypeFloorLantern = 11,
    PHSLightArchetypeTableShade = 12,
    PHSLightArchetypeRecessedCeiling = 13,
    PHSLightArchetypeRecessedFloor = 14,
    PHSLightArchetypeSingleSpot = 15,
    PHSLightArchetypeDoubleSpot = 16,
    PHSLightArchetypeTableWash = 17,
    PHSLightArchetypeWallLantern = 18,
    PHSLightArchetypeWallShade = 19,
    PHSLightArchetypeFlexibleLamp = 20,
    PHSLightArchetypeHueGo = 21,
    PHSLightArchetypeHueLightStrip = 22,
    PHSLightArchetypeGroundSpot = 23,
    PHSLightArchetypeWallSpot = 24,
    PHSLightArchetypeHueIris = 25,
    PHSLightArchetypeHueBloom = 26,
    PHSLightArchetypeBollard = 27,
    PHSLightArchetypeHuePlay = 28,
    PHSLightArchetypeUnknown = 29,
};

typedef NS_ENUM(NSInteger, PHSLightDirection) {
    PHSLightDirectionOmniDirectional = 0,
    PHSLightDirectionUpwards = 1,
    PHSLightDirectionDownwards = 2,
    PHSLightDirectionHorizontal = 3,
    PHSLightDirectionVertical = 4,
    PHSLightDirectionUnknown = 5
};

typedef NS_ENUM(NSInteger, PHSLightFunction) {
    PHSLightFunctionFunctional = 0,
    PHSLightFunctionDecorative = 1,
    PHSLightFunctionMixed = 2,
    PHSLightFunctionUnknown = 3
};

@interface PHSLightConfiguration : PHSDeviceConfiguration

/**
 The Luminaire Unique id. This value will only be filled if a light point is part of multi-source luminaire
 */
@property (strong, nonatomic, readonly) NSString *luminaireUniqueId;

@property (nonatomic) PHSLightArchetype lightArchetype;

@property (nonatomic) PHSLightDirection lightDirection;

@property (nonatomic) PHSLightFunction lightFunction;

@property (strong, nonatomic) PHSLightStartUpState* lightStartUpState;

@end

