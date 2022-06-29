//
//  ZHCBaseViewController.m
//  HungryToolsOC_Example
//
//  Created by cmb on 2022/6/23.
//  Copyright © 2022 zhanghaichuan. All rights reserved.
//

#import "ZHCBaseViewController.h"

@interface ZHCBaseViewController ()

@end

@implementation ZHCBaseViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)zhc_configNavigationControllerDefaultAppearence:(UINavigationBar *)navigationBar {
    NSLog(@"base");
    navigationBar.backgroundColor = UIColor.whiteColor;
}

@end
