//
//  AppDelegate.m
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "AppData.h"
#import "WaitView.h"
#import "Constants.h"

@interface AppDelegate () <UISplitViewControllerDelegate, AppDataDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
	UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
	navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
	splitViewController.delegate = self;

	// allocate and become a delegate to the appData object
	self.appData = [[AppData alloc] init];
	self.appData.delegate = self;
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

	// If there is no data loaded, show the wait view while it's being fetched asynchronously
	if ([self.appData getStadiumCount] == 0)
	{
		[WaitView showWithMessage:@"Loading..."];
		[self.appData fetchStadiumData];
	}
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate*)appDelegate
{
	return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - AppData Delegate

// Called when data has been retrieved and parsed
- (void)stadiumDataReady
{
	// Hide the spinner
	[WaitView hide];

	// Post notification to any interested views
	[[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_STADIUM_DATA_LOADED object:self];
}

- (void)requestStadiumDataFailedWithError:(NSError *)error
{
	// TODO: handle this appropriately!
}

@end
