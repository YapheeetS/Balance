//
//  LHJTabControlOneViewController.m
//  iOSProject
//
//  Created by Thomas on 2019/9/26.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJBalanceViewController.h"
#import "LHJBalanceCell.h"


@interface LHJBalanceViewController () <ChartViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PieChartView *chartView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *dataDict;
@end

@implementation LHJBalanceViewController

-(NSMutableDictionary *)dataDict{
    if (_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
        [_dataDict setObject:@"0" forKey:@"consume"];
        [_dataDict setObject:@"0" forKey:@"intake"];
        
    }
    return _dataDict;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
//        [_dataArray addObject: @[@[@"Walking", @"40 Cal"], @[@"Running", @"200 Cal"], @[@"Basketball", @"200 Cal"], @[@"Cycling", @"100 Cal"]]];
//        [_dataArray addObject: @[@[@"Breakfast", @"300 Cal"], @[@"Lunch", @"500 Cal"], @[@"Dinner", @"400 Cal"], @[@"Snacks", @"300 Cal"]]];
    }
    return _dataArray;
}

// tableView懒加载
-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.backgroundColor = RGB(247, 247, 247);
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@", self.dataArray);
    [self setMainView];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData{
    NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYYMMdd"];
        NSString *dateString = [formatter stringFromDate:date];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:xCache.user_id forKey:@"user_id"];
        [params setObject:dateString forKey:@"date"];
        
        NSLog(@"%@", params);
        xWEAKSELF;
        [NetWorkingManager sendPOSTDataWithPath:getBalanceData withParamters:params withProgress:^(float progress) {
            
        } success:^(BOOL isSuccess, id responseObject) {
            NSLog(@"%@", responseObject);
            NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            if ([code isEqualToString:@"200"]) {
                [self.dataDict setObject:responseObject[@"consume"] forKey:@"consume"];
                [self.dataDict setObject:responseObject[@"intake"] forKey:@"intake"];
                self.dataArray = responseObject[@"data_list"];
                [weakSelf.tableView reloadData];
            } else {
                [self showTextHUDWithMessage:responseObject[@"message"]];
            }
            
            
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
}



- (void)setMainView {
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
       }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataArray count] + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if (section == 0) {
        return 1;
    }
    return [self.dataArray[section - 1] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"name - %@",[self.eatArray[indexPath.row]objectForKey:@"name"]);
    if (indexPath.section == 0) {
        LHJBalanceCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell1 == nil) {
            cell1 = [[LHJBalanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell1.consume = self.dataDict[@"consume"];
        cell1.intake = self.dataDict[@"intake"];
        [cell1 reloadChart];
        return cell1;
    } else {
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.backgroundColor = [UIColor whiteColor];
            
        }
        cell2.textLabel.text = self.dataArray[indexPath.section-1][indexPath.row][0];
        cell2.detailTextLabel.text = self.dataArray[indexPath.section-1][indexPath.row][1];
        return cell2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return xScreenWidth-50;
    } else {
        return 64;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return [NSString stringWithFormat:@"Consume: %@Cal", self.dataDict[@"consume"]];
    } else if (section == 2) {
        return [NSString stringWithFormat:@"Intake: %@Cal", self.dataDict[@"intake"]];
    }
    return @"";
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}
@end
