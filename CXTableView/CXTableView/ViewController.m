//
//  ViewController.m
//  CXTableView
//
//  Created by xiaoma on 17/3/22.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "ViewController.h"
#import "CXTableViewController.h"
//调用Swift类
#import "CXTableView-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ocClickBtn:(id)sender {
    CXTableViewController *tableVC = [[CXTableViewController alloc] init];
    [self.navigationController pushViewController:tableVC animated:YES];
}

- (IBAction)swiftClickBtn:(id)sender {
    CXSwiftTableViewController *swiftVC = [[CXSwiftTableViewController alloc] init];
    [self.navigationController pushViewController:swiftVC animated:YES];
}

@end
