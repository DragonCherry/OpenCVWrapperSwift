//
//  OpenCVWrapper.m
//  OpenCVWrapperSwift
//
//  Created by DragonCherry on 1/10/17.
//  Copyright © 2017 DragonCherry. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"

@implementation OpenCVWrapper

- (NSString *)versionString {
    return [NSString stringWithFormat:@"OpenCV version: %s", CV_VERSION];
}

- (double)blurryMetricsFromCVMat:(cv::Mat)matImage {
    
    cv::Mat grayImage;
    cv::Mat laplacianImage;
    
    cv::cvtColor(matImage, grayImage, CV_BGR2GRAY);
    matImage.convertTo(laplacianImage, CV_8UC1);
    
    cv::Laplacian(grayImage, laplacianImage, CV_8U);
    cv::Mat laplacianImage8bit;
    laplacianImage.convertTo(laplacianImage8bit, CV_8U);
    
    unsigned char *pixels = laplacianImage8bit.data;
    unsigned long loop = laplacianImage8bit.elemSize() * laplacianImage8bit.total();
    double totalLap = 0;
    
    for (int i = 0; i < loop; i++) {
        totalLap += pixels[i];
    }
    return totalLap / loop;
}

- (double)blurryMetricsFromSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    return [self blurryMetricsFromCVMat: [self convertCMSampleBufferToCVMat: sampleBuffer]];
}

- (double)blurryMetricsFromImage:(UIImage *)image {
    return [self blurryMetricsFromCVMat: [self convertUIImageToCVMat:image]];
}

- (cv::Mat)convertUIImageToCVMat:(UIImage *)image {
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}

- (cv::Mat)convertCMSampleBufferToCVMat:(CMSampleBufferRef)sampleBuffer {
    CVImageBufferRef imgBuf = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // lock the buffer
    CVPixelBufferLockBaseAddress(imgBuf, 0);
    
    // get the address to the image data
    void *imgBufAddr = CVPixelBufferGetBaseAddressOfPlane(imgBuf, 0);
    
    // get image properties
    int w = (int)CVPixelBufferGetWidth(imgBuf);
    int h = (int)CVPixelBufferGetHeight(imgBuf);
    
    // create the cv mat
    cv::Mat image;
    image.create(h, w, CV_8UC4);
    memcpy(image.data, imgBufAddr, w * h);
    
    // unlock again
    CVPixelBufferUnlockBaseAddress(imgBuf, 0);
    
    return image;
}

@end
