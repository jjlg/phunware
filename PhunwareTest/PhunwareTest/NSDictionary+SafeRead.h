//
//  NSDictionary+SafeRead.h
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeRead)

- (id)safeObjectForKey:(id)key defaultValue:(id)defaultValue;
@end
