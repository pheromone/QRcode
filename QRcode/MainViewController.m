//
//  MainViewController.m
//  QRcode
//
//  Created by Shaoting Zhou on 2017/11/18.
//  Copyright © 2017年 Shaoting Zhou. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    self.title = @"生成二维码";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"扫描" style:(UIBarButtonItemStylePlain) target:self action:@selector(scangQRimage)];
}

-(void)setUI{
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 200, 200, 50)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(230, 200, 120, 50)];
    [btn setTitle:@"生成二维码" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(makeQRcode) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    self.qrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 300, 200, 200)];
    [self.view addSubview:self.qrImageView];
    
    
}
#pragma mark - 生成二维码
-(void)makeQRcode{
    [self.textField resignFirstResponder];
    UIImage * img = [QRImage imageWithQRString:self.textField.text];
    self.qrImageView.image = img;
}

#pragma mark - push到扫描界面
-(void)scangQRimage{
    ScanViewController * scanVC = [[ScanViewController alloc]init];
    [self.navigationController pushViewController:scanVC animated:NO];
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
