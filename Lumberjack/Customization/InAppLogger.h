//
//  InAppLogger.h
//  CCNX Browser
//
//  Created by Balázs Faludi on 10.08.12.
//  Copyright (c) 2012 Balázs Faludi. All rights reserved.
//

#import "DDFileLogger.h"
#import "DDLog.h"

@class InAppLogger;


@protocol InAppLoggerDelegate <NSObject>

- (void)logger:(InAppLogger *)logger loggedMessage:(NSString *)message;

@end


@interface InAppLogger : DDFileLogger

@property (nonatomic, /*weak*/) id<InAppLoggerDelegate> delegate;
@property (nonatomic, readonly) DDLogFileInfo *currentLogFileInfo;

@end
