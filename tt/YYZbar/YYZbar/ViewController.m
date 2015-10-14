//
//  ViewController.m
//  二维码
//
//  Created by yangyao on 15/10/14.
//  Copyright © 2015年 yangyao. All rights reserved.
//

#import "ViewController.h"
#import "ZBarSDK.h"
@interface ViewController ()<ZBarReaderDelegate>
{
    UIImageView *_myimage;
    UIButton    *_myButton;
    UILabel     *_myLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 320, 80)];
    _myLabel.backgroundColor = [UIColor whiteColor];
    _myLabel.numberOfLines = 0;
    _myLabel.textAlignment = NSTextAlignmentCenter;
    _myLabel.textColor = [UIColor redColor];
    _myLabel.layer.borderWidth = 1.0;
    _myLabel.layer.borderColor = [UIColor greenColor].CGColor;
    [self.view addSubview:_myLabel];
    
    _myimage = [[UIImageView alloc]initWithFrame:CGRectMake(50, 170, 220, 220)];
    _myimage.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_myimage];
    
    _myButton = [[UIButton alloc]initWithFrame:CGRectMake(110, 440, 100, 40)];
    _myButton.backgroundColor = [UIColor purpleColor];
    _myButton.layer.cornerRadius = 3.0;
    [_myButton setTitle:@"点击扫描" forState:UIControlStateNormal];
    [_myButton addTarget:self action:@selector(buttonPresser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myButton];
    
}

- (void)buttonPresser:(UIButton *)sender{
    ZBarReaderViewController * reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    ZBarImageScanner * scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    reader.showsZBarControls = YES;
    [self presentViewController:reader animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol * symbol;
    for(symbol in results)
        break;
    
    _myimage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    _myLabel.text = symbol.data;

}

@end
