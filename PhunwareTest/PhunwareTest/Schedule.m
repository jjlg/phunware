//
//  Schedule.m
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import "Schedule.h"
#import "NSDictionary+SafeRead.h"
#import "Constants.h"

static const NSString *kStartDateKey	= @"start_date";
static const NSString *kEndDateKey		= @"end_date";

static NSDateFormatter *s_dateFormatter = nil;

@implementation Schedule

- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
	// Downside of a static is it likely creates a memory leak, but it may
	// be better than allocating a lot of these formatters per instance!
	if (s_dateFormatter == nil)
	{
		s_dateFormatter = [[NSDateFormatter alloc] init];
		[s_dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss ZZZ"];
	}
	
	self = [super init];
	if (self)
	{
		self.startDate = [s_dateFormatter dateFromString:[dictionary safeObjectForKey:kStartDateKey defaultValue:[NSDate date]]];
		self.endDate   = [s_dateFormatter dateFromString:[dictionary safeObjectForKey:kEndDateKey defaultValue:[NSDate date]]];
	}
	
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"Start: %@ - End: %@", self.startDate, self.endDate];
}

@end
