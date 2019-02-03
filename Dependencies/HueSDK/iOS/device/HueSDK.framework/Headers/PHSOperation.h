/*******************************************************************************
Copyright (C) 2018 Philips Lighting Holding B.V.
All Rights Reserved.
********************************************************************************/

#import <Foundation/Foundation.h>

@protocol PHSOperation <NSObject>
- (void) wait;
- (void) cancel;
- (BOOL) isCancelable;
@end