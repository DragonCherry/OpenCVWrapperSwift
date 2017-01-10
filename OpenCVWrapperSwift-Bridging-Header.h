//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "OpenCVWrapper.h"

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

#import <Availability.h>

#ifndef __IPHONE_8_0
#warning "This project uses features only available in iOS SDK 8.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#endif
