//
//  WaitView.m
//  PhunwareTest
//
//  Created by Jeremy Jessup on 6/30/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import "WaitView.h"
#import <UIKit/UIKit.h>

#define ANIM_DURATION		0.25f

static UIView *_view;

@implementation WaitView

+ (void)hide
{
	if (_view != nil)
	{
		[UIView animateWithDuration:ANIM_DURATION
						 animations:^{
							 _view.alpha = 0.0f;
						 }
						 completion:^(BOOL finished) {
							 [_view removeFromSuperview];
							 _view = nil;
						 }];
	}
}

+ (void)show
{
	[self showWithMessage:@"Please wait..."];
}

+ (void)showWithMessage:(NSString *)message
{
	if (_view == nil)
	{
		UIWindow *w = [UIApplication sharedApplication].keyWindow;
		if (!w)
		{
			w = [[UIApplication sharedApplication].windows objectAtIndex:0];
		}
		
		UIView *parentView = [[w subviews] objectAtIndex:0];
		
		_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, parentView.frame.size.width, parentView.frame.size.height)];
		_view.backgroundColor = [UIColor colorWithRed:25.0f/255.0f green:25.0f/255.0f blue:25.0f/255.0f alpha:0.7f];
		_view.opaque = NO;
		_view.layer.masksToBounds = YES;
		_view.alpha = 0.0f;
		
		UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
		messageLabel.textAlignment = NSTextAlignmentCenter;
		messageLabel.text	= message;
		messageLabel.textColor = [UIColor whiteColor];
		[_view addSubview:messageLabel];
		[messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
		NSLayoutConstraint* cn = [NSLayoutConstraint constraintWithItem:messageLabel
															  attribute:NSLayoutAttributeCenterX
															  relatedBy:NSLayoutRelationEqual
																 toItem:_view
															  attribute:NSLayoutAttributeCenterX
															 multiplier:1.0
															   constant:0];
		[_view addConstraint:cn];
		cn = [NSLayoutConstraint constraintWithItem:messageLabel
										  attribute:NSLayoutAttributeCenterY
										  relatedBy:NSLayoutRelationEqual
											 toItem:_view
										  attribute:NSLayoutAttributeCenterY
										 multiplier:1.0
										   constant:-40];
		[_view addConstraint:cn];
		
		UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] init];
		spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
		[spinner startAnimating];
		[_view addSubview:spinner];
		[spinner setTranslatesAutoresizingMaskIntoConstraints:NO];
		cn = [NSLayoutConstraint constraintWithItem:spinner
										  attribute:NSLayoutAttributeCenterX
										  relatedBy:NSLayoutRelationEqual
											 toItem:_view
										  attribute:NSLayoutAttributeCenterX
										 multiplier:1.0
										   constant:0];
		[_view addConstraint:cn];
		cn = [NSLayoutConstraint constraintWithItem:spinner
										  attribute:NSLayoutAttributeCenterY
										  relatedBy:NSLayoutRelationEqual
											 toItem:_view
										  attribute:NSLayoutAttributeCenterY
										 multiplier:1.0
										   constant:0];
		[_view addConstraint:cn];
		
		[UIView animateWithDuration:ANIM_DURATION
						 animations:^{
							 [parentView addSubview:_view];
							 [_view setAlpha:1.0f];
						 }];
		
	}
}

@end
