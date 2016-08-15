//
//  ViewController.m
//  StatuTableView
//
//  Created by Dimoo on 16/8/12.
//  Copyright © 2016年 Dimoo. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+Statu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    typeof(self) __weak weakSelf = self;
    [self.tableView setDidClick:^{
        NSLog(@"点击加载");
        [weakSelf didLoadData];
    }];
}

- (void)didLoadData{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self didSetStatu:TableViewStatuNoData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (IBAction)didClick:(id)sender {
    [self didSetStatu:((UIButton *)sender).tag];
}

- (void)didSetStatu:(TableViewStatu)statu{
    [self.tableView setStatu:statu];
    [self.tableView show];
}

@end
