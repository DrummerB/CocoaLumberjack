//
//  InAppLogFormatter.m
//  CCNX Browser
//
//  Created by Balázs Faludi on 10.08.12.
//  Copyright (c) 2012 Balázs Faludi. All rights reserved.
//

#import "InAppLogFormatter.h"

@implementation InAppLogFormatter {
	int loggerCount;
	NSDateFormatter *threadUnsafeDateFormatter;
}

- (id)init
{
    if((self = [super init]))
    {
        threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
        [threadUnsafeDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [threadUnsafeDateFormatter setDateFormat:@"HH:mm:ss"];
    }
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *dateAndTime = [threadUnsafeDateFormatter stringFromDate:(logMessage->timestamp)];
    NSString *logMsg = logMessage->logMsg;
    
    return [NSString stringWithFormat:@"%@  %@\n", dateAndTime, logMsg];
}

- (void)didAddToLogger:(id <DDLogger>)logger
{
    loggerCount++;
    NSAssert(loggerCount <= 1, @"This logger isn't thread-safe");
}

- (void)willRemoveFromLogger:(id <DDLogger>)logger
{
    loggerCount--;
}


@end
