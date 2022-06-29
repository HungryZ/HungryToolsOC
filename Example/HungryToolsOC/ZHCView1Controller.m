//
//  ZHCView1Controller.m
//  HungryToolsOC_Example
//
//  Created by cmb on 2022/6/23.
//  Copyright © 2022 zhanghaichuan. All rights reserved.
//

#import "ZHCView1Controller.h"
#import "ZHCView2Controller.h"

@interface ZHCView1Controller ()

@end

@implementation ZHCView1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"VC1";
    
    UIButton *button1 = [UIButton buttonWithTitle:@"jump1" titleColor:UIColor.blackColor fontSize:18 target:self action:@selector(button1Clicked:)];
    button1.frame = CGRectMake(20, 100, 100, 100);
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithTitle:@"jump2" titleColor:UIColor.blackColor fontSize:18 target:self action:@selector(button2Clicked:)];
    button2.frame = CGRectMake(160, 100, 100, 100);
    [self.view addSubview:button2];
}

- (void)button1Clicked:(UIButton *)sender {
    [self.navigationController pushViewController:[ZHCView1Controller new] animated:YES];
}

- (void)button2Clicked:(UIButton *)sender {
    [self.navigationController pushViewController:[ZHCView2Controller new] animated:YES];
}

- (void)zhc_configNavigationControllerCustomAppearence:(UINavigationBar *)navigationBar {
    NSLog(@"VC1");
    navigationBar.backgroundColor = UIColor.purpleColor;
}

@end

//@implementation ZHCView1Controller (OverWrite)
//
//- (void)button1Clicked:(UIButton *)sender {
//
//}
//
//@end
