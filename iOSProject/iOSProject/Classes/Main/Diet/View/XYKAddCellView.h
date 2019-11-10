//
//  XYKAddCellView.h
//  xyk
//
//  Created by Ss H on 2018/8/27.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^searchToDetail)(NSString *eatID,NSString *name);

@interface XYKAddCellView : UIView
-(instancetype)initWithFrame:(CGRect)frame array:(NSArray*)array;
@property(nonatomic,copy)searchToDetail toDetail;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*listArray;
@end
