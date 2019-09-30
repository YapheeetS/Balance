//
//  LHJTabControlOneViewController.m
//  iOSProject
//
//  Created by Thomas on 2019/9/26.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJBalanceViewController.h"

@interface LHJBalanceViewController ()

@end

@implementation LHJBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Coming soon!";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont fontWithName:@"PingFangSC-Light" size:24];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
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
