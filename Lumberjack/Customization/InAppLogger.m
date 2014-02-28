//
//  InAppLogger.m
//  CCNX Browser
//
//  Created by Balázs Faludi on 10.08.12.
//  Copyright (c) 2012 Balázs Faludi. All rights reserved.
//

#import "InAppLogger.h"
#import "InAppLogFormatter.h"

@interface DDFileLogger ()
- (DDLogFileInfo *)currentLogFileInfo;
@end

@implementation InAppLogger

- (id)init
{
    self = [super init];
    if (self) {
        [self setLogFormatter:[[InAppLogFormatter alloc] init]];
    }
    return self;
}

- (void)logMessage:(DDLogMessage *)logMessage
{
	[super logMessage:logMessage];
	
	NSString *logMsg = logMessage->logMsg;
	if (formatter) {
		logMsg = [formatter formatLogMessage:logMessage];
	}
	
	if (logMsg) {
		if (![logMsg hasSuffix:@"\n"]) {
			logMsg = [logMsg stringByAppendingString:@"\n"];
		}
		if ([self.delegate respondsToSelector:@selector(logger:loggedMessage:)]) {
			[self.delegate logger:self loggedMessage:logMsg];
		}
	}
}

- (DDLogFileInfo *)currentLogFileInfo {
	return [super currentLogFileInfo];
}

@end
