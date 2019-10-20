//
//  XYKRegisterSexViewController.m
//  xyk
//
//

#import "XYKRegisterSexViewController.h"
#import "XYKRegisterBirthdayViewController.h"

@interface XYKRegisterSexViewController ()
@property (nonatomic, strong)UIButton *manButton;
@property (nonatomic, strong)UIButton *womanButton;

@end

@implementation XYKRegisterSexViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setMainView];
}



- (void)setMainView{
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.view addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    titleLabel.textColor = RGB(102, 102, 102);
    titleLabel.text = @"Choose your gender:";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(230, 25));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(90*KHeight);
    }];
    
    
    UIButton *manButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.manButton = manButton;
    [self.view addSubview:manButton];
    manButton.selected = NO;
    [manButton setImage:[UIImage imageNamed:@"man_unselect"] forState:UIControlStateNormal];
    [manButton setImage:[UIImage imageNamed:@"man_select"] forState:UIControlStateSelected];
    [manButton addTarget:self action:@selector(clickMan:) forControlEvents:UIControlEventTouchUpInside];
    manButton.adjustsImageWhenHighlighted = NO;
    [manButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(65*KHeight);
        make.centerX.mas_equalTo(self.view).offset(-70*Kwidth);
        make.size.mas_equalTo(CGSizeMake(70, 90));
    }];
    
    
    UIButton *womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.womanButton = womanButton;
    [self.view addSubview:womanButton];
    womanButton.selected = NO;
    [womanButton setImage:[UIImage imageNamed:@"woman_unselect"] forState:UIControlStateNormal];
    [womanButton setImage:[UIImage imageNamed:@"woman_select"] forState:UIControlStateSelected];
    [womanButton addTarget:self action:@selector(clickWoman:) forControlEvents:UIControlEventTouchUpInside];
    womanButton.adjustsImageWhenHighlighted = NO;
    [womanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(65*KHeight);
        make.centerX.mas_equalTo(self.view).offset(70*Kwidth);
        make.size.mas_equalTo(CGSizeMake(60, 85));
    }];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:nextButton];
    [nextButton setImage:[UIImage imageNamed:@"register_next"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-85*KHeight);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(45*Kwidth, 45*Kwidth));
    }];
    
}


- (void)clickMan:(UIButton *)sender
{
    sender.selected = true;
    [self.womanButton setSelected:false];
    
}

- (void)clickWoman:(UIButton *)sender
{
    sender.selected = true;
    [self.manButton setSelected:false];
}

- (void)nextButtonClick:(UIButton *)sender
{
    if (!self.manButton.selected && !self.womanButton.selected) {
        [self showTextHUDWithMessage:@"Please choose gender"];
        return;
    }
    
    
    XYKRegisterBirthdayViewController *rbVC = [[XYKRegisterBirthdayViewController alloc]init];
    if (self.manButton.selected) {
        rbVC.sex = @"male";
    } else {
        rbVC.sex = @"female";
    }
    rbVC.account = self.account;
    rbVC.password = self.password;
    [self.navigationController pushViewController:rbVC animated:YES];
}

@end
