//
//  UIImage+Resize.m
//  PhunwareTest
//
//  Created by Jeremy Jessup on 7/1/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

// Helper method to resize image to fit inside a control
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
	UIGraphicsBeginImageContext(newSize);
	[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end
