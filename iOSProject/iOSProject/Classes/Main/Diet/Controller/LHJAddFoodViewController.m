//
//  LHJAddFoodViewController.m
//  iOSProject
//
//  Created by Jame on 2019/11/8.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJAddFoodViewController.h"

#import "UISearchBar+FMAdd.h"
#import "HKSearchManager.h"
#import "XYKAddTableViewCell.h"
#import "XYKChooseHomeViewController.h"
#import "XYKAddCellView.h"

#define HEX_COLOR(x_RGB) [UIColor colorWithRed:((float)((x_RGB & 0xFF0000) >> 16))/255.0 green:((float)((x_RGB & 0xFF00) >> 8))/255.0 blue:((float)(x_RGB & 0xFF))/255.0 alpha:1.0f]

@interface LHJAddFoodViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,weak)UITextField *searchField;
@property (nonatomic,weak)UISearchBar *customSearchBar;
@property (nonatomic,strong)NSArray *myArray;//搜索记录的数组
@property (nonatomic,strong)NSMutableArray *myMutableArray;
@property (nonatomic,assign)BOOL tagSearch;//是否点击搜索框

@property (nonatomic,strong)NSMutableArray *listArray;//记录食物数组
@property (nonatomic,strong)UITableView *eattableView;
@property (nonatomic,strong)XYKChooseHomeViewController *chooseVC;
@property (nonatomic,strong)NSMutableArray *searchlistArray;//搜索食物数组

@property (nonatomic,strong)NSMutableDictionary *showdic;
@property (nonatomic,strong)NSIndexPath *eatIndextPath;//记录点击的cell
@property (nonatomic,strong)UIView *bootem;
@property (nonatomic,strong)UIButton *toPicture;

@property(nonatomic,strong) UIView * addWindowView;
@property (nonatomic, strong)XYKAddCellView * searchView;
@end

@implementation LHJAddFoodViewController
{
    int _currentRow;
    int _currentSection;
}

-(UIView *)bootem
{
    if (!_bootem) {
        _bootem=[[UIView alloc]initWithFrame:CGRectMake(0, xScreenHeight-70, xScreenWidth, 70)];
        _bootem.backgroundColor=[UIColor whiteColor];
        _bootem.userInteractionEnabled=YES;
    }
    return _bootem;
}
//-(UIButton *)toPicture
//{
//    if (!_toPicture) {
//        _toPicture=[UIButton buttonWithType:UIButtonTypeSystem];
//        [_toPicture setBackgroundImage:[UIImage imageNamed:@"diet_take_photo"] forState:UIControlStateNormal];
//        [_toPicture addTarget:self action:@selector(toPictureButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _toPicture;
//}
-(NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
-(NSMutableArray *)searchlistArray
{
    if (!_searchlistArray) {
        _searchlistArray = [NSMutableArray array];
    }
    return _searchlistArray;
}

-(UITableView *)eattableView
{
    if (_eattableView==nil) {
        _eattableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _eattableView.delegate=self;
        _eattableView.dataSource=self;
        _eattableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    return _eattableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Add food";
    [self loadCommonFood];
    [self setupView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)setupView
{
    UIView *BJView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [self.view addSubview: BJView];
    
    UISearchBar *customSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,BJView.bounds.size.width,50)];
    customSearchBar.delegate = self;
    customSearchBar.placeholder = @"Search food";
    [BJView addSubview:customSearchBar];
    self.customSearchBar = customSearchBar;
    
    // 设置背景颜色
    //设置背景图是为了去掉上下黑线
    customSearchBar.backgroundImage = [[UIImage alloc] init];
    // 设置SearchBar的颜色主题为白色
    customSearchBar.barTintColor =  HEX_COLOR(0xF2F2F2);
    
    // 设置圆角和边框颜色
    UITextField *searchField = [customSearchBar valueForKey:@"searchField"];
    if (searchField) {
        
        [searchField setBackgroundColor: HEX_COLOR(0xF2F2F2)];
        searchField.layer.cornerRadius = 18.0f;
        searchField.layer.borderColor =  HEX_COLOR(0xF2F2F2).CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
        searchField.keyboardType = UIReturnKeySearch;
    }
    self.searchField = searchField;
    //修正光标颜色
    [searchField setTintColor:[UIColor grayColor]];
    
    // 设置输入框文字颜色和字体
    [customSearchBar fm_setTextColor:[UIColor blackColor]];
    [customSearchBar fm_setTextFont:[UIFont systemFontOfSize:14]];
    
    //修改搜索图标
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"diet_food_search"]];
    img.frame = CGRectMake(10, 0,15,15);
    self.searchField.leftView = img;
    self.searchField.leftViewMode = UITextFieldViewModeAlways;
    
    //修改clearButton
    UIButton *clearButton = [self.searchField valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"icon_9_1"] forState:UIControlStateNormal];
    
    [self.view addSubview:self.eattableView];
    [self.eattableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(50);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
//    XYKAddCellView * searchView=[[XYKAddCellView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, xScreenHeight - 70) array:self.searchlistArray];
//    searchView.toDetail = ^(NSString *eatID, NSString *name) {
        //点击进入食物详情
//        XYKChooseDetalViewController *detailVC=[[XYKChooseDetalViewController alloc]init];
//        detailVC.eatID=eatID;
//        detailVC.titleStr=name;
//        detailVC.time = self.time;
//        detailVC.type = self.type;
//        [self.navigationController pushViewController:detailVC animated:YES];
//    };
//    [self.view addSubview:searchView];
//    self.searchView = searchView;
//    searchView.hidden = true;
    
}

