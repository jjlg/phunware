//
//  UIImage+Resize.h
//  PhunwareTest
//
//  Created by Jeremy Jessup on 7/1/15.
//  Copyright (c) 2015 Looking Glass Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Resize)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@end
