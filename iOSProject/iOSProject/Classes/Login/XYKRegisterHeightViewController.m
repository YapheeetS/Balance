//
//  XYKRegisterHeightViewController.m
//  xyk
//
//

#import "XYKRegisterHeightViewController.h"
#import "SBScrollRulerView.h"
#import "XYKRegisterWeightViewController.h"

@interface XYKRegisterHeightViewController ()<SBScrollRulerViewDelegate>
@property (nonatomic, assign) int value;
@property (nonatomic, strong)UILabel *heightLabel;
@end

@implementation XYKRegisterHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.value = 160;
    
    [self setMainView];
}



- (void)setMainView{
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.view addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    titleLabel.textColor = RGB(102, 102, 102);
    titleLabel.text = @"Choose your height:";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(230, 25));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(90*KHeight);
    }];
   
    
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_height_background"]];
    [self.view addSubview:backImageView];
    backImageView.userInteractionEnabled = true;
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(80*KHeight);
        make.size.mas_equalTo(CGSizeMake(350*Kwidth, 80*Kwidth));
    }];
    
    [self.view layoutIfNeeded];
    
    SBScrollRulerView *rulerView = [[SBScrollRulerView alloc] initWithFrame:CGRectMake(35*Kwidth, backImageView.y + 5, self.view.frame.size.width - 70*Kwidth, RVCShareIns.rulerView_H) theMinValue:0 theMaxValue:300 theStep:1 theUnit:@"" theNum:160];
    rulerView.delegate = self;
    rulerView.bgColor = RGB(247, 247, 247);
    rulerView.triangleColor = RGB(254, 196, 27);
    
    RVCShareIns.step = 1;
    RVCShareIns.betweenNum = 10;
    RVCShareIns.rulerGap = 10;
    RVCShareIns.maxValue = 250;
    RVCShareIns.minValue = 0;
    RVCShareIns.rulerView_BGColor = [UIColor whiteColor];
    RVCShareIns.rulerTitle_Color = RGB(202, 202, 202);
    RVCShareIns.red = 202.0;
    RVCShareIns.green = 202.0;
    RVCShareIns.blue = 202.0;
    RVCShareIns.triangle_Color = [UIColor clearColor];
    RVCShareIns.rulerView_H = 60;
    [rulerView reDrawRectRulerView:RVCShareIns];
    [rulerView setRealValue:160 animated:NO];
    [self.view addSubview:rulerView];
   

    
    UIImageView *pointer = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_height_pointer"]];
    [self.view addSubview:pointer];
    pointer.userInteractionEnabled = true;
    [pointer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(backImageView.mas_top).offset(-8*Kwidth);
        make.bottom.mas_equalTo(backImageView.mas_bottom).offset(8*Kwidth);
        make.width.mas_equalTo(18*Kwidth);
    }];
    
    UILabel *heightLabel = [[UILabel alloc]init];
    [self.view addSubview:heightLabel];
    self.heightLabel = heightLabel;
    heightLabel.textAlignment = NSTextAlignmentCenter;
    heightLabel.text = @"160 cm";
    heightLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:36];
    heightLabel.textColor = RGB(123, 163, 252);
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:heightLabel.text];
    NSRange range = [heightLabel.text rangeOfString:@" cm"];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:18] range:range];
    [attri addAttribute:NSForegroundColorAttributeName value:RGB(202, 202, 202) range:range];
    heightLabel.attributedText = attri;
    [heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.mas_equalTo(pointer.mas_bottom).offset(20*Kwidth);
        make.centerX.mas_equalTo(self.view);
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
    XYKRegisterWeightViewController *rwVC = [[XYKRegisterWeightViewController alloc]init];
    rwVC.height = [NSString stringWithFormat:@"%d",self.value];
    rwVC.sex = self.sex;
    rwVC.birthday = self.birthday;
    [self.navigationController pushViewController:rwVC animated:true];
}



#pragma mark - SBScrollRulerViewDelegate
- (void)sbScrollRulerView:(SBScrollRulerView *)rulerView valueChange:(float)value{
    if (!self.heightLabel) {
        return;
    }
    self.value = (int)value;
    self.heightLabel.text = [NSString stringWithFormat:@"%d cm",(int)value];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.heightLabel.text];
    NSRange range = [self.heightLabel.text rangeOfString:@" cm"];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:18] range:range];
    [attri addAttribute:NSForegroundColorAttributeName value:RGB(202, 202, 202) range:range];
    self.heightLabel.attributedText = attri;
    
}
@end
