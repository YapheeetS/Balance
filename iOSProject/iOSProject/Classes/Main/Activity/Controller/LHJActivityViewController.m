//
//  LHJTabControlThreeViewController.m
//  iOSProject
//
//  Created by Thomas on 2019/9/26.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJActivityViewController.h"
#import "CustomView.h"
#import "XYKDownBackImageView.h"
#import "XYKGoSportButton.h"

@interface LHJActivityViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) XYKDownBackImageView *downBackImageView;
@property (nonatomic, strong) UILabel *runLabel2;
@property (nonatomic, strong) UILabel *timeLabel2;
@property (nonatomic, strong) UILabel *distanceLabel2;
@property (nonatomic, strong) UILabel *targetLabel2;
@property (nonatomic, strong) CustomView *customView;
@property (nonatomic, strong) UILabel *consumeLabel2;
@property (nonatomic, strong) XYKGoSportButton *goSportBtn;


@property (nonatomic, strong) NSMutableDictionary *dataDict;
@end

@implementation LHJActivityViewController

-(NSMutableDictionary *)dataDict
{
    if(!_dataDict){
        _dataDict = [NSMutableDictionary dictionary];
        [_dataDict setValue:@"300" forKey:@"calorie"];
        [_dataDict setValue:@"3600" forKey:@"length_time"];
        [_dataDict setValue:@"7800" forKey:@"step_number"];
        [_dataDict setValue:@"5800" forKey:@"distance"];
        [_dataDict setValue:@"500" forKey:@"burn_calorie"];
    }
    return _dataDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMainView];
    [self reloadViews];
    self.navigationController.delegate = self;
    
}


- (void)reloadViews{
    
    self.consumeLabel2.text = [NSString stringWithFormat:@"%d",[self.dataDict[@"calorie"] intValue]];
    self.runLabel2 = [self setLabelAttributeWithText1:self.dataDict[@"step_number"] text2:@" setps" label:self.runLabel2];
    float minute = [self.dataDict[@"length_time"] floatValue] / 60.0;
    self.timeLabel2 = [self setLabelAttributeWithText1:[NSString stringWithFormat:@"%.1f",minute] text2:@" min" label:self.timeLabel2];
    
    float distance = [self.dataDict[@"distance"] floatValue]/1000.0;
    NSString *distanceStr = [NSString stringWithFormat:@"%.1f",distance];
    self.distanceLabel2 = [self setLabelAttributeWithText1:distanceStr text2:@" km" label:self.distanceLabel2];
    
    self.targetLabel2 = [self setLabelAttributeWithText1:self.dataDict[@"burn_calorie"] text2:@" cal" label:self.targetLabel2];
    float consume = [self.consumeLabel2.text floatValue];
    float target = [self.targetLabel2.text floatValue];
    
    
    
    float done = consume / target;
    float end = 270;
    if (done >= 1.0) {
        end = 630;
    } else {
        end = 270 + 360 * done;
    }
    [_customView setStartAngle:270 toEndAngle:end byRatio:nil byAnimationTime:0.5];
}


- (void)setMainView {
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, xScreenWidth, xScreenHeight)];
    backImageView.image = [UIImage imageNamed:@"sport-background"];
    [self.view addSubview:backImageView];
    [self.view sendSubviewToBack:backImageView];
    backImageView.userInteractionEnabled = true;
    
    _customView = [[CustomView alloc] initWithFrame:CGRectMake((xScreenWidth - 240*Kwidth)/2, (IS_IPHONE_X ? 120.0f: 78.0f), 240*Kwidth, 240*Kwidth)];
    [_customView setCusRadius:_customView.frame.size.width * 0.475];
    [_customView setCusLineWidth:5];
    _customView.backgroundColor = [UIColor clearColor];
    _customView.doubleCircle = NO;
    _customView.animation = NO;
    _customView.isHead = YES;
    _customView.headImage = [UIImage imageNamed:@"sports_progress_head"];
    [_customView setViewForegroundColor:[UIColor whiteColor]];
    [_customView setViewBackgroundColor:RGB(160, 179, 255)];
    [_customView setRadiusFont:20];
    [backImageView addSubview:_customView];
    
    UIImageView *innerCircle = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sport_inner_circle"]];
    innerCircle.userInteractionEnabled = true;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCircle)];
