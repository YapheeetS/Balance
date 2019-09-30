//
//  LHJTabControlFourViewController.m
//  iOSProject
//
//  Created by Thomas on 2019/9/26.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJProfileViewController.h"

@interface LHJProfileViewController ()
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIButton *button5;
@end

@implementation LHJProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMainView];
    [self setData];
}

- (void)setData {
    [self.button2 setTitle:@"180cm" forState:UIControlStateNormal];
    [self.button3 setTitle:@"23 Y/O" forState:UIControlStateNormal];
    [self.button4 setTitle:@"75 kg" forState:UIControlStateNormal];
    [self.button5 setTitle:@"Male" forState:UIControlStateNormal];
    
}

- (void)setMainView {
    
    UIImageView *backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_background"]];
    backView.contentMode = UIViewContentModeScaleAspectFill;
    backView.clipsToBounds = true;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button1 = button1;
    [self.view addSubview:button1];
    button1.userInteractionEnabled = false;
    [button1 setBackgroundImage:[UIImage imageNamed:@"profile_button1_background"] forState:UIControlStateNormal];
    [button1 setTitle:@"" forState:UIControlStateNormal];
    button1.titleEdgeInsets = UIEdgeInsetsMake(-22*Kwidth, 0, 0, 0);
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*Kwidth, 60*Kwidth));
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
    }];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2 = button2;
    [self.view addSubview:button2];
    button2.userInteractionEnabled = false;
    [button2 setBackgroundImage:[UIImage imageNamed:@"profile_button4_background"] forState:UIControlStateNormal];
    [button2 setTitle:@"" forState:UIControlStateNormal];
    button2.titleEdgeInsets = UIEdgeInsetsMake(-22*Kwidth, 0, 0, 0);
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110*Kwidth, 110*Kwidth));
        make.top.mas_equalTo(self.view).offset(IS_IPHONE_X ? 124*Kwidth : 100*KHeight);
        make.left.mas_equalTo(self.view).offset(40*Kwidth);
    }];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button3 = button3;
    [self.view addSubview:button3];
    button3.userInteractionEnabled = false;
    [button3 setBackgroundImage:[UIImage imageNamed:@"profile_button5_background"] forState:UIControlStateNormal];
    [button3 setTitle:@"" forState:UIControlStateNormal];
    button3.titleEdgeInsets = UIEdgeInsetsMake(-22*Kwidth, 0, 0, 0);
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Kwidth, 100*Kwidth));
        make.top.mas_equalTo(button1.mas_bottom).offset(-25*Kwidth);
        make.right.mas_equalTo(self.view).offset(-35*Kwidth);
    }];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button4 = button4;
    [self.view addSubview:button4];
    button4.userInteractionEnabled = false;
    [button4 setBackgroundImage:[UIImage imageNamed:@"profile_button7_background"] forState:UIControlStateNormal];
    [button4 setTitle:@"" forState:UIControlStateNormal];
    button4.titleEdgeInsets = UIEdgeInsetsMake(-22*Kwidth, 0, 0, 0);
    [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button4.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*Kwidth, 100*Kwidth));
        make.bottom.mas_equalTo(button1.mas_top);
        make.right.mas_equalTo(self.view).offset(-45*Kwidth);
    }];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button5 = button5;
    [self.view addSubview:button5];
    button5.userInteractionEnabled = false;
    [button5 setBackgroundImage:[UIImage imageNamed:@"profile_button2_background"] forState:UIControlStateNormal];
    [button5 setTitle:@"" forState:UIControlStateNormal];
    button5.titleEdgeInsets = UIEdgeInsetsMake(-22*Kwidth, 0, 0, 0);
    [button5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button5.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
    [button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120*Kwidth, 120*Kwidth));
        make.top.mas_equalTo(button1.mas_bottom).offset(60*KHeight);
        make.centerX.mas_equalTo(button1).offset(-40*Kwidth);
    }];
    
}

@end
