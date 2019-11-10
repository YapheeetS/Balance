//
//  XYKChooseHomeViewController.m
//  xyk
//
//  Created by Ss H on 2018/8/15.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "XYKChooseHomeViewController.h"
#import "KEScrollView.h"
#import "SBScrollRulerView.h"
//#import "XYKChooseDetalViewController.h"
//#import "CFLManger.h"


@interface XYKChooseHomeViewController ()<UIScrollViewDelegate,SBScrollRulerViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIView *oneView;

///尺子view
@property (strong, nonatomic) SBScrollRulerView *rulerView;
@property (nonatomic, copy) NSString *unit;
@property (strong, nonatomic)UILabel *valueLbl;
@property (strong, nonatomic)UILabel *qkLbl;
@property (strong, nonatomic)UILabel *kLbl;

@property (strong, nonatomic)UIButton *quedingButton;
@property (strong, nonatomic)UIButton *quxiaoButton;


//左侧按键的编号
@property (nonatomic,assign) NSInteger index;
@property (copy, nonatomic)NSString *danwei;//食物单位

@property (copy, nonatomic)NSString *hotFor100k;
@property (copy, nonatomic)NSString *hotStr;//热量
@property (copy, nonatomic)NSString *kStr;//克
@property (copy, nonatomic)NSString *eatNum;//食物数量
@property (copy, nonatomic)NSString *eatHot;//食物大卡
@property (copy, nonatomic)NSString *eatKg;//食物单位
//编辑食物
@property (copy, nonatomic)NSString *clickTitle;
@property (copy, nonatomic)NSString *num;

@property (nonatomic, strong)UIImageView *iconImageView;
@property (nonatomic, strong)UILabel *foodLabel;

@property (nonatomic, strong) UIScrollView *bgview;
@property (nonatomic, strong) UIView *greenView;

@end

@implementation XYKChooseHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.titleArray = [NSMutableArray array];
//    self.secondArray = [NSMutableArray array];
    [self oneViewUI];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.icon]]];
    self.foodLabel.text = [NSString stringWithFormat:@"%@",self.foodName];
    if (self.titleArray.count != 0) {
        self.danwei = self.titleArray[0];
    }
    [self getTitleMessage:self.titleArray[0]andNum:100];
}