//    [innerCircle addGestureRecognizer:tap];
    
    [_customView addSubview:innerCircle];
    [innerCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.customView.mas_centerX);
        make.centerY.mas_equalTo(self.customView.mas_centerY);
        make.width.mas_equalTo(210*Kwidth);
        make.height.mas_equalTo(210*Kwidth);
    }];
    
    
    UILabel *consumeLabel1 = [[UILabel alloc] init];
    consumeLabel1.text = @"Consume";
    consumeLabel1.textColor = [UIColor whiteColor];
    consumeLabel1.font = [UIFont systemFontOfSize:16];
    [consumeLabel1 sizeToFit];
    [_customView addSubview:consumeLabel1];
    [consumeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.customView.mas_centerX);
        make.centerY.mas_equalTo(self.customView.mas_centerY).offset(-40*Kwidth);
    }];
    
    UILabel *consumeLabel2 = [[UILabel alloc] init];
    consumeLabel2.text = @"0";
    consumeLabel2.textColor = [UIColor whiteColor];
    consumeLabel2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:34];
    [consumeLabel2 sizeToFit];
    [_customView addSubview:consumeLabel2];
    [consumeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.customView.mas_centerX);
        make.centerY.mas_equalTo(self.customView.mas_centerY);
    }];
    self.consumeLabel2 = consumeLabel2;
    
    UILabel *consumeLabel3 = [[UILabel alloc] init];
    consumeLabel3.text = @"Cal";
    consumeLabel3.textColor = [UIColor whiteColor];
    consumeLabel3.font = [UIFont systemFontOfSize:16];
    [consumeLabel3 sizeToFit];
    [_customView addSubview:consumeLabel3];
    [consumeLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.customView.mas_centerX);
        make.centerY.mas_equalTo(self.customView.mas_centerY).offset(40*Kwidth);
    }];
    
    
    XYKDownBackImageView *downBackImageView = [[XYKDownBackImageView alloc] initWithFrame:CGRectMake(0, xScreenHeight - 300*KHeight, xScreenWidth, 253*KHeight)];
    downBackImageView.image = [UIImage imageNamed:@"sport_down_background"];
    downBackImageView.userInteractionEnabled = true;
    self.downBackImageView = downBackImageView;
    [backImageView addSubview:downBackImageView];
    
    UIImageView *sportCutImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sport_cut_off_rule"]];
    [downBackImageView addSubview:sportCutImageView];
    [sportCutImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(downBackImageView.mas_centerX);
        make.bottom.mas_equalTo(downBackImageView.mas_bottom).offset(-32*KHeight);
        make.height.mas_equalTo(165*KHeight);
        make.width.mas_equalTo(335*KHeight);
    }];
    
    UILabel *runLabel1 = [self creatLabelWithImage:[UIImage imageNamed:@"sport_run_icon"] rect:CGRectMake(0, -3, 15, 16) text:@" Steps num"];
    [downBackImageView addSubview:runLabel1];
    [runLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(downBackImageView.mas_top).offset(70*KHeight);
        make.left.mas_equalTo(downBackImageView.mas_left).offset(50*Kwidth);
    }];
    UILabel *runLabel2 = [self creatLabelWithText:@" steps"];
    [downBackImageView addSubview:runLabel2];
    [runLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(runLabel1.mas_bottom).offset(3*KHeight);
        make.left.mas_equalTo(runLabel1.mas_left);
    }];
    self.runLabel2 = runLabel2;
    
    
    UILabel *timeLabel1 = [self creatLabelWithImage:[UIImage imageNamed:@"sport_time_icon"] rect:CGRectMake(0, 0, 12, 12) text:@"  Duration"];
    [downBackImageView addSubview:timeLabel1];
    [timeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(downBackImageView.mas_top).offset(70*KHeight);
        make.left.mas_equalTo(downBackImageView.mas_centerX).offset(50*Kwidth);
    }];
    UILabel *timeLabel2 = [self creatLabelWithText:@" min"];
    [downBackImageView addSubview:timeLabel2];
    [timeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel1.mas_bottom).offset(3*KHeight);
        make.left.mas_equalTo(timeLabel1.mas_left);
    }];
    self.timeLabel2 = timeLabel2;
    
    
    UILabel *distanceLabel1 = [self creatLabelWithImage:[UIImage imageNamed:@"sport_distance_icon"] rect:CGRectMake(0, 0, 10, 12) text:@"  Distance"];
    [downBackImageView addSubview:distanceLabel1];
    [distanceLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(downBackImageView.mas_bottom).offset(-76*KHeight);
        make.left.mas_equalTo(downBackImageView.mas_left).offset(50*Kwidth);
    }];
    UILabel *distanceLabel2 = [self creatLabelWithText:@" km"];
    [downBackImageView addSubview:distanceLabel2];
    [distanceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(distanceLabel1.mas_bottom).offset(3*KHeight);
        make.left.mas_equalTo(distanceLabel1.mas_left);
    }];
    self.distanceLabel2 = distanceLabel2;
    
    UILabel *targetLabel1 = [self creatLabelWithImage:[UIImage imageNamed:@"sport_target_icon"] rect:CGRectMake(0, 0, 12, 12) text:@"  Target"];
    [downBackImageView addSubview:targetLabel1];
    [targetLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(downBackImageView.mas_bottom).offset(-76*KHeight);
        make.left.mas_equalTo(downBackImageView.mas_centerX).offset(50*Kwidth);
    }];
    UILabel *targetLabel2 = [self creatLabelWithText:@" cal"];
    [downBackImageView addSubview:targetLabel2];
    [targetLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(targetLabel1.mas_bottom).offset(3*KHeight);
        make.left.mas_equalTo(targetLabel1.mas_left);
    }];
    self.targetLabel2 = targetLabel2;
    
    XYKGoSportButton *goSportBtn = [XYKGoSportButton buttonWithType:UIButtonTypeCustom];
    goSportBtn.layer.cornerRadius = 40*KHeight/2;
    goSportBtn.layer.masksToBounds = true;
    goSportBtn.layer.borderColor = x_theme2.CGColor;//设置边框颜色
    goSportBtn.layer.borderWidth = 0.5f;//设置边框颜色
    [goSportBtn setTitle:@"Go exercise" forState:UIControlStateNormal];
    [goSportBtn setBackgroundColor:[UIColor whiteColor]];
    [goSportBtn setTitleColor:x_theme2 forState:UIControlStateNormal];
    [goSportBtn addTarget:self action:@selector(goSport) forControlEvents:UIControlEventTouchUpInside];
    goSportBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [downBackImageView addSubview:goSportBtn];
    [goSportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(downBackImageView.mas_centerX);
        make.width.mas_equalTo(115*Kwidth);
        make.height.mas_equalTo(40*KHeight);
        make.top.mas_equalTo(downBackImageView.mas_top).offset(-50*KHeight/2);
    }];
    self.goSportBtn = goSportBtn;
    
    
}

