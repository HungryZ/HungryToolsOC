//
//  ZHCHomeViewController.m
//  HungryToolsOC
//
//  Created by zhanghaichuan on 03/04/2021.
//  Copyright (c) 2021 zhanghaichuan. All rights reserved.
//

#import "ZHCHomeViewController.h"
#import "ZHCView1Controller.h"


@interface ZHCHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation ZHCHomeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"HungryTools";
    [self initUI];
}

#pragma mark - Layout

- (void)initUI {
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *title = self.dataArray[indexPath.row][@"title"];
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *pushedVC = [self.dataArray[indexPath.row][@"controller"] new];
//    pushedVC.view.backgroundColor = self.mainTableView.backgroundColor;
    pushedVC.title = self.dataArray[indexPath.row][@"title"];
    [self.navigationController pushViewController:pushedVC animated:YES];
}

#pragma mark - User Interaction

#pragma mark - Helper

#pragma mark - Setter

#pragma mark - Getter

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTableView.separatorInsetReference = UITableViewSeparatorInsetFromAutomaticInsets;
        
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _mainTableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
            @{
                @"title" : @"VC1",
                @"controller" : [ZHCView1Controller class],
            },
        ];
    }
    return _dataArray;
}

@end
