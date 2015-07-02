//
//  Stadium.h
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

// StadiumDelegate protocol lazily loads image data, if present.
@protocol StadiumDelegate <NSObject>
// Inform the delegate that image data is ready to show.
- (void)imageReady;
// Inform the delegate an error occurred.
- (void)connectionError:(NSError*)error;
@end

// This object is a container for the Stadium / JSON information
@interface Stadium : NSObject
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *ticketURL;
@property (nonatomic, strong) NSString *stateAbbr;
@property (nonatomic, strong) NSString *pCode;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *stadiumId;
@property (nonatomic, strong) NSString *tollFreePhone;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *stadiumDescription;
@property (nonatomic, strong) NSString *stadiumName;
@property (nonatomic, strong) NSString *imgURL;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property (nonatomic, strong) NSMutableArray *schedule;
@property (nonatomic, weak) id<StadiumDelegate> delegate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (UIImage *)getStadiumImage;

@end
