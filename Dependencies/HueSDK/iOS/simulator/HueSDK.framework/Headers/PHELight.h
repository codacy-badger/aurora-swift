/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

#import "PHELocation.h"
#import "PHEColor.h"

@interface PHELight : NSObject

@property (nonatomic, assign) NSString*              identifier;
@property (nonatomic, strong) PHELocation*           location;
@property (nonatomic, strong) PHEColor* color;

- (instancetype)initWithIdentifier:(NSString*)identifier andLocation:(PHELocation *)location;

@end
