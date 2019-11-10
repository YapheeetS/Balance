//
//  XYKAddCellView.m
//  xyk
//
//  Created by Ss H on 2018/8/27.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "XYKAddCellView.h"
#import "XYAddSearchCell.h"

@interface XYKAddCellView()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation XYKAddCellView

-(instancetype)initWithFrame:(CGRect)frame array:(NSArray*)array
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initview];
        self.listArray=[NSMutableArray arrayWithArray:array];
    }
    return self;
}

-(void)initview
{
    [self addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.tableview registerNib:[UINib nibWithNibName:@"XYAddSearchCell" bundle:nil] forCellReuseIdentifier:@"XYAddSearchCell"];

}

-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview=[[UITableView alloc]init];
        _tableview.delegate=self;
        _tableview.dataSource=self;
    }
    return _tableview;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"XYAddSearchCell";
    XYAddSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[XYAddSearchCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.dic=self.listArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.toDetail([NSString stringWithFormat:@"%@",[self.listArray[indexPath.row]objectForKey:@"id"]], [NSString stringWithFormat:@"%@",[self.listArray[indexPath.row]objectForKey:@"name"]]);
}
@end