- (void)loadCommonFood {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    

    NSLog(@"%@", params);
    xWEAKSELF;
    [NetWorkingManager sendPOSTDataWithPath:getCommonFood withParamters:params withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"200"]) {
            weakSelf.listArray = [responseObject objectForKey:@"food_list"];
            [weakSelf.eattableView reloadData];
        } else {
            [self showTextHUDWithMessage:responseObject[@"message"]];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *ID = @"XYKAddTableViewCell";
    XYKAddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"XYKAddTableViewCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.namelab.text =[NSString stringWithFormat:@
                        "%@",[self.listArray[indexPath.row] objectForKey:@"hot"]];
    [cell.pictureImageView sd_setImageWithURL:[self.listArray[indexPath.row]objectForKey:@"icon"]];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",[self.listArray[indexPath.row] objectForKey:@"name"]];
    
    return cell;
        
}

#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;

}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *hisView = [[UIView alloc]init];
//    hisView.backgroundColor = RGB(244, 245, 246);
//    //搜索历史标题
//    UILabel *titleLabel = [[UILabel alloc]init];
//    if (self.tagSearch == YES) {
//        titleLabel.text = @"搜索历史";
//    }else{
//        titleLabel.text = @"常见食物";
//    }
//    titleLabel.font = [UIFont systemFontOfSize:15];
//    titleLabel.textColor = [UIColor colorWithRed:134.0/255 green:134.0/255 blue:134.0/255 alpha:1.0];
//    [hisView addSubview:titleLabel];
//
//    //删除历史记录
//    UIButton *Deletbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [Deletbtn setImage:[UIImage imageNamed:@"历史删除"] forState:UIControlStateNormal];
//    [hisView addSubview:Deletbtn];
//    [Deletbtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    if ([titleLabel.text isEqualToString:@"常见食物"]) {
//        Deletbtn.frame = CGRectZero;
//        hisView.frame = CGRectMake(0, 0, self.view.frame.size.width, 45);
//        titleLabel.frame = CGRectMake(10, 15, 120, 15);
//    }else{
//        if (self.myMutableArray.count == 0) {
//            Deletbtn.frame = CGRectZero;
//        }else{
//            Deletbtn.frame = CGRectMake(self.view.frame.size.width-50,0,40, 45);
//        }
//        hisView.frame = CGRectMake(0, 0, self.view.frame.size.width, 45);
//        titleLabel.frame = CGRectMake(10, 15, 120, 15);
//    }
//    return hisView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

//        NSLog(@"点击常见食物");
    self.eatIndextPath=indexPath;
    [self addWindow:indexPath];
//        BOOL section =[[self.showdic objectForKey:@(indexPath.row)] boolValue];
//        [self.showdic setObject:@(!section) forKey:@(indexPath.row)];
//        [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        

}

-(void)addWindow:(NSIndexPath*)index
{
    self.addWindowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.addWindowView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
    /*添加手势事件,移除View*/
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissContactView:)];
    tapGesture.delegate=self;
    [self.addWindowView addGestureRecognizer:tapGesture];
    self.chooseVC=[[XYKChooseHomeViewController alloc]init];
    self.chooseVC.fromDetail=@"no";
    self.chooseVC.eatID=[NSString stringWithFormat:@"%@",[self.listArray[index.row]objectForKey:@"id"]];
    self.chooseVC.titleStr=[NSString stringWithFormat:@"%@",[self.listArray[index.row]objectForKey:@"name"]];
    self.chooseVC.type=self.type;
    self.chooseVC.time=self.time;
    self.chooseVC.titleArray = self.listArray[index.row][@"company"];
    self.chooseVC.secondArray = self.listArray[index.row][@"spec"];
    self.chooseVC.icon = self.listArray[index.row][@"icon"];
    self.chooseVC.foodName = self.listArray[index.row][@"name"];
    
    __weak LHJAddFoodViewController *weakSelf = self;
    self.chooseVC.clickDeatil = ^(NSString *eatID, NSString *name){
        //点击进入食物详情
//        XYKChooseDetalViewController *detailVC=[[XYKChooseDetalViewController alloc]init];
//        detailVC.eatID=eatID;
//        detailVC.titleStr=name;
//        detailVC.time=weakSelf.time;
//        detailVC.type=weakSelf.type;
//        [weakSelf.addWindowView removeFromSuperview];
//        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    };
    self.chooseVC.view.frame=CGRectMake(0, xScreenHeight, xScreenWidth, 300);
    
    self.chooseVC.clicktoqd = ^(NSString *eatID,NSString*spec,NSString*num,NSString*kg,NSString*name,NSString *type,NSString*hotStr) {
        //点击确定按钮保存食物记录
        
//        NSString *userID=[NSString stringWithFormat:@"%@",xCache.user_id];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:weakSelf.diet_id forKey:@"diet_id"];
        [dic setObject:hotStr forKey:@"calories"];
        [dic setObject:name forKey:@"name"];
        [dic setObject:weakSelf.type forKey:@"meal_type"];
        
        [weakSelf saveFood:dic];
        
    };
    self.chooseVC.clicktoqx = ^{
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.chooseVC.view.frame=CGRectMake(0, xScreenHeight, xScreenWidth, 300);
        } completion:^(BOOL finished) {
            [weakSelf.addWindowView removeFromSuperview];
        }];
    };
    self.chooseVC.clickToWeight = ^{
//        [weakSelf.addWindowView removeFromSuperview];
//        XYKWeightEstimateViewController *weVC = [[XYKWeightEstimateViewController alloc]init];
//        [weakSelf.navigationController pushViewController:weVC animated:YES];
    };
    
    [self.addWindowView addSubview:self.chooseVC.view];
    [[UIApplication sharedApplication].keyWindow addSubview:self.addWindowView];
    [UIView animateWithDuration:0.3 animations:^{
        self.chooseVC.view.frame=CGRectMake(0, xScreenHeight-300, xScreenWidth, 300);
    }];
}

