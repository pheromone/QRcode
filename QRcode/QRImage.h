//
//  QRImage.h
//  QRcode
//
//  Created by Shaoting Zhou on 2017/11/19.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@interface QRImage : NSObject

+ (UIImage *)imageWithQRString:(NSString *)string;  //把string转换我image
+ (NSString *)stringFromCiImage:(CIImage *)ciimage; //把CIImage转换为string

@end
