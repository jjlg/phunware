//
//  Stadium.m
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import "Stadium.h"
#import "NSDictionary+SafeRead.h"
#import "Constants.h"
#import "Schedule.h"
#import <UIKit/UIKit.h>

#define DEFAULT_IMAGE_NAME (@"noimage_big")

static const NSString *kZipCodeKey		= @"zip";
static const NSString *kPhoneKey		= @"phone";
static const NSString *kTicketURLKey	= @"ticket_link";
static const NSString *kStateAbbrKey	= @"state";
static const NSString *kpCodeKey		= @"pcode";
static const NSString *kCityKey			= @"city";
static const NSString *kStadiumIdKey	= @"id";
static const NSString *kTollFreePhoneKey = @"toolfreephone";
static const NSString *kAddressKey		= @"address";
static const NSString *kStadiumDescKey	= @"description";
static const NSString *kStadiumNameKey	= @"name";
static const NSString *kImageURLKey		= @"image_url";
static const NSString *kLongitudeKey	= @"longitude";
static const NSString *kLatitudeKey		= @"latitude";
static const NSString *kScheduleKey		= @"schedule";

@interface Stadium ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL fetchInProgress;
@end

@implementation Stadium

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self)
	{
		self.zipCode		= [dictionary safeObjectForKey:kZipCodeKey defaultValue:VALUE_UNSET_STRING];
		self.phone			= [dictionary safeObjectForKey:kPhoneKey defaultValue:VALUE_UNSET_STRING];
		self.ticketURL		= [dictionary safeObjectForKey:kTicketURLKey defaultValue:VALUE_UNSET_STRING];
		self.stateAbbr		= [dictionary safeObjectForKey:kStateAbbrKey defaultValue:VALUE_UNSET_STRING];
		self.pCode			= [dictionary safeObjectForKey:kpCodeKey defaultValue:VALUE_UNSET_STRING];
		self.city			= [dictionary safeObjectForKey:kCityKey defaultValue:VALUE_UNSET_STRING];
		self.stadiumId		= [dictionary safeObjectForKey:kStadiumIdKey defaultValue:VALUE_UNSET_STRING];
		self.tollFreePhone	= [dictionary safeObjectForKey:kTollFreePhoneKey defaultValue:VALUE_UNSET_STRING];
		self.address		= [dictionary safeObjectForKey:kAddressKey defaultValue:VALUE_UNSET_STRING];
		self.stadiumDescription = [dictionary safeObjectForKey:kStadiumDescKey defaultValue:VALUE_UNSET_STRING];
		self.stadiumName	= [dictionary safeObjectForKey:kStadiumNameKey defaultValue:VALUE_UNSET_STRING];
		self.imgURL			= [dictionary safeObjectForKey:kImageURLKey defaultValue:VALUE_UNSET_STRING];
		self.latitude		= [[dictionary safeObjectForKey:kLatitudeKey defaultValue:@0] doubleValue];
		self.longitude		= [[dictionary safeObjectForKey:kLongitudeKey defaultValue:@0] doubleValue];
		
		self.schedule		= [NSMutableArray array];
		
		NSArray *scheduleArray = [dictionary safeObjectForKey:kScheduleKey defaultValue:[NSArray array]];
		for (NSDictionary *scheduleDict in scheduleArray)
		{
			Schedule *s = [[Schedule alloc] initWithDictionary:scheduleDict];
			[self.schedule addObject:s];
		}
	}
	
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"id: %@ - name: .%@. - URL: .%@.", self.stadiumId, self.stadiumName, self.imgURL];
}

- (void)fetchImage
{
	NSURL *url = [[NSURL alloc] initWithString:self.imgURL];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	self.fetchInProgress = TRUE;
	
	[NSURLConnection sendAsynchronousRequest:request
									   queue:[[NSOperationQueue alloc] init]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
							   self.fetchInProgress = FALSE;
							   if (connectionError)
							   {
								   [self.delegate connectionError:connectionError];
							   }
							   else
							   {
								   self.image = [UIImage imageWithData:data];
								   dispatch_async(dispatch_get_main_queue(), ^{
									   [self.delegate imageReady];
								   });
							   }
						   }];
}

- (UIImage *)getStadiumImage
{
	if (self.image != nil)
	{
		return self.image;
	}
	else if ([self.imgURL length] && !self.fetchInProgress)
	{
		[self fetchImage];
	}
	
	return [UIImage imageNamed:DEFAULT_IMAGE_NAME];
}

@end
