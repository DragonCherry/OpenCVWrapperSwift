//
//  OpenCVWrapper.h
//  OpenCVWrapperSwift
//
//  Created by DragonCherry on 1/10/17.
//  Copyright © 2017 DragonCherry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

@interface OpenCVWrapper : NSObject
    
- (NSString *)versionString;
- (double)blurryMetricsFromImage:(UIImage *)image samplingFrequency:(int)frequency;
- (double)blurryMetricsFromSampleBuffer:(CMSampleBufferRef)sampleBuffer samplingFrequency:(int)frequency;
    
@end
