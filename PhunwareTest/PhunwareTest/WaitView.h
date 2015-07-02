//
//  WaitView.h
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import <Foundation/Foundation.h>

// Helper class that dynamically creates a superview with spinner.
@interface WaitView : NSObject

+ (void)hide;
+ (void)show;
+ (void)showWithMessage:(NSString *)message;

@end
