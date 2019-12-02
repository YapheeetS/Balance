//
//  LHJSportManageViewController.m
//  iOSProject
//
//  Created by Jame on 2019/10/19.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJSportManageViewController.h"
#import "XLCardSwitchFlowLayout.h"
#import "XYKSportManageCell.h"
#import "LHJSportsTimeViewController.h"
#import "LHJSportSupplementViewController.h"

@interface LHJSportManageViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIImageView *animationInView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
@end

@implementation LHJSportManageViewController
- (instancetype)init
{
    if (self = [super init]) {
        _selectedIndex = 0;
    }
    return self;
}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Sports";
    self.view.backgroundColor = RGB(247, 247, 247);
    [self setCollectionView];
    [self setOtherView];
    [self loadData];
}

- (void)loadData{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    xWEAKSELF;
    [NetWorkingManager sendPOSTDataWithPath:getActivities withParamters:params withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"200"]) {
            weakSelf.dataArray = responseObject[@"motion_list"];
            [weakSelf.collectionView reloadData];
            
        } else {
            [self showTextHUDWithMessage:responseObject[@"message"]];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setCollectionView {
    XLCardSwitchFlowLayout *flowLayout = [[XLCardSwitchFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.backgroundColor = RGB(247, 247, 247);
    [self.collectionView registerClass:[XYKSportManageCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.userInteractionEnabled = true;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.decelerationRate = 0.5;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(370*KHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.view layoutIfNeeded];
}

- (void)setOtherView {
    UIButton *sportRecordBtn = [[UIButton alloc]init];
    [sportRecordBtn setTitle:@"Supplement" forState:UIControlStateNormal];
    [sportRecordBtn setImage:[UIImage imageNamed:@"sport_record_btn_img"] forState:UIControlStateNormal];
    sportRecordBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    [sportRecordBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    sportRecordBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    [self.view addSubview:sportRecordBtn];
    [sportRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(10*KHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    }];
    [sportRecordBtn addTarget:self action:@selector(goRecord) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat with = 110;
    if (xScreenWidth < 320) {
        with = 92;
    }
    
    [_animationInView.layer removeAllAnimations];
    [_animationInView removeFromSuperview];
    _animationInView = nil;
    _animationInView = [[UIImageView alloc]initWithFrame:CGRectMake((xScreenWidth - with)/2, xScreenHeight - 49 - (xScreenWidth > 320?35:15)- with, with, with)];
    _animationInView.image = [UIImage imageNamed:@"sport_star_btn_animate"];
    [self.view addSubview:_animationInView];
    [_animationInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sportRecordBtn.mas_bottom).offset(30*KHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(with, with));
    }];
    
    [_startButton.layer removeAllAnimations];
    [_startButton removeFromSuperview];
    _startButton = nil;
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startButton.frame = CGRectMake((xScreenWidth - with)/2, xScreenHeight - 49 - (xScreenWidth > 320?35:15)- with, with, with);
    [_startButton setBackgroundImage:[UIImage imageNamed:@"sport_star_btn"] forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _startButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self.view addSubview:_startButton];
    
    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sportRecordBtn.mas_bottom).offset(30*KHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(with, with));
    }];
    
    _animationInView.center = _startButton.center;
    [self animationLayer:_startButton];
    
    
}
- (void)animationLayer:(UIButton *)button{
    CALayer * spreadLayer;
    spreadLayer = [CALayer layer];
    CGFloat diameter = 150;  //扩散的大小
    spreadLayer.bounds = CGRectMake(0,0, diameter, diameter);
    spreadLayer.cornerRadius = diameter/2; //设置圆角变为圆形
    spreadLayer.position = button.center;
    spreadLayer.backgroundColor = [[UIColor orangeColor] CGColor];
    [_animationInView.layer addSublayer:spreadLayer];
    [_animationInView.layer insertSublayer:spreadLayer below:button.layer];
    
    CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 2;
    animationGroup.repeatCount = INFINITY;//重复无限次
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = defaultCurve;
    //尺寸比例动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @1.0;//开始的大小
    scaleAnimation.toValue = @1.4;//最后的大小
    scaleAnimation.duration = 2;//动画持续时间
    //透明度动画
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 2;
    opacityAnimation.values = @[@1.0, @0.8,@0];//透明度值的设置
    opacityAnimation.keyTimes = @[@0, @0.2,@1];//关键帧
    opacityAnimation.removedOnCompletion = NO;
    animationGroup.animations = @[scaleAnimation, opacityAnimation];//添加到动画组
    [_animationInView.layer addAnimation:animationGroup forKey:@"pulse"];
}

- (void)goRecord {
    LHJSportSupplementViewController *srVC = [[LHJSportSupplementViewController alloc] init];
    NSMutableDictionary *dataDict = (NSMutableDictionary *)self.dataArray[self.selectedIndex];
    srVC.dataDict = dataDict;
    srVC.dataArray = self.dataArray;
    [self.navigationController pushViewController:srVC animated:true];
}


- (void)start {
    if (self.dataArray.count == 0) {
        return;
    }
//    NSDictionary *dataDict = (NSDictionary *)self.dataArray[self.selectedIndex];
//    if ([dataDict[@"motion_type"] isEqualToString:@"distance"]) {
//        XYKSportDistanceViewController *sdVC = [[XYKSportDistanceViewController alloc]init];
//        sdVC.motionId = dataDict[@"id"];
//        sdVC.calorie = dataDict[@"consume_calorie"];
//        [self.navigationController pushViewController:sdVC animated:YES];
//    } else {
//        XYKSportTimeViewController *stVC = [[XYKSportTimeViewController alloc]init];
//        stVC.motionId = dataDict[@"id"];
//        stVC.calorie = dataDict[@"consume_calorie"];
//        [self.navigationController pushViewController:stVC animated:YES];
//    }
    NSDictionary *dataDict = (NSDictionary *)self.dataArray[self.selectedIndex];
    
    LHJSportsTimeViewController *vc = [[LHJSportsTimeViewController alloc] init];
    vc.motionId = dataDict[@"motion_id"];
    vc.calorie = dataDict[@"consume_calorie"];
    vc.motionName = dataDict[@"motion_name"];
    [self.navigationController pushViewController:vc animated:true];
    
}


#pragma mark - CollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellId = @"cell";
    XYKSportManageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSDictionary *dataDict = (NSDictionary *)self.dataArray[indexPath.row];
    [cell setData:dataDict];
    return  cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!_collectionView.visibleCells.count) {return;}
    if (!scrollView.isDragging) {return;}
    CGRect currentRect = _collectionView.bounds;
    currentRect.origin.x = _collectionView.contentOffset.x;
    for (XYKSportManageCell *card in _collectionView.visibleCells) {
        if (CGRectContainsRect(currentRect, card.frame)) {
            NSInteger index = [_collectionView indexPathForCell:card].row;
            if (index != _selectedIndex) {
                _selectedIndex = index;
            }
        }
    }
}



@end
