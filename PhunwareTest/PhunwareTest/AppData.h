//
//  AppData.h
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Stadium;

// AppDataDelegate Protocol allows the AppData class to notify
// that feed data has been loaded (or not).
@protocol AppDataDelegate <NSObject>
- (void)stadiumDataReady;
- (void)requestStadiumDataFailedWithError:(NSError*)error;
@end


@interface AppData : NSObject
// Our delegate
@property (nonatomic, weak) id<AppDataDelegate> delegate;

// Request stadium data
- (void)fetchStadiumData;

// Number of stadium data elements
- (NSUInteger)getStadiumCount;

// Retrieve a specific stadium data element
- (Stadium*)getStadiumDetails:(NSUInteger)index;
@end
