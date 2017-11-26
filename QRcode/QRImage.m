//
//  QRImage.m
//  QRcode
//
//  Created by Shaoting Zhou on 2017/11/19.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import "QRImage.h"

@implementation QRImage

#pragma mark - 把string转换为Image
+ (UIImage *)imageWithQRString:(NSString *)string{
    NSData * stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter * qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"]; //过滤器
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];  //纠错等级
    UIImage * image =  [self createUIImageFromCIImage:qrFilter.outputImage withSize:300];
    return image;
}


#pragma mark - CIImgae ->  UIImage
+ (UIImage *)createUIImageFromCIImage:(CIImage *)image withSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
    
}


#pragma mark - 把image转换为string
+ (NSString *)stringFromCiImage:(CIImage *)ciimage{
    NSString * content = nil;
    if(!ciimage){
        return  content;
    }
    CIDetector * detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:[CIContext contextWithOptions:nil] options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray * features = [detector featuresInImage:ciimage];
    if(features.count){
        for (CIFeature * feature in features) {
            if([feature isKindOfClass:[CIQRCodeFeature class]]){
                content = ((CIQRCodeFeature *)feature).messageString;
                break;
            }
        }
    }else{
        NSLog(@"解析失败,确保硬件支持");
    }
        
    return content;
}
@end
