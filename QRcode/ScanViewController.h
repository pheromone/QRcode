//
//  ScanViewController.h
//  QRcode
//
//  Created by Shaoting Zhou on 2017/11/19.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "QRImage.h"
@interface ScanViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) AVCaptureSession * session;
@property (nonatomic,strong) UITextField * textField;

@end
