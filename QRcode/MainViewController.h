//
//  MainViewController.h
//  QRcode
//
//  Created by Shaoting Zhou on 2017/11/18.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRImage.h"
#import "ScanViewController.h"

@interface MainViewController : UIViewController
@property (nonatomic,strong) UIImageView * qrImageView;
@property (nonatomic,strong) UITextField * textField;
@end
