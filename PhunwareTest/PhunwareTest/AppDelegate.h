//
//  AppDelegate.h
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppData;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// AppData stores our data model
@property (nonatomic, strong) AppData *appData;

// Convenience accessor to the shared app delegate
+ (AppDelegate*)appDelegate;

@end

