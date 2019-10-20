//
//  LHJSportsTimeViewController.m
//  iOSProject
//
//  Created by Jame on 2019/10/19.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJSportsTimeViewController.h"
#import "XXLongTapBtn.h"
#import "YSTimeManager.h"
#import "LHJSportsTimeFinishViewController.h"
#import "LHJActivityViewController.h"

@interface LHJSportsTimeViewController ()<YSTimeManagerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UILabel *timeLabel1;
@property (nonatomic, strong) UILabel *consumeLabel1;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) XXLongTapBtn *endButton;
@property (nonatomic, strong) UIButton *continueButton;
@property (nonatomic, strong) YSTimeManager *timeManager;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;
@property (nonatomic, strong) UIButton *mentionBtn;
@property (nonatomic, assign) NSInteger totalSeconds;
@end

@implementation LHJSportsTimeViewController

- (instancetype)init {
    if (self = [super init]) {
        self.totalSeconds = 0;
        self.hour = 0;
        self.minute = 0;
        self.second = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.motionName;
    [self initTimeManager];
    [self setMainView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.timeManager start];
}

- (void)initTimeManager
{
    self.timeManager = [YSTimeManager new];
    self.timeManager.delegate = self;
}

- (void)setMainView
{
    UILabel *timeLabel1 = [[UILabel alloc]init];
    self.timeLabel1 = timeLabel1;
    [timeLabel1 setText:@"00:00:00"];
    timeLabel1.font = [UIFont fontWithName:@"DINCondensed-Bold" size:52];
    timeLabel1.textColor = RGB(51, 51, 51);
    timeLabel1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLabel1];
    [timeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(113*KHeight);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *timeLabel2 = [[UILabel alloc]init];
    [timeLabel2 setText:@"Duration"];
    timeLabel2.font = [UIFont fontWithName:@"PingFangSC-Thin" size:17];
    timeLabel2.textColor = RGB(102, 102, 102);
    timeLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLabel2];
    [timeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel1.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.width/3);
        make.height.mas_equalTo(20);
    }];
    
    
    UILabel *consumeLabel1 = [[UILabel alloc]init];
    self.consumeLabel1 = consumeLabel1;
    [consumeLabel1 setText:@"0.0"];
    consumeLabel1.font = [UIFont fontWithName:@"DINCondensed-Bold" size:52];
    consumeLabel1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:consumeLabel1];
    [consumeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel2.mas_bottom).offset(40*KHeight);
        make.centerX.mas_equalTo(timeLabel1.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(60);
    }];
    
    
    UILabel *consumeLabel2 = [[UILabel alloc]init];
    [consumeLabel2 setText:@"Consume"];
    consumeLabel2.font = [UIFont fontWithName:@"PingFangSC-Thin" size:14];
    consumeLabel2.textColor = RGB(102, 102, 102);
    consumeLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:consumeLabel2];
    [consumeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(consumeLabel1.mas_bottom);
        make.centerX.mas_equalTo(consumeLabel1.mas_centerX);
        make.width.mas_equalTo(self.view.width/3);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pauseButton setBackgroundImage:[UIImage imageNamed:@"sport_run_map_pause"] forState:UIControlStateNormal];
    [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    [pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pauseButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [pauseButton addTarget:self action:@selector(pauseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
    [pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-45*KHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(110*Kwidth, 110*Kwidth));
    }];
    self.pauseButton = pauseButton;
    pauseButton.hidden = false;
    
    
    UIButton *continueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [continueButton setBackgroundImage:[UIImage imageNamed:@"sport_run_map_continue-btn"] forState:UIControlStateNormal];
    [continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    [continueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    continueButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [continueButton addTarget:self action:@selector(continueBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:continueButton];
    [continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-52.5*KHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(95*Kwidth, 95*Kwidth));
    }];
    self.continueButton = continueButton;
    continueButton.hidden = true;
    [self.view layoutIfNeeded];
    
    
    XXLongTapBtn *endButton = [[XXLongTapBtn alloc] initWithFrame:continueButton.frame];
    endButton.bgcImageView.image = [UIImage imageNamed:@"sport_run_map_end-btn"];
    [endButton setTitle:@"Finish" forState:UIControlStateNormal];
    [endButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    endButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [endButton addTarget:self action:@selector(endBtnClick) forControlEvents:UIControlEventTouchUpInside];
    endButton.circleColor = RGB(251, 55, 64);
    [self.view addSubview:endButton];
    self.endButton = endButton;
    __weak LHJSportsTimeViewController *weakSelf = self;
    endButton.didFinishBlock = ^{
        NSLog(@"is finish");
        
//        if ([self.timeManager getTotalTime] < 60) {
//            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Your exercise time is less than one minute. Are you sure you want to end your workout?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"OK", nil];
//            actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//            [actionSheet showInView:self.view];
//            return;
//        }
        
        
        LHJSportsTimeFinishViewController *stfVC = [[LHJSportsTimeFinishViewController alloc]init];
        stfVC.timeStr = self.timeLabel1.text;
        stfVC.totalCalorie = self.consumeLabel1.text;
        stfVC.motionId = self.motionId;
        stfVC.totalSeconds = self.totalSeconds;
        [weakSelf.navigationController pushViewController:stfVC animated:YES];
    };
    endButton.hidden = true;
    [self.view bringSubviewToFront:continueButton];
}


//暂停
- (void)pauseBtnClick:(UIButton *)button{
    [self.timeManager pause];
    
    [self.pauseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-52.5*KHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(95*Kwidth, 95*Kwidth));
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.pauseButton.hidden = true;
        self.endButton.hidden = false;
        self.continueButton.hidden = false;
        [self.endButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-52.5*KHeight);
            make.size.mas_equalTo(CGSizeMake(95*Kwidth, 95*Kwidth));
            make.left.mas_equalTo(self.view.mas_left).offset(69*Kwidth);
        }];
        
        [self.continueButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-52.5*KHeight);
            make.size.mas_equalTo(CGSizeMake(95*Kwidth, 95*Kwidth));
            make.right.mas_equalTo(self.view.mas_right).offset(-69*Kwidth);
        }];
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }];
}



