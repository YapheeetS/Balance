//
//  LHJSportsTimeFinishViewController.m
//  iOSProject
//
//  Created by Jame on 2019/10/19.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJSportsTimeFinishViewController.h"
#import "LHJActivityViewController.h"
#import "LHJSportsTimeFinishViewController.h"

@interface LHJSportsTimeFinishViewController ()
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, copy) NSString *intensity;
@end

@implementation LHJSportsTimeFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Feedback";
    
    [self setMainView];
}

- (void)setMainView
{
    UILabel *timeLabel2 = [[UILabel alloc]init];
    [timeLabel2 setText:@"Sports time"];
    timeLabel2.font = [UIFont fontWithName:@"PingFangSC-Thin" size:17];
    timeLabel2.textColor = RGB(102, 102, 102);
    timeLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLabel2];
    [timeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(94*KHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    
    UILabel *timeLabel1 = [[UILabel alloc]init];
    [timeLabel1 setText:self.timeStr];
    timeLabel1.font = [UIFont fontWithName:@"DINCondensed-Bold" size:52];
    timeLabel1.textColor = RGB(51, 51, 51);
    timeLabel1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLabel1];
    [timeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel2.mas_bottom).offset(20*KHeight);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(60);
    }];
    
    
    
    UILabel *consumeLabel2 = [[UILabel alloc]init];
    [consumeLabel2 setText:@"Consume"];
    consumeLabel2.font = [UIFont fontWithName:@"PingFangSC-Thin" size:14];
    consumeLabel2.textColor = RGB(102, 102, 102);
    consumeLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:consumeLabel2];
    [consumeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel1.mas_bottom).offset(20*KHeight);
        make.centerX.mas_equalTo(timeLabel1.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *consumeLabel1 = [[UILabel alloc]init];
    consumeLabel1.text = [NSString stringWithFormat:@"%@Cal",self.totalCalorie];
    consumeLabel1.textColor = RGB(51, 51, 51);
    consumeLabel1.font = [UIFont fontWithName:@"DINCondensed-Bold" size:52];
    consumeLabel1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:consumeLabel1];
    [consumeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(consumeLabel2.mas_bottom).offset(20*KHeight);
        make.centerX.mas_equalTo(timeLabel1.mas_centerX);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(60);
    }];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:consumeLabel1.text];
    NSRange range = [consumeLabel1.text rangeOfString:@"Cal"];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Thin" size:14] range:range];
    [attri addAttribute:NSForegroundColorAttributeName value:RGB(102, 102, 102) range:range];//字体颜色
    consumeLabel1.attributedText = attri;
    
    
    UILabel *feedBackLabel = [[UILabel alloc]init];
    feedBackLabel.text = @"Feedback:";
    feedBackLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:17];
    feedBackLabel.textColor = RGB(102, 102, 102);
    feedBackLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:feedBackLabel];
    [feedBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.top.mas_equalTo(consumeLabel1.mas_bottom).offset(60*KHeight);
        make.left.mas_equalTo(self.view.mas_left).offset(40*Kwidth);
    }];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"sport_feedback_btn"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"sport_feedback_btn_select"] forState:UIControlStateSelected];
    [button1 setTitle:@"The intensity is low" forState:UIControlStateNormal];
    [button1 setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:16];
    button1.titleEdgeInsets = UIEdgeInsetsMake(0,20,0,0);
    button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 30));
        make.top.mas_equalTo(feedBackLabel.mas_bottom).mas_equalTo(15*KHeight);
        make.left.mas_equalTo(feedBackLabel.mas_left);
    }];
    self.button1 = button1;
    [button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:[UIImage imageNamed:@"sport_feedback_btn"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"sport_feedback_btn_select"] forState:UIControlStateSelected];
    [button2 setTitle:@"The intensity is moderate" forState:UIControlStateNormal];
    [button2 setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:16];
    button2.titleEdgeInsets = UIEdgeInsetsMake(0,20,0,0);
    button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 30));
        make.top.mas_equalTo(button1.mas_bottom).mas_equalTo(10*KHeight);
        make.left.mas_equalTo(feedBackLabel.mas_left);
    }];
    self.button2 = button2;
    [button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setImage:[UIImage imageNamed:@"sport_feedback_btn"] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"sport_feedback_btn_select"] forState:UIControlStateSelected];
    [button3 setTitle:@"The intensity is high" forState:UIControlStateNormal];
    [button3 setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:16];
    button3.titleEdgeInsets = UIEdgeInsetsMake(0,20,0,0);
    button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 30));
        make.top.mas_equalTo(button2.mas_bottom).mas_equalTo(10*KHeight);
        make.left.mas_equalTo(feedBackLabel.mas_left);
    }];
    self.button3 = button3;
    [button3 addTarget:self action:@selector(button3Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextPageBtn setBackgroundImage:[UIImage imageNamed:@"sport_feedback_nextbtn_background"] forState:UIControlStateNormal];
    [nextPageBtn setTitle:@"Finish" forState:UIControlStateNormal];
    [nextPageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextPageBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:17];
    [nextPageBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPageBtn];
    [nextPageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*Kwidth, 55*Kwidth));
        make.top.mas_equalTo(button3.mas_bottom).offset(20*KHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
}

- (void)button1Click:(UIButton *)sender{
    if (!sender.selected) {
        self.intensity = @"1";
        sender.selected = !sender.selected;
        self.button2.selected = false;
        self.button3.selected = false;
    }
}
- (void)button2Click:(UIButton *)sender{
    if (!sender.selected) {
        self.intensity = @"2";
        sender.selected = !sender.selected;
        self.button1.selected = false;
        self.button3.selected = false;
    }
}
- (void)button3Click:(UIButton *)sender{
    if (!sender.selected) {
        self.intensity = @"3";
        sender.selected = !sender.selected;
        self.button2.selected = false;
        self.button1.selected = false;
    }
}

- (void)nextPage{
    if (!self.button1.selected && !self.button2.selected && !self.button3.selected) {
        [self showTextHUDWithMessage:@"Please select the situation after your exercise"];
        return;
    }
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString *dateString = [formatter stringFromDate:date];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:dateString forKey:@"date"];
    [params setObject:xCache.user_id forKey:@"user_id"];
    [params setObject:self.motionId forKey:@"motion_id"];
    [params setObject:[NSString stringWithFormat:@"%zd", self.totalSeconds] forKey:@"length_time"];
    [params setObject:self.totalCalorie forKey:@"burn_calorie"];
    NSLog(@"%@", params);
    
    xWEAKSELF;
    [NetWorkingManager sendPOSTDataWithPath:addActivity withParamters:params withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"200"]) {
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[LHJActivityViewController class]]) {
                    [weakSelf.navigationController popToViewController:vc animated:true];
                }
            }
            
        } else {
            [self showTextHUDWithMessage:responseObject[@"message"]];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}
@end
