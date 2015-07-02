//
//  AppData.m
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import "AppData.h"
#import "Constants.h"
#import "Stadium.h"

@interface AppData ()
@property (nonatomic, strong) NSMutableArray *stadiumList;						// list of stadiums
@end

@implementation AppData

// Request the data asynchronously.
- (void)fetchStadiumData
{
	NSURL *url = [[NSURL alloc] initWithString:STADIUM_URL];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	
	[NSURLConnection sendAsynchronousRequest:request
									   queue:[[NSOperationQueue alloc] init]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
							   if (connectionError)
							   {
								   // notify on failure
								   [self.delegate requestStadiumDataFailedWithError:connectionError];
							   }
							   else
							   {
								   // decode / parse the data
								   [self decodeStadiumJSON:data];
							   }
						   }];
}


// This method decodes the NSData/ JSON feed.
- (void)decodeStadiumJSON:(NSData*)data
{
	NSError *error;
	id rootObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
	
	if (error != nil)
	{
		[self.delegate requestStadiumDataFailedWithError:error];
	}
	
	self.stadiumList = [NSMutableArray array];
	
	// If the root data object is an array parse each element
	if ([rootObj isKindOfClass:[NSArray class]])
	{
		NSArray *jsonArray = (NSArray*)rootObj;
		
		for (NSDictionary *itemDict in jsonArray)
		{
			Stadium *stadium = [[Stadium alloc] initWithDictionary:itemDict];
			[self.stadiumList addObject:stadium];
		}

		// Everything parsed and ready!
		[self.delegate stadiumDataReady];
	}
	else
	{
		// Not an array?  Not sure how to process this data, so send an error.
		NSDictionary *errorDict = @{NSLocalizedDescriptionKey: NSLocalizedString(@"Unknown Type", nil)};
		NSError *unknownFormat = [NSError errorWithDomain:ERROR_CODE_DOMAIN code:ERROR_UNKNNOWN_FORMAT userInfo:errorDict];
		[self.delegate requestStadiumDataFailedWithError:unknownFormat];
	}
}

- (NSUInteger)getStadiumCount
{
	return [self.stadiumList count];
}

- (Stadium*)getStadiumDetails:(NSUInteger)index
{
	if (index > self.stadiumList.count)
	{
		return nil;
	}
	
	return [self.stadiumList objectAtIndex:index];
}

@end