- (void)saveFood:(NSMutableDictionary *)dict{
    
    xWEAKSELF;
    [NetWorkingManager sendPOSTDataWithPath:addFood withParamters:dict withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"200"]) {
            
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.chooseVC.view.frame=CGRectMake(0, xScreenHeight, xScreenWidth, 300);
            } completion:^(BOOL finished) {
                [weakSelf.addWindowView removeFromSuperview];
                [weakSelf showTextHUDWithMessage:@"Success!"];
            }];
            
        } else {
            [self showTextHUDWithMessage:responseObject[@"message"]];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
}

- (void)searchFood:(NSString *)str{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:str forKey:@"name"];

    NSLog(@"%@", params);
    xWEAKSELF;
    [NetWorkingManager sendPOSTDataWithPath:searchFoodWithName withParamters:params withProgress:^(float progress) {
        
    } success:^(BOOL isSuccess, id responseObject) {
        NSLog(@"%@", responseObject);
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"200"]) {
            weakSelf.listArray = [responseObject objectForKey:@"food_list"];
            [weakSelf.eattableView reloadData];
        } else {
            [self showTextHUDWithMessage:responseObject[@"message"]];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


//实时监听searchBar的输入框变化
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange:%@",searchText);
    if ([searchText isEqualToString:@""]) {
        [self loadCommonFood];
    }
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.tagSearch = YES;
    [self readNSUserDefaults];
    NSLog(@"textBegin");
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    self.tagSearch =NO;
    [self.searchField resignFirstResponder];
    if (self.searchField.text.length > 0) {
        
//        [HKSearchManager SearchText:self.searchField.text];//缓存搜索记录
//        [self readNSUserDefaults];
        [self searchFood:self.searchField.text];
//        [self.eattableView removeFromSuperview];
        
    }
    
    //判断是否有相同记录，有就移除
//    if (self.myMutableArray == nil) {
//
//        self.myMutableArray = [[NSMutableArray alloc]init];
//
//    }else if ([self.myMutableArray containsObject:self.searchField.text]){
//
//        [self.myMutableArray removeObject:self.searchField.text];
//    }
//    [self.myMutableArray addObject:self.searchField.text];
//
//    [self saveNSUserDefaults];
//    [self.eattableView reloadData];
    
}
/** 删除历史记录 */
- (void)deleteBtnAction:(UIButton *)sender{
    
    [HKSearchManager removeAllArray];
    self.myMutableArray = nil;
    [self.eattableView reloadData];
}

/** 本地保存 */
-(void)saveNSUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.myMutableArray forKey:@"myArray"];
    [defaults synchronize];
    [self.eattableView reloadData];
}
/** 取出缓存的数据 */
-(void)readNSUserDefaults{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    
    //这里要把数组转换为可变数组
    NSMutableArray *myMutableArray = [NSMutableArray arrayWithArray:myArray];
    
    self.myMutableArray = myMutableArray;
    [self.eattableView reloadData];
    NSLog(@"myArray======%@",myArray);
}


//移除addWindowView
- (void)dismissContactView:(UITapGestureRecognizer *)tapGesture{
    __weak LHJAddFoodViewController *weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.chooseVC.view.frame=CGRectMake(0, xScreenHeight, xScreenWidth, 300);
    } completion:^(BOOL finished) {
        [weakSelf.addWindowView removeFromSuperview];
    }];
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isDescendantOfView:self.chooseVC.view]) {
        return NO;
    }
    return YES;
}

@end
