/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

typedef NS_ENUM(NSInteger, PHELightIteratorEffectOrder) {
    PHELightIteratorEffectOrderLeftRight,
    PHELightIteratorEffectOrderFrontBack,
    PHELightIteratorEffectOrderClockWise,
    PHELightIteratorEffectOrderInOut,
    PHELightIteratorEffectOrderRandom,
    PHELightIteratorEffectOrderGroup
};

typedef NS_ENUM(NSInteger, PHELightIteratorEffectMode) {
    PHELightIteratorEffectModeSingle,
    PHELightIteratorEffectModeCycle,
    PHELightIteratorEffectModeBounce
};
