//
//  LHJTabControlTowViewController.m
//  iOSProject
//
//  Created by Thomas on 2019/9/26.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJDietViewController.h"
#import "FSCalendar.h"
#import "NSDate+GFCalendar.h"
#import "XYKEateHeardViewCell.h"
#import "XYKEateNullTableViewCell.h"
#import "XYKEateTableViewCell.h"

#define XYKEateTableViewCellID @"XYKEateTableViewCellID"
#define XYKEateNullTableViewCellID @"XYKEateNullTableViewCellID"

@interface LHJDietViewController ()<UINavigationControllerDelegate, UITableViewDelegate,UITableViewDataSource, FSCalendarDataSource, FSCalendarDelegate>
@property(nonatomic,strong) UIView * addWindowView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString *dayStr;//根据日期请求数据
@property(nonatomic,strong)NSMutableArray *eatArray;
@property(nonatomic,assign)NSInteger clickInterRow;
@property(nonatomic,strong)NSMutableArray *eatRecordArray;//记录饮食打卡数据
@property(nonatomic,copy)NSString *ifOrNoEate;
@property(nonatomic,copy)NSString *hotStr;
@property(nonatomic,copy)NSString *eatStr;
@property(nonatomic,copy)NSString *toStr;
@property(nonatomic,copy)NSString *hotTitle;

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *zhCalendar;

@property (strong, nonatomic) NSMutableArray *datesWithEvent;
@property (strong, nonatomic) NSArray *titleArray;
@end

@implementation LHJDietViewController

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = @[@"Breakfast",@"Lunch",@"Dinner",@"Snacks"];
    }
    return _titleArray;
}

-(NSArray *)datesWithEventAtIndexes:(NSIndexSet *)indexes
{
    if (_datesWithEvent == nil) {
        _datesWithEvent = [NSMutableArray array];
    }
    return _datesWithEvent;
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
    self.navigationController.delegate = self;
    [self setMainView];
}

- (void)setMainView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.eatArray = [NSMutableArray array];
    self.eatRecordArray = [NSMutableArray array];
    
    NSInteger year = [[NSDate date] dateYear];
    NSInteger month = [[NSDate date] dateMonth];
    NSInteger day = [[NSDate date] dateDay];
    [self getYear:year andMonth:month andDay:day];
    
    NSString *titleStr = [NSString stringWithFormat:@"%02ld月%ld日 ",month,day];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:titleStr];
    NSTextAttachment *attch = [[NSTextAttachment alloc]init];
    attch.image = [UIImage imageNamed:@"diet_title_calendar_image"];
    attch.bounds = CGRectMake(0, 2, 12, 6);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:(NSTextAttachment *)(attch)];
    [attri appendAttributedString:string];
//    self.navigationController.navigationBar.titleLabel.attributedText = attri;
//    self.navigationController.navigationBar.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYKEateNullTableViewCell" bundle:nil] forCellReuseIdentifier:@"XYKEateNullTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYKEateTableViewCell" bundle:nil] forCellReuseIdentifier:@"XYKEateTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYKEateHeardViewCell" bundle:nil] forCellReuseIdentifier:@"XYKEateHeardViewCell"];
    
    if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }

    
}


-(void)getYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day {
    
    NSString *monthDay=[NSString stringWithFormat:@"%ld",month];
    NSString *dayDay=[NSString stringWithFormat:@"%ld",day];
    NSString *nowDay;
    NSString *nowMonth;
    if (monthDay.length==1) {
        nowMonth=[NSString stringWithFormat:@"%@%@",@"0",monthDay];
        NSLog(@"~~%@",nowMonth);
        
    }else{
        nowMonth=monthDay;
    }
    if (dayDay.length==1){
        nowDay=[NSString stringWithFormat:@"%@%@",@"0",dayDay];
        NSLog(@"~~%@",nowDay);
    }else{
        nowDay=dayDay;
    }
    self.dayStr = [NSString stringWithFormat:@"%ld%@%@", year, nowMonth,nowDay];
}




