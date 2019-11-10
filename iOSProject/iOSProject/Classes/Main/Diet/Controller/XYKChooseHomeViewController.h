//
//  XYKChooseHomeViewController.h
//  xyk
//
//  Created by Ss H on 2018/8/15.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clicktoDetail)(NSString *eatID,NSString *name);
typedef void(^clicktoqd)(NSString *eatID,NSString*spec,NSString*num,NSString*kg,NSString*name,NSString *type,NSString*hotStr);
typedef void (^clickedior)(NSString *eatID,NSString*spec,NSString*num,NSString*kg,NSString*name,NSString *type,NSString*hotStr);
typedef void(^clicktoqx)(void);
typedef void (^goWeightEstimate)(void);

@interface XYKChooseHomeViewController : UIViewController
@property (strong, nonatomic)UIButton *lookButton;//查看食物详情
@property(nonatomic,strong)NSString *quxiao;//是否是从食物详情中进入

@property (strong, nonatomic)NSString *eatID;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *fromDetail;//是否是编辑食物规格中进入的
@property(nonatomic,strong)NSString *time;

@property (strong, nonatomic)NSString *icon;
@property (strong, nonatomic)NSString *foodName;
@property (strong, nonatomic)NSMutableArray *titleArray;
@property (strong, nonatomic)NSMutableArray *secondArray;

@property(nonatomic,copy)clicktoDetail clickDeatil;
@property(nonatomic,copy)clicktoqd clicktoqd;
@property(nonatomic,copy)clickedior clickedior;
@property(nonatomic,copy)clicktoqx clicktoqx;
@property(nonatomic,copy)goWeightEstimate clickToWeight;
@end
