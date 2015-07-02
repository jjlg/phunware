//
//  MasterViewController.m
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "WaitView.h"
#import "AppDelegate.h"
#import "AppData.h"
#import "Stadium.h"
#import "Constants.h"

static NSString *MASTER_CELL_ID = @"MasterCellID";
#define TAG_STADIUM_NAME		(1)
#define TAG_STADIUM_ADDRESS		(2)

@interface MasterViewController ()
@end

@implementation MasterViewController

- (void)awakeFromNib {
	[super awakeFromNib];
	
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
	{
	    self.clearsSelectionOnViewWillAppear = NO;
	    self.preferredContentSize = CGSizeMake(320.0, 600.0);
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(stadiumDataReady)
												 name:NOTIF_STADIUM_DATA_LOADED
											   object:nil];

	self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
	
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)stadiumDataReady
{
	[self.tableView reloadData];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"showDetail"])
	{
	    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		const AppDelegate *appDelegate = [AppDelegate appDelegate];
		Stadium *stadium = [appDelegate.appData getStadiumDetails:indexPath.row];
	    DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
	    [controller setDetailItem:stadium];
	    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
	    controller.navigationItem.leftItemsSupplementBackButton = YES;
	}
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	const AppDelegate *appDelegate = [AppDelegate appDelegate];
	return [appDelegate.appData getStadiumCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MASTER_CELL_ID forIndexPath:indexPath];

	const AppDelegate *appDelegate = [AppDelegate appDelegate];
	Stadium *stadium = [appDelegate.appData getStadiumDetails:indexPath.row];
	
	UILabel *nameLabel = (UILabel*)[cell viewWithTag:TAG_STADIUM_NAME];
	UILabel *addrLabel = (UILabel*)[cell viewWithTag:TAG_STADIUM_ADDRESS];
	
	nameLabel.text = stadium.stadiumName;
	addrLabel.text = stadium.address;
	
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

@end