-(UIButton *)quedingButton
{
    if (!_quedingButton) {
        _quedingButton = [[UIButton alloc]init];
        [_quedingButton setTitle:@"Finish" forState:UIControlStateNormal];
        [_quedingButton setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        _quedingButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
        [_quedingButton addTarget:self action:@selector(quedingButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _quedingButton.backgroundColor = [UIColor whiteColor];
    }
    return _quedingButton;
}
-(UIButton *)quxiaoButton
{
    if (!_quxiaoButton) {
        _quxiaoButton = [[UIButton alloc]init];

        [_quxiaoButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_quxiaoButton setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        _quxiaoButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
        [_quxiaoButton addTarget:self action:@selector(quxiaoButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _quxiaoButton.backgroundColor = [UIColor whiteColor];
    }
    return _quxiaoButton;
}
-(UIButton *)lookButton
{
    if (!_lookButton) {
        _lookButton = [[UIButton alloc]init];
        _lookButton.frame = CGRectMake(0, 0, 120, 30);
        _lookButton.backgroundColor=[UIColor whiteColor];
        [_lookButton setTitle:@"查看食物详情" forState:UIControlStateNormal];
//        _lookButton.titleLabel.font=textFont15;
        [_lookButton setTitleColor:RVCShareIns.rulerTitle_Color forState:UIControlStateNormal];
        [_lookButton addTarget:self action:@selector(lookButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_lookButton setBackgroundColor:[UIColor whiteColor]];
    }
    return _lookButton;
}
//热量数
-(UILabel *)qkLbl
{
    if (!_qkLbl) {
        _qkLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 120, 20)];
        _qkLbl.textColor = RGB(102, 102, 102);
        _qkLbl.font = [UIFont fontWithName:@"PingFangSC-Thin" size:14];

    }
    return _qkLbl;
}

//重量
-(UILabel *)kLbl
{
    if (!_kLbl) {
        _kLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 100, 20)];
//        _kLbl.textColor = SD_TextColor;
//        _kLbl.font=textFont12;
    }
    return _kLbl;
}

//确定按钮
-(void)quedingButtonAction
{
    self.eatHot=[NSString stringWithFormat:@"%.1f",[[self.qkLbl.text stringByReplacingOccurrencesOfString:@"cal" withString:@""] floatValue]];
    self.eatKg=[NSString stringWithFormat:@"%ld",[[self.kLbl.text stringByReplacingOccurrencesOfString:@"g" withString:@""]integerValue]];
    if ([self.fromDetail isEqualToString:@"yes"]) {
        self.clickedior(self.eatID, self.danwei, self.eatNum, self.kStr, self.titleStr, self.type, self.eatHot);
    }else{
        self.clicktoqd(self.eatID, self.danwei, self.eatNum, self.kStr, self.titleStr, self.type, self.eatHot);
    }
}
-(void)quxiaoButtonAction
{
    self.clicktoqx();
}
//查看食物详情
-(void)lookButtonAction
{
    self.clickDeatil(self.eatID, self.titleStr);
}
-(void)oneViewUI
{
    self.oneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.oneView.backgroundColor = RGB(247, 247, 247);
    [self.view addSubview:self.oneView];
    
    UIView *cellView = [[UIView alloc]init];
    cellView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFood)];
    [cellView addGestureRecognizer:tap];
    [self.oneView addSubview:cellView];
    [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oneView);
        make.left.mas_equalTo(self.oneView);
        make.right.mas_equalTo(self.oneView);
        make.height.mas_equalTo(60);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    [cellView addSubview:iconImageView];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.layer.cornerRadius = 20.0f;
    iconImageView.clipsToBounds = true;
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(cellView).offset(20);
        make.centerY.mas_equalTo(cellView);
    }];
    self.iconImageView = iconImageView;
    
    UILabel *foodLabel = [[UILabel alloc]init];
    [cellView addSubview:foodLabel];
    foodLabel.textColor = RGB(51, 51, 51);
    foodLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:15];
    [foodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 25));
        make.left.mas_equalTo(iconImageView.mas_right).offset(20);
        make.centerY.mas_equalTo(cellView);
    }];
    self.foodLabel = foodLabel;
    
    UIImageView *accessImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"diet_detail_access"]];
    [cellView addSubview:accessImageView];
    [accessImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 15));
        make.right.mas_equalTo(cellView.mas_right).offset(-20);
        make.centerY.mas_equalTo(cellView.mas_centerY);
    }];
    
    if (self.clickDeatil == nil) {
        accessImageView.hidden = true;
    }
    
    UIView *sepView = [[UIView alloc]init];
    [self.oneView addSubview:sepView];
    sepView.backgroundColor = RGB(247, 247, 247);
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellView.mas_bottom);
        make.left.mas_equalTo(cellView).offset(10);
        make.right.mas_equalTo(cellView).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.oneView addSubview:self.bgview];
    [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.oneView);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(self.oneView);
        make.top.mas_equalTo(sepView.mas_bottom);
    }];
    
    [self.oneView addSubview:self.greenView];
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgview.mas_bottom);
        make.centerX.mas_equalTo(self.oneView);
        make.size.mas_equalTo(CGSizeMake(20, 2));
    }];
    
    [self.oneView addSubview:self.qkLbl];
    [self.qkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 35));
        make.left.mas_equalTo(self.oneView).offset(16);
        make.top.mas_equalTo(self.bgview.mas_bottom).offset(20);
    }];
    
    
    self.valueLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 60, 100, 30)];
    self.valueLbl.textColor = RGB(84, 150, 252);
    self.valueLbl.font = [UIFont fontWithName:@"PingFangSC-Light" size:30];
    self.valueLbl.textAlignment = NSTextAlignmentCenter;
    [self.oneView addSubview:self.valueLbl];
    [self.valueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 35));
        make.centerY.mas_equalTo(self.qkLbl);
        make.centerX.mas_equalTo(self.oneView);
    }];
    
    UIButton *goWeightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.oneView addSubview:goWeightBtn];
    [goWeightBtn setTitle:@"估算重量" forState:UIControlStateNormal];
    [goWeightBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    goWeightBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
    [goWeightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.centerY.mas_equalTo(self.valueLbl);
        make.right.mas_equalTo(self.oneView.mas_right).offset(-10);
    }];
    [goWeightBtn addTarget:self action:@selector(goWeight) forControlEvents:UIControlEventTouchUpInside];
    goWeightBtn.hidden = true;
    
    
    if (![self.fromDetail isEqualToString:@"yes"]) {
        [self getMessage];
    }else{
        [self getEditor];
    }
    
    [self.oneView addSubview:self.rulerView];
    [self.rulerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.oneView.mas_width);
        make.height.mas_equalTo(75);
        make.top.mas_equalTo(self.valueLbl.mas_bottom).offset(15);
        make.left.mas_equalTo(self.oneView);
    }];
    
    UIView *linvie=[[UIView alloc]init];
    linvie.backgroundColor=RVCShareIns.rulerTitle_Color;
    [self.oneView addSubview:linvie];
    [linvie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.rulerView.mas_top);
        make.right.mas_equalTo(self.rulerView);
        make.left.mas_equalTo(self.rulerView);
        make.height.mas_equalTo(2);
    }];
    
    
    [self.oneView addSubview:self.quxiaoButton];
    [self.quxiaoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rulerView.mas_bottom);
        make.width.mas_equalTo(self.oneView.width/2);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(self.oneView);
    }];
    
    [self.oneView addSubview:self.quedingButton];
    [self.quedingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rulerView.mas_bottom);
        make.width.mas_equalTo(self.oneView.width/2);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(self.oneView);
    }];
    
    

}

