//
//  DetailViewController.h
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Stadium;

@interface DetailViewController : UIViewController

@property (weak, nonatomic) Stadium *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

