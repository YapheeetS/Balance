//
//  XYKChangeMotionViewController.m
//  xyk
//
//  Created by Jame on 2018/9/4.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "XYKChangeMotionViewController.h"
#import "XYKChangeMotionCell.h"
#import "LHJSportSupplementViewController.h"

@interface XYKChangeMotionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XYKChangeMotionViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Supplement";
    [self setCollectionView];

}



- (void)setCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(117*Kwidth, 117*Kwidth);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 4;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 10, 0, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.backgroundColor = RGB(247, 247, 247);
    [self.collectionView registerClass:[XYKChangeMotionCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.userInteractionEnabled = true;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

#pragma mark -
#pragma mark CollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellId = @"cell";
    XYKChangeMotionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSDictionary *dataDict = (NSDictionary *)self.dataArray[indexPath.row];
    [cell setData:dataDict];
    return  cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dataDict = (NSMutableDictionary *)self.dataArray[indexPath.row];
    __weak typeof(self) weakself = self;
    if (weakself.returnValueBlock) {
        //将自己的值传出去，完成传值
        weakself.returnValueBlock(dataDict);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
//    for (UIViewController *vc in self.navigationController.viewControllers) {
//        if ([vc isKindOfClass:[XYKSportRecordViewController class]]) {
//            XYKSportRecordViewController *popVC = (XYKSportRecordViewController *)vc;
//            popVC.dataDict = (NSMutableDictionary *)dataDict;
//            [self.navigationController popToViewController:popVC animated:YES];
//        }
//    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
