//
//  LHJSportSupplementViewController.m
//  iOSProject
//
//  Created by Jame on 2019/10/19.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJSportSupplementViewController.h"
#import "XYKSportRecordCell.h"
#import "XYKChangeMotionViewController.h"
#import "PGDatePickManager.h"
#import "LHJActivityViewController.h"

@interface LHJSportSupplementViewController ()<PGDatePickerDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) XYKSportRecordCell *consumeCell;
@property (nonatomic, strong) XYKSportRecordCell *timeCell;
@property (nonatomic, strong) XYKSportRecordCell *dateCell;
@property (nonatomic, strong) UIImageView *iconImage;

@property (nonatomic, assign) int hour;
@property (nonatomic ,assign) int minute;

@end

@implementation LHJSportSupplementViewController

-(instancetype)init
{
    if (self == [super init]) {
        self.hour = 0;
        self.minute = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(247, 247, 247);
    self.navigationItem.title = @"Supplement";
    [self setMainView];
}

- (void)setMainView {
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sport_record_top_background"]];
    backImage.userInteractionEnabled = true;
    [self.view addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(16);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.top.mas_equalTo(self.view.mas_top).offset(11);
        make.height.mas_equalTo(240*KHeight);
    }];
    
    UIImageView *iconImage = [[UIImageView alloc]init];
    [self.view addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(backImage.mas_top).offset(40*KHeight);
        make.size.mas_equalTo(CGSizeMake(125*Kwidth, 125*Kwidth));
    }];
    [iconImage sd_setImageWithURL:[NSURL URLWithString:self.dataDict[@"motion_picture"]]];
    self.iconImage = iconImage;
    
    UILabel *titleLabel= [[UILabel alloc]init];
    titleLabel.text = self.dataDict[@"motion_name"];
    [backImage addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    titleLabel.textColor = RGB(34, 34, 34);
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 25));
        make.top.mas_equalTo(iconImage.mas_bottom).offset(IS_IPHONE_X ? 20 : 10*KHeight);
        make.centerX.mas_equalTo(iconImage.mas_centerX);
    }];
    
    
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeButton setImage:[UIImage imageNamed:@"sport_change_icon"] forState:UIControlStateNormal];
    [changeButton setBackgroundImage:[UIImage imageNamed:@"sport_change_background"] forState:UIControlStateNormal];
    [changeButton setTitle:@"Change" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    changeButton.imageEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 15);
    changeButton.titleEdgeInsets = UIEdgeInsetsMake(-2, 12, 0, 0);
    [self.view addSubview:changeButton];
    [changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backImage.mas_bottom).offset(-4);
        make.size.mas_equalTo(CGSizeMake(140*Kwidth, 48*Kwidth));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [changeButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    
    
    XYKSportRecordCell *dateCell = [[XYKSportRecordCell alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 64)];
    [dateCell setViewWithImag:[UIImage imageNamed:@"sport_date_select"] title:@"Date" access:YES type:1];
    [self.view addSubview:dateCell];
    [dateCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(xScreenWidth, 64));
        make.top.mas_equalTo(changeButton.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    self.dateCell = dateCell;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateCelltap)];
    [dateCell addGestureRecognizer:tap1];

    
    XYKSportRecordCell *timeCell = [[XYKSportRecordCell alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 64)];;
    [timeCell setViewWithImag:[UIImage imageNamed:@"sport_time_select"] title:@"Duration" access:YES type:2];
    [self.view addSubview:timeCell];
    [timeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(xScreenWidth, 64));
        make.top.mas_equalTo(dateCell.mas_bottom).offset(1);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    self.timeCell = timeCell;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeCelltap)];
    [timeCell addGestureRecognizer:tap2];
    
    
    XYKSportRecordCell *consumeCell = [[XYKSportRecordCell alloc]initWithFrame:CGRectMake(0, 0, xScreenWidth, 64)];
    [consumeCell setViewWithImag:[UIImage imageNamed:@"sport_calories_consume"] title:@"Consume" access:NO type:3];
    [self.view addSubview:consumeCell];
    [consumeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(xScreenWidth, 64));
        make.top.mas_equalTo(timeCell.mas_bottom).offset(1);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    self.consumeCell = consumeCell;
    
    UIButton *finishButton = [[UIButton alloc]init];
    [finishButton setBackgroundImage:[UIImage imageNamed:@"icon_login_btn"] forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishButton setTitle:@"save" forState:UIControlStateNormal];
    finishButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:finishButton];
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(40);
        make.right.mas_equalTo(self.view).offset(-40);
        make.bottom.mas_equalTo(self.view).offset(-85*KHeight);
        make.height.mas_equalTo(45);
    }];
    [finishButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
}

