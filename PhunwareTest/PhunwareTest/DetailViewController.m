//
//  DetailViewController.m
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import "DetailViewController.h"
#import "Stadium.h"
#import "Schedule.h"
#import "UIImage+Resize.h"

// There are three cell prototypes in this example -
//  - UIImageView to store a photo
//  - UILabels for the addresses
//  - UILabels for the schedule results
static NSString *kStadiumImageCellID	= @"StadiumImageCell";
static NSString *kStadiumAddrCellID		= @"StadiumAddrCell";
static NSString *kStadiumScheduleCellID = @"StadiumScheduleCell";

// Tags to allow access to the control views
#define TAG_STADIUM_IMAGE				(1)
#define TAG_STADIUM_ADDR_NAME			(1)
#define TAG_STADIUM_ADDR_STREET			(2)
#define TAG_STADIUM_SCHEDULE			(1)

// I like using an enum for table sections because using an enum lends itself to
// easier (re)configuration if sections need to move or grow.
typedef NS_ENUM(NSUInteger, TableViewSections)
{
	kSection_Image,
	kSection_Name,
	kSection_Schedule,
	
	kSection_Max,
};


@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate, StadiumDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDateFormatter *startDateFormatter;
@property (nonatomic, strong) NSDateFormatter *endDateFormatter;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Stadium*)newDetailItem
{
	if (_detailItem != newDetailItem)
	{
	    _detailItem = newDetailItem;
		_detailItem.delegate = self;
	        
	    // Update the view.
	    [self configureView];
	}
}

- (void)configureView
{
	// Update the user interface for the detail item.
	if (self.detailItem)
	{
	    self.detailDescriptionLabel.text = [self.detailItem description];
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	// If the item is set, hide the instruction text.
	self.detailDescriptionLabel.hidden = (self.detailItem != nil);
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self configureView];
	
	// This feels like something of a hack - in iOS7, the table view header is padded into the view.
	// I find this unathestic and setting the edges to none forces the UIKit to top-align it.
	// Maybe there's a more elegant way to get this behavior.
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	// Two date formatters because we're going to use different parts from both dates.
	// Ironically, this proved to be one of the more subtle problems - the dates in the JSON feed came
	// in as NSStrings which took some debugging to discern and fix!
	NSString *startDateFormatString = [NSDateFormatter dateFormatFromTemplate:@"EEEE M/dd h:mm a" options:0 locale:[NSLocale currentLocale]];
	self.startDateFormatter = [[NSDateFormatter alloc] init];
	[self.startDateFormatter setDateFormat:startDateFormatString];
	
	NSString *endDateFormatString = [NSDateFormatter dateFormatFromTemplate:@"h:mm a" options:0 locale:[NSLocale currentLocale]];
	self.endDateFormatter = [[NSDateFormatter alloc] init];
	[self.endDateFormatter setDateFormat:endDateFormatString];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - StadiumImage Delegate

// Stadium class defines a couple protocol methods to signal this view that the image data has loaded
// without blocking the main thread.
- (void)imageReady
{
	// Reload just the cell affected by the image change.
	NSIndexPath *rowToReload = [NSIndexPath indexPathForRow:0 inSection:kSection_Image];
	[self.tableView reloadRowsAtIndexPaths:@[rowToReload] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)connectionError:(NSError *)error
{
	// TODO: handle connection error
}

#pragma mark - UITableView DataSource / Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (self.detailItem == nil)
	{
		return 0;
	}
	
	return kSection_Max;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// TODO: make these constants at the top of the interface
	switch (indexPath.section)
	{
		case kSection_Image:
			return 215.0f;
			break;
			
		case kSection_Name:
			return 62.0f;
			break;
			
		case kSection_Schedule:
			return 25.0f;
			break;
	}

	return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	// TODO: make these constants at the top of the interface
	switch (section)
	{
		case kSection_Image:
			return 0.0f;
			break;
			
		case kSection_Name:
			return 10.0f;
			break;
			
		case kSection_Schedule:
			return 25.0f;
			break;
	}
	
	return 44.0f;
}

// Force the header view to be clear to allow some pad between sections
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *v = [[UIView alloc] init];
	v.backgroundColor = [UIColor clearColor];
	return v;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.detailItem == nil)
	{
		return 0;
	}
	
	NSInteger rows = 0;
	switch (section)
	{
		case kSection_Image:	rows = 1; break;
		case kSection_Name:		rows = 1; break;
		case kSection_Schedule:	rows = self.detailItem.schedule.count; break;
	}
	
	return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger section = indexPath.section;
	
	UITableViewCell *cell;
	
	switch (section)
	{
		case kSection_Image:
		{
			cell = [tableView dequeueReusableCellWithIdentifier:kStadiumImageCellID forIndexPath:indexPath];
			UIImageView *imageView = (UIImageView*)[cell viewWithTag:TAG_STADIUM_IMAGE];
			imageView.image = [UIImage imageWithImage:[self.detailItem getStadiumImage] scaledToSize:imageView.frame.size];
		}
			break;
			
		case kSection_Name:
		{
			cell = [tableView dequeueReusableCellWithIdentifier:kStadiumAddrCellID forIndexPath:indexPath];
			UILabel *nameLabel = (UILabel*)[cell viewWithTag:TAG_STADIUM_ADDR_NAME];
			UILabel *addrLabel = (UILabel*)[cell viewWithTag:TAG_STADIUM_ADDR_STREET];
			nameLabel.text = self.detailItem.stadiumName;
			addrLabel.text = [NSString stringWithFormat:@"%@\n%@, %@ %@", self.detailItem.address, self.detailItem.city, self.detailItem.stateAbbr, self.detailItem.zipCode];
		}
			break;
			
		case kSection_Schedule:
		{
			cell = [tableView dequeueReusableCellWithIdentifier:kStadiumScheduleCellID forIndexPath:indexPath];
			
			Schedule *s = [self.detailItem.schedule objectAtIndex:indexPath.row];
			UILabel *dateLabel = (UILabel*)[cell viewWithTag:TAG_STADIUM_SCHEDULE];
			dateLabel.text = [NSString stringWithFormat:@"%@ to %@", [self.startDateFormatter stringFromDate:s.startDate], [self.endDateFormatter stringFromDate:s.endDate]];
		}
			break;
	}
	
	return cell;
}

@end