//结束
- (void)endBtnClick{
    
    UIButton *mentionBtn = [[UIButton alloc] init];
    [mentionBtn setBackgroundImage:[UIImage imageNamed:@"sport_run_map_end_click"] forState:UIControlStateNormal];
    [mentionBtn setTitle:@"Long press end" forState:UIControlStateNormal];
    [mentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    mentionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    mentionBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    mentionBtn.userInteractionEnabled = false;
    mentionBtn.titleEdgeInsets = UIEdgeInsetsMake(-4,0,0,0);
    [self.view addSubview:mentionBtn];
    [mentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.endButton.mas_centerX);
        make.bottom.mas_equalTo(self.endButton.mas_top).offset(-5);
        make.size.mas_equalTo(CGSizeMake(120, 28));
    }];
    self.mentionBtn = mentionBtn;
    [self.view layoutIfNeeded];
    [self performSelector:@selector(removeMentionBtn) withObject:nil afterDelay:0.7];
    
}

//继续
- (void)continueBtnClick:(UIButton *)button{
    
    [self.endButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-52.5*KHeight);
        make.size.mas_equalTo(CGSizeMake(95*Kwidth, 95*Kwidth));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.continueButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-52.5*KHeight);
        make.size.mas_equalTo(CGSizeMake(95*Kwidth, 95*Kwidth));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.timeManager start];
        self.pauseButton.hidden = false;
        self.endButton.hidden = true;
        self.continueButton.hidden = true;
        [self.pauseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-45*KHeight);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(110*Kwidth, 110*Kwidth));
        }];
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
        
    }];
    
}

- (void)removeMentionBtn{
    [self.mentionBtn removeFromSuperview];
}



#pragma mark - YSTimeManagerDelegate
- (void)tickWithAccumulatedTime:(NSUInteger)time
{
    [self resetTimeLabelWithTotalSeconds:time];
}


- (void)resetTimeLabelWithTotalSeconds:(NSUInteger)totalSeconds
{
    self.totalSeconds = totalSeconds;
    self.hour = totalSeconds / 3600;
    self.minute = (totalSeconds - self.hour * 3600) / 60;
    self.second = totalSeconds - self.hour * 3600 - self.minute * 60;
    
    [self setupTimeLabelText];
    [self setupCaloriesLabelTextWithtotalSeconds:totalSeconds];
}

- (void)setupTimeLabelText
{
    NSString *hourText = @"";
    if (self.hour < 10)
    {
        hourText = [hourText stringByAppendingString:@"0"];
    }
    hourText = [hourText stringByAppendingString:[NSString stringWithFormat:@"%@", @(self.hour)]];
    
    NSString *minuteText = @"";
    if (self.minute < 10)
    {
        minuteText = [minuteText stringByAppendingString:@"0"];
    }
    minuteText = [minuteText stringByAppendingString:[NSString stringWithFormat:@"%@", @(self.minute)]];
    
    NSString *secondText = @"";
    if (self.second < 10)
    {
        secondText = [secondText stringByAppendingString:@"0"];
    }
    secondText = [secondText stringByAppendingString:[NSString stringWithFormat:@"%@", @(self.second)]];
    
    NSString *labelText = [NSString stringWithFormat:@"%@:%@:%@", hourText, minuteText, secondText];
    self.timeLabel1.text = labelText;
}

- (void)setupCaloriesLabelTextWithtotalSeconds:(NSUInteger)totalSeconds
{
    int minute = (int)totalSeconds / 60;
    float totalConsume = (float)minute * [self.calorie floatValue];
    self.consumeLabel1.text = [NSString stringWithFormat:@"%.1f",totalConsume];
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //确定
    if (buttonIndex == 0) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[LHJActivityViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
        
    } else {  //取消
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