- (void)save
{
    if ([self.consumeCell.detail.text isEqualToString:@""] || [self.consumeCell.detail.text isEqualToString:@"0"] || [self.timeCell.detail.text isEqualToString:@""]) {
        [self showTextHUDWithMessage:@"Please complete the data and save"];
        return;
    }
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[LHJActivityViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    
//    __weak XYKSportRecordViewController *weakSelf = self;
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if ([CFLManger instance].loginName) {
//        [params setObject:[CFLManger instance].loginName forKey:@"key"];
//    }
//    [params setObject:self.dataDict[@"id"] forKey:@"id"];
//    int time = self.hour*3600 + self.minute*60;//单位：秒
//    [params setObject:[NSString stringWithFormat:@"%d",time] forKey:@"length_time"];
//    float calorie = [self.dataDict[@"consume_calorie"] floatValue];
//    float totalConsume = calorie * (float)(self.hour*60 + self.minute);
//    [params setObject:[NSString stringWithFormat:@"%.2f",totalConsume] forKey:@"calorie"];
//    [params setObject:self.dateCell.detail.text forKey:@"motion_time"];
//
//    [SharedApiClient apiPostPath:XYKMotionDataUpload param:params complection:^(KSResponseState *state, id responseObject) {
//        int code = [[responseObject objectForKey:@"code"] intValue];
//        if (code == 200) {
////            NSLog(@"%@\n",[responseObject objectForKey:@"data"]);
//
//            for (UIViewController *vc in self.navigationController.viewControllers) {
//                if ([vc isKindOfClass:[XYKSportStatisticViewController class]]) {
//                    [weakSelf.navigationController popToViewController:vc animated:true];
//                }
//            }
//
//        } else {
//            [weakSelf showMessage:[[responseObject objectForKey:@"data"]objectForKey:@"data"]];
//        }
//    }];
}

- (void)change
{
    XYKChangeMotionViewController *cmVC = [[XYKChangeMotionViewController alloc]init];
    cmVC.dataArray = self.dataArray;
    cmVC.returnValueBlock = ^(NSMutableDictionary *dataDict) {
        self.dataDict = dataDict;
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:self.dataDict[@"motion_picture"]]];
        self.titleLabel.text = self.dataDict[@"motion_name"];
        if (![self.timeCell.detail.text isEqualToString:@""]) {
            float calorie = [self.dataDict[@"consume_calorie"] floatValue];
            float totalConsume = calorie * (float)(self.hour*60 + self.minute);
            self.consumeCell.detail.text = [NSString stringWithFormat:@"%.1fCal",totalConsume];
        }
    };
    
    [self.navigationController pushViewController:cmVC animated:YES];
}

- (void)dateCelltap
{
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackground = true;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerType = PGDatePickerTypeLine;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
//    datePicker.maximumDate = [NSDate date];
    //设置头部的背景颜色
    datePickManager.headerViewBackgroundColor = RGB(247, 247, 247);
    datePicker.autoSelected = YES;
    [self presentViewController:datePickManager animated:false completion:nil];
}

- (void)timeCelltap
{
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackground = true;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerType = PGDatePickerTypeLine;
    datePicker.datePickerMode = PGDatePickerModeTime;
    //设置头部的背景颜色
    datePickManager.headerViewBackgroundColor = RGB(247, 247, 247);
    datePicker.autoSelected = YES;
    [self presentViewController:datePickManager animated:false completion:nil];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"HH:mm";
    NSDate *date = [dateFormatter dateFromString: @"00:00"];
    [datePicker setDate:date animated:false];
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
//    NSLog(@"dateComponents = %@", dateComponents);
    if (datePicker.datePickerMode == PGDatePickerModeDate) {
        self.dateCell.detail.text = [NSString stringWithFormat:@"%zd-%02zd-%02zd",dateComponents.year,dateComponents.month,dateComponents.day];
    } else if (datePicker.datePickerMode == PGDatePickerModeTime) {
        self.timeCell.detail.text = [NSString stringWithFormat:@"%zdH%zdM",dateComponents.hour,dateComponents.minute];
        self.hour = (int)dateComponents.hour;
        self.minute = (int)dateComponents.minute;
        float calorie = [self.dataDict[@"consume_calorie"] floatValue];
        float totalConsume = calorie * (float)(self.hour*60 + self.minute);
        self.consumeCell.detail.text = [NSString stringWithFormat:@"%.1fCal",totalConsume];
    }
}


@end