- (void)tapFood
{
    if (self.clickDeatil) {
        self.clickDeatil(self.eatID, self.titleStr);
    }
    
}

- (void)goWeight
{
    if (self.clickToWeight) {
        self.clickToWeight();
    }
    
}

//编辑饮食接口
-(void)getEditor{
    
//    NSString *userID=[NSString stringWithFormat:@"%@",[CFLManger instance].loginName];
//    NSDictionary *dic = @{@"key":userID,@"food_id":self.eatID,@"meal_type":self.type,@"eat_time":self.time};
//    __weak XYKChooseHomeViewController *weakSelf = self;
//    [SharedApiClient apiPostPath:XYKEateDetailEditor param:dic complection:^(KSResponseState *state, id responseObject) {
//        NSLog(@"%@",state.data);
//        weakSelf.titleArray=[[state.data objectForKey:@"company"]objectForKey:@"company"];
//        weakSelf.secondArray=[[state.data objectForKey:@"company"]objectForKey:@"spec"];
//        weakSelf.clickTitle=[NSString stringWithFormat:@"%@",[[state.data objectForKey:@"company"]objectForKey:@"record_spec"]];
//        weakSelf.num=[NSString stringWithFormat:@"%@",[[state.data objectForKey:@"company"]objectForKey:@"record_spec_num"]];
//        [weakSelf.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[state.data objectForKey:@"icon"]]]];
//        weakSelf.foodLabel.text = [NSString stringWithFormat:@"%@",[state.data objectForKey:@"food_name"]];
//        NSString *record_kg = [NSString stringWithFormat:@"%@",[[state.data objectForKey:@"company"]objectForKey:@"record_kg"]];
////        [weakSelf getTitleMessage:weakSelf.clickTitle andNum:[weakSelf.num floatValue]];
//        if (weakSelf.titleArray.count != 0) {
//            weakSelf.danwei = weakSelf.titleArray[0];
//        }
//        [weakSelf getTitleMessage:weakSelf.titleArray[0]andNum:100];
//    }];
}
//饮食接口
-(void)getMessage
{
//    NSString *userID=[NSString stringWithFormat:@"%@",[CFLManger instance].loginName];
//    NSDictionary *dic = @{@"key":userID,@"food_id":self.eatID};
//    __weak XYKChooseHomeViewController *weakSelf = self;
//    [SharedApiClient apiPostPath:XYKAddEat param:dic complection:^(KSResponseState *state, id responseObject) {
//        NSLog(@"%@",state.data);
//        weakSelf.titleArray=[[state.data objectForKey:@"company"]objectForKey:@"company"];
//        weakSelf.secondArray=[[state.data objectForKey:@"company"]objectForKey:@"spec"];
//        [weakSelf.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[state.data objectForKey:@"icon"]]]];
//        weakSelf.foodLabel.text = [NSString stringWithFormat:@"%@",[state.data objectForKey:@"food_name"]];
//        if (weakSelf.titleArray.count != 0) {
//            weakSelf.danwei = weakSelf.titleArray[0];
//        }
//        [weakSelf getTitleMessage:weakSelf.titleArray[0]andNum:100];
//
//    }];
}

-(UIScrollView *)bgview
{
    if (!_bgview) {
        _bgview = [[UIScrollView alloc] initWithFrame:CGRectMake(xScreenWidth/2-(xScreenWidth/2)/2.5/2, 0, (xScreenWidth)/2.5*self.titleArray.count, 50)];
        _bgview.contentSize=CGSizeMake((xScreenWidth)/2.5*self.titleArray.count, 50);
        _bgview.panGestureRecognizer.delaysTouchesBegan = YES;
        _bgview.backgroundColor = [UIColor whiteColor];
        _bgview.showsHorizontalScrollIndicator = false;
        _bgview.showsVerticalScrollIndicator = false;
        _bgview.scrollEnabled = NO;
        _bgview.contentSize = CGSizeMake(2000, 0);
    }
    return _bgview;
}


