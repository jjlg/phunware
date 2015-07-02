//
//  Constants.h
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#ifndef PhunwareTest_Constants_h
#define PhunwareTest_Constants_h

// URL
static NSString *STADIUM_URL = @"https://s3.amazonaws.com/jon-hancock-phunware/nflapi-static.json";

// Error Codes
static NSUInteger ERROR_UNKNNOWN_FORMAT = 0;

// Error Domain
static NSString *ERROR_CODE_DOMAIN = @"com.lookingglass";

// Constants
#define VALUE_UNSET_NUMBER      [NSNumber numberWithInteger:0]
#define VALUE_UNSET_STRING      @""

// Notifications
static NSString *NOTIF_STADIUM_DATA_LOADED = @"Notification_Stadium_Data_Loaded";

#endif
