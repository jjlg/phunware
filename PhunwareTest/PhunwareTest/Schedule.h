//
//  Schedule.h
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Schedule : NSObject
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