-(UIView *)greenView
{
    if (!_greenView) {
        _greenView=[[UIView alloc]init];
        _greenView.backgroundColor=RGB(254, 196, 27);
    }
    return _greenView;
}
//获取食物标题
-(void)getTitleMessage:(NSString *)clickTitle andNum:(float)num
{
    
    [self.oneView sendSubviewToBack:_bgview];
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *oneButton = [[UIButton alloc]init];
        oneButton.frame = CGRectMake(xScreenWidth/2 +(xScreenWidth/2)/2*i - (xScreenWidth/2)/2/2, 0, (xScreenWidth/2)/2, 50);
        [oneButton setTitle:[NSString stringWithFormat:@"%@",self.titleArray[i]] forState:UIControlStateNormal];
        oneButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:14];
        [oneButton setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        oneButton.tag = 100+i;
        [self.bgview addSubview:oneButton];

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panButtonAction)];
        [pan setDelegate:self];
        [oneButton addGestureRecognizer:pan];
        [pan requireGestureRecognizerToFail:_bgview.panGestureRecognizer];
        [oneButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self requstMessage:num withTitle:clickTitle];
    }
}

-(void)panButtonAction
{
//    NSLog(@"asds");

}
//点击标题按钮事件
-(void)buttonAction:(UIButton *)sender
{
    self.index = sender.tag - 100;
    if ([self.titleArray[self.index] rangeOfString:@"g"].location != NSNotFound) {
        [self requstMessage:100 withTitle:self.titleArray[self.index]];
    }else{
        [self requstMessage:2 withTitle:self.titleArray[self.index]];
    }
    self.danwei = self.titleArray[self.index];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bgview.contentOffset=CGPointMake((xScreenWidth/2)/2*self.index, 0);
    }];
}
//根据标题获取食物热量值
-(void)requstMessage:(float)num withTitle:(NSString *)title
{
    self.unit=title;
    self.hotStr=[NSString stringWithFormat:@"%@",[self.secondArray[self.index]objectForKey:@"hot"]];
    self.qkLbl.text =[NSString stringWithFormat:@"%@%@",self.hotStr,@"cal"];
    self.kStr=[NSString stringWithFormat:@"%@",[self.secondArray[self.index]objectForKey:@"kg"]];
    self.kLbl.text =[NSString stringWithFormat:@"%@%@",self.kStr,@"g"];
    
    
    if ([title rangeOfString:@"g"].location != NSNotFound){
        self.hotFor100k = self.hotStr;
//        self.danwei = @"克";
        RVCShareIns.step = 1;
        RVCShareIns.betweenNum = 10;
        RVCShareIns.rulerGap = 10;
        RVCShareIns.maxValue = 1000;
        RVCShareIns.minValue = 0;
        [self.rulerView reDrawRectRulerView:RVCShareIns];
        [self.rulerView setRealValue:num animated:YES];
    }else{
//        self.danwei = @"";
        RVCShareIns.step = 0.5;
        RVCShareIns.betweenNum = 2;
        RVCShareIns.rulerGap = 50;
        RVCShareIns.maxValue = 1000;
        RVCShareIns.minValue = 0;
        [self.rulerView reDrawRectRulerView:RVCShareIns];
        [self.rulerView setRealValue:num animated:YES];
        self.valueLbl.text = [NSString stringWithFormat:@"1.0%@",title];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.valueLbl.text];
        NSRange range = [self.valueLbl.text rangeOfString:title];
        [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:12] range:range];
        self.valueLbl.attributedText = attri;
    }
    
}
- (SBScrollRulerView *)rulerView{
    if (!_rulerView) {
        
        _rulerView = [[SBScrollRulerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, RVCShareIns.rulerView_H) theMinValue:0 theMaxValue:10 theStep:0.5 theUnit:@"" theNum:2];
        _rulerView.delegate = self;
        _rulerView.bgColor = RGB(247, 247, 247);
        _rulerView.triangleColor = RGB(254, 196, 27);
    }
    return _rulerView;
}
#pragma mark - SBScrollRulerViewDelegate
- (void)sbScrollRulerView:(SBScrollRulerView *)rulerView valueChange:(float)value{
    self.valueLbl.text = [NSString stringWithFormat:@"%.1lf%@",value,self.unit];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.valueLbl.text];
    NSRange range = [self.valueLbl.text rangeOfString:self.unit];
    [attri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:12] range:range];
    self.valueLbl.attributedText = attri;
    
    self.eatNum=[NSString stringWithFormat:@"%.1lf",value];

    [self getmessHot:value];
}
-(void)getmessHot:(float)value
{
    if (self.index == 0) {
        self.qkLbl.text =[NSString stringWithFormat:@"%.1lf%@",value *[self.hotStr floatValue]/100.0,@"cal"];
        self.kStr = [NSString stringWithFormat:@"%.1f",value];
    } else {
        self.qkLbl.text =[NSString stringWithFormat:@"%.1lf%@",value *[self.hotStr integerValue],@"cal"];
        self.kStr = [NSString stringWithFormat:@"%.0f",value * [self.hotStr floatValue] / [self.hotFor100k floatValue] * 100.0];
    }
    self.kLbl.text =[NSString stringWithFormat:@"%.1lf%@",value,@"g"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