- (UILabel *)setLabelAttributeWithText1:(NSString *)text1 text2:(NSString *)text2 label:(UILabel *)label{
    NSString *str = [NSString stringWithFormat:@"%@%@",text1,text2];
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:26];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:str];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Thin" size:14] range:[str rangeOfString:text2]];
    label.attributedText = attri;
    
    return label;
}


- (UILabel *)creatLabelWithText:(NSString *)text{
    
    NSString *str = [NSString stringWithFormat:@"%d%@",0,text];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 20)];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = str;
    label.font = [UIFont fontWithName:@"PingFangSC-Thin" size:26];
    label.textColor = RGB(102, 102, 102);
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:label.text];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:14] range:[str rangeOfString:text]];
    label.attributedText = attri;
    return label;
}


- (UILabel *)creatLabelWithImage:(UIImage *)image rect:(CGRect)rect text:(NSString *)text {
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 15)];
    lable.textColor = RGB(153, 153, 153);
    lable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    lable.textAlignment = NSTextAlignmentCenter;
    [lable setText:text];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:lable.text];
    NSTextAttachment *attch= [[NSTextAttachment alloc]init];
    attch.bounds = rect;
    //设置图片
    attch.image = image;
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attch)];
    //插入到第几个下标
    [attri insertAttributedString:string atIndex:0];
    // 用label的attributedText属性来使用富文本
    lable.attributedText = attri;
    
    return lable;
}


- (void)goSport
{
    
}
@end
