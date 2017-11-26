//
//  ScanViewController.m
//  QRcode
//
//  Created by Shaoting Zhou on 2017/11/19.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描二维码";
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, 200, 50)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.userInteractionEnabled = NO;
    [self.view addSubview:self.textField];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:(UIBarButtonItemStylePlain) target:self action:@selector(presentImagePicker)];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startScan];
    
}

#pragma  mark - 开始扫描
- (void)startScan{
    if([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusAuthorized || [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusNotDetermined ){
        self.session = [[AVCaptureSession alloc]init];
        AVCaptureDeviceInput * input = [[AVCaptureDeviceInput alloc]initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] error:nil];
        if(input){
            [self.session addInput:input];
        }
        
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        if(output){
            [self.session addOutput:output];
        }
        
        NSMutableArray * ary = [[NSMutableArray alloc]init];
        if([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]){
            [ary addObject:AVMetadataObjectTypeQRCode];
        }
        if([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]){
            [ary addObject:AVMetadataObjectTypeEAN13Code];
        }
        if([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]){
            [ary addObject:AVMetadataObjectTypeEAN8Code];
        }
        if([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]){
            [ary addObject:AVMetadataObjectTypeCode128Code];
        }
        output.metadataObjectTypes = ary;
        
        AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        layer.frame = CGRectMake((self.view.bounds.size.width - 300)/2, 164, 300, 300);
        [self.view.layer addSublayer:layer];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width - 300)/2, 164, 300, 300)];
        
        [self.view addSubview:imageView];
        [self.session startRunning];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate代理方法
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString * str = nil;
    for (AVMetadataObject * obj in metadataObjects) {
        if([obj.type isEqualToString:AVMetadataObjectTypeQRCode]){
            str = [(AVMetadataMachineReadableCodeObject *)obj stringValue];
            [self.session startRunning];
            break;
        }
    }
    self.textField.text = str;
}

#pragma mark - UIImagePickerControllerDelegate代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CIImage * ciimage = [[CIImage alloc]initWithImage:image];
    NSString * str = [QRImage stringFromCiImage:ciimage];
    self.textField.text = str;
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 弹出相册
- (void)presentImagePicker{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