#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    xWEAKSELF;
//    NSLog(@"name - %@",[self.eatArray[indexPath.row]objectForKey:@"name"]);
    if (indexPath.row == 0) {
        
        XYKEateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XYKEateTableViewCellID];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"XYKEateTableViewCell" owner:self options:nil][0];
        }
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.eateLabel.text = @"Milk, White bread, Cheese";
        cell.qkLabel.text = @"Intake 400 cal";
        cell.jykLabel.text = @"Recommend 478 cal";
        cell.clickadd = ^(NSString *title) {
            //点击添加按钮
//            [weakSelf toaddEate:title];
            
        };
        if ([cell.titleLabel.text isEqualToString:@"Breakfast"]) {
            cell.pictureImageView.image=[UIImage imageNamed:@"breakfast_icon"];
        }else if ([cell.titleLabel.text isEqualToString:@"Lunch"]){
            cell.pictureImageView.image=[UIImage imageNamed:@"lunch_icon"];
        }else if ([cell.titleLabel.text isEqualToString:@"Dinner"]){
            cell.pictureImageView.image=[UIImage imageNamed:@"dinner_icon"];
        }else{
            cell.pictureImageView.image=[UIImage imageNamed:@"snack_icon"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    XYKEateNullTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XYKEateNullTableViewCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"XYKEateNullTableViewCell" owner:self options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.titleArray[indexPath.row];
//    cell.qkLabel.text = [NSString stringWithFormat:@"建议摄入%@千卡",[self.eatArray[indexPath.row]objectForKey:@"recommend"]];
    cell.qkLabel.text = [NSString stringWithFormat:@"Recommend%@cal",@"533"];
    
    cell.nofontclickAdd = ^(NSString *title) {
        //点击添加按钮
//        [weakSelf toaddEate:title];
        
    };
    if ([cell.titleLabel.text isEqualToString:@"Breakfast"]) {
        cell.pictureImageView.image=[UIImage imageNamed:@"breakfast_icon"];
    }else if ([cell.titleLabel.text isEqualToString:@"Lunch"]){
        cell.pictureImageView.image=[UIImage imageNamed:@"lunch_icon"];
    }else if ([cell.titleLabel.text isEqualToString:@"Dinner"]){
        cell.pictureImageView.image=[UIImage imageNamed:@"dinner_icon"];
    }else{
        cell.pictureImageView.image=[UIImage imageNamed:@"snack_icon"];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 180;
    } else {
        return 120;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    xWEAKSELF;
    XYKEateHeardViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"XYKEateHeardViewCell" owner:self options:nil][0];
    cell.frame = CGRectMake(0, 0, xScreenWidth, 328 * KHeight);
    cell.eatLabel.text = @"1450";
    cell.xhLabel.text = @"1750";
    cell.hotLabel.text = @"300";
//    cell.titleLabel.text = @"Cal left";
    cell.contentView.backgroundColor = [UIColor whiteColor];
    if ([self.eatStr intValue]>[self.toStr intValue]) {
        cell.hotLabel.textColor = RGB(253, 160, 11);
        
    }else{
        cell.hotLabel.textColor = RGB(102, 102, 102);
    }
    
    cell.clickToWeak = ^{
        //点击进入周数据
//        XYKToWeakViewController *toWeakVC = [[XYKToWeakViewController alloc]init];
//        toWeakVC.time = weakSelf.dayStr;
//        [weakSelf.navigationController pushViewController:toWeakVC animated:NO];
//        // 设置翻页动画为从右边翻上来
//        [UIView transitionWithView:weakSelf.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
        
    };
    cell.clickToBack = ^{
//        if ([weakSelf.ifOrNoEate isEqualToString:@"1"]) {
//            XYKEatBackViewController *eatBack = [[XYKEatBackViewController alloc]init];
//            eatBack.time = weakSelf.dayStr;
//            [weakSelf.navigationController pushViewController:eatBack animated:YES];
//        }else{
//            [weakSelf showMessage:@"请添加食物"];
//        }
    };
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (xScreenHeight > 800) ? 352 : (328 * KHeight);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
@end
