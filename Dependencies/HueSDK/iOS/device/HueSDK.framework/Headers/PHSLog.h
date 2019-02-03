/*******************************************************************************
 Copyright (C) 2018 Philips Lighting Holding B.V.
 All Rights Reserved.
 ********************************************************************************/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PHSLogLevel) {
    PHSLogLevelOff   = 0, // Disable logging
    PHSLogLevelError = 1,
    PHSLogLevelWarn  = 2,
    PHSLogLevelInfo  = 3,
    PHSLogLevelDebug = 4
};

typedef NS_ENUM(NSInteger, PHSLogComponent) {
    PHSLogComponentUnknown         = 1,
    PHSLogComponentCore            = 1 << 1,
    PHSLogComponentSupport         = 1 << 2,
    PHSLogComponentNetwork         = 1 << 3,
    PHSLogComponentWrapper         = 1 << 4,
    PHSLogComponentClient          = 1 << 5,
    PHSLogComponentColorConversion = 1 << 6,
    PHSLogComponentStream          = 1 << 7,
    PHSLogComponentStreamDtls      = 1 << 8,
    PHSLogComponentAppCore         = 1 << 9,
    PHSLogComponentAll             = (1 << 11) - 1,
};

@interface PHSLog : NSObject

/**
 Set log level for the console logger
 @param logLevel The logging level
 */
+ (void)setConsoleLogLevel:(PHSLogLevel)logLevel;

/**
 Set log level for the console logger
 @param logLevel   The logging level
 @param components The enabled components
 */
+ (void)setConsoleLogLevel:(PHSLogLevel)logLevel enabledComponents:(PHSLogComponent)components;

/**
 Set log level for the file logger
 Logs will be saved in the persistence storage folder in the format YYYY-MM-DDTHH-MM-SS.sss.log
 @param logLevel   The logging level
 @param components The enabled component
 */
+ (void)setFileLogLevel:(PHSLogLevel)logLevel enabledComponents:(PHSLogComponent)components;

@end
