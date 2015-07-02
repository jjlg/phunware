//
//  NSDictionary+SafeRead.m
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import "NSDictionary+SafeRead.h"

@implementation NSDictionary (SafeRead)

- (id)safeObjectForKey:(id)key defaultValue:(id)defaultValue
{
	id obj = [self objectForKey:key];
	if ((obj == nil) || ([obj isKindOfClass:[NSNull class]]))
	{
		return defaultValue;
	}
	
	return obj;
}

@end
