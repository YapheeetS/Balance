//
//  XYKRegisterBirthdayViewController.m
//  xyk
//
//

#import "XYKRegisterBirthdayViewController.h"
#import <PGDatePicker/PGDatePickManager.h>
#import "XYKRegisterHeightViewController.h"

@interface XYKRegisterBirthdayViewController ()<PGDatePickerDelegate>
@property (nonatomic,copy)NSString *birthday;
@end

@implementation XYKRegisterBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMainView];
}




- (void)setMainView{
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.view addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    titleLabel.textColor = RGB(102, 102, 102);
    titleLabel.text = @"Choose your birthday:";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(230, 25));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(90*KHeight);
    }];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_birthday_background"]];
    [self.view addSubview:backImageView];
    backImageView.userInteractionEnabled = true;
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(40*KHeight);
        make.size.mas_equalTo(CGSizeMake(300*Kwidth, 243*Kwidth));
    }];
    
    
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackground = true;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerType = PGDatePickerTypeLine;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
    datePicker.maximumDate = [NSDate date];
    //设置头部的背景颜色
    datePickManager.headerViewBackgroundColor = RGB(247, 247, 247);
    datePicker.autoSelected = YES;
//    [self presentViewController:datePickManager animated:false completion:nil];
    [self.view addSubview:datePicker];
    
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backImageView).offset(5);
        make.left.mas_equalTo(backImageView).offset(5);
        make.bottom.mas_equalTo(backImageView).offset(-5);
        make.right.mas_equalTo(backImageView).offset(-5);
    }];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backButton];
    [backButton setImage:[UIImage imageNamed:@"register_previous"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-85*KHeight);
        make.centerX.mas_equalTo(self.view).offset(-55*Kwidth);
        make.size.mas_equalTo(CGSizeMake(45*Kwidth, 45*Kwidth));
    }];
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:nextButton];
    [nextButton setImage:[UIImage imageNamed:@"register_next"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-85*KHeight);
        make.centerX.mas_equalTo(self.view).offset(55*Kwidth);
        make.size.mas_equalTo(CGSizeMake(45*Kwidth, 45*Kwidth));
    }];
}


- (void)backButtonClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)nextButtonClick:(UIButton *)sender
{
    XYKRegisterHeightViewController *rhVC = [[XYKRegisterHeightViewController alloc]init];
    rhVC.birthday = self.birthday;
    rhVC.sex = self.sex;
    [self.navigationController pushViewController:rhVC animated:true];
}


#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSLog(@"dateComponents = %@", dateComponents);
    self.birthday = [NSString stringWithFormat:@"%d-%02d-%02d",(int)dateComponents.year,(int)dateComponents.month,(int)dateComponents.day];
}




@end
