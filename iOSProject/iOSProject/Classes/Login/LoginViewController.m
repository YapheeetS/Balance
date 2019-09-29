//
//  XYKLoginViewController.m
//  xyk
//
//  Created by Ss H on 2018/7/26.
//  Copyright © 2018年 Ss H. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

#define DurationTime 5
@interface LoginViewController ()<UITextFieldDelegate, CAAnimationDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *PassWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginMima;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBottomMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewTopMargin;

@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , assign) NSInteger count; // 动画执行次数

@end

@implementation LoginViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}


-(void)setupUI {
    
    self.count = 0;
    if (xScreenWidth > 800) {
        self.imageViewBottomMargin.constant = 80;
        self.imageViewTopMargin.constant = 60;
    } else {
        self.imageViewBottomMargin.constant = 50;
        self.imageViewTopMargin.constant = 50;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"" norImage:@"diet_calendar_close" higImage:@"diet_calendar_close" target:self action:@selector(clickBackBtn)];
    
    
    
    self.PhoneNumberTextField.delegate = self;
    self.PassWordTextField.delegate = self;
    
//    [self changeImageWithAnimation];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)changeImageWithAnimation {

    if (self.timer) {
        return;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:DurationTime target:self selector:@selector(countDown) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer fire];
}

-(void)countDown {
    
    if (self.count == 5) {
        self.count = 0;
    }
    
    if ([self.imgView.layer.animationKeys containsObject:@"animate"]) {
        [self.imgView.layer removeAnimationForKey:@"animate"];
    }
    
    
    self.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_login_0%ld",self.count]];
    
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animation];
    scaleX.keyPath = @"transform.scale.x";
    scaleX.values = @[@(1), @(1.3)];
    scaleX.removedOnCompletion = false;
    
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animation];
    scaleY.keyPath = @"transform.scale.y";
    scaleY.values = @[@(1), @(1.3)];
    scaleY.removedOnCompletion = false;
    
    // 显示
    CAKeyframeAnimation *opacity = [CAKeyframeAnimation animation];
    opacity.keyPath = @"opacity";
    opacity.values = @[@(0), @(1)];
    opacity.beginTime = 0.0;
    opacity.speed = 2.5;
    opacity.removedOnCompletion = false;
    
    // 隐藏
    CAKeyframeAnimation *opacity1 = [CAKeyframeAnimation animation];
    opacity1.keyPath = @"opacity";
    opacity1.values = @[@(1), @(0)];
    opacity1.beginTime = 4;
    opacity1.speed = 5;
    opacity1.removedOnCompletion = false;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[opacity, scaleX, scaleY, opacity1];
    group.duration = DurationTime;
    //    group.autoreverses = true;
    group.repeatCount = MAXFLOAT;
    group.delegate = self;
    group.removedOnCompletion = false;
    [self.imgView.layer addAnimation:group forKey:@"animate"];
    
    self.count ++;
}


// !!!: 是否明文显示密码
- (IBAction)clickShowPwdBtn:(id)sender {
    
    self.loginMima = (UIButton*)sender;
    
    self.loginMima.selected = !self.loginMima.selected;
    
    if (self.loginMima.selected) { // 按下去了就是明文
        
        NSString *tempPwdStr = self.PassWordTextField.text;
        self.PassWordTextField.text = @""; // 这句代码可以防止切换的时候光标偏移
        self.PassWordTextField.secureTextEntry = NO;
        self.PassWordTextField.text = tempPwdStr;
        
    } else { // 暗文
        NSString *tempPwdStr = self.PassWordTextField.text;
        self.PassWordTextField.text = @"";
        self.PassWordTextField.secureTextEntry = YES;
        self.PassWordTextField.text = tempPwdStr;
    }
    
}

- (IBAction)clickRegisterBtn:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:true];
    
}

- (IBAction)clickForgetBtn:(id)sender {
    
    
}


// !!!: 登录
- (IBAction)toLoginButtonAction:(id)sender {
    
    

}


// !!!: UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    xWEAKSELF;
    if ([textField isEqual:self.PassWordTextField] && self.view.y == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.view.frame = CGRectMake(0, -80, xScreenWidth, xScreenHeight);
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    xWEAKSELF;
    if ([textField isEqual:self.PassWordTextField] && self.view.y == -80) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.view.frame = CGRectMake(0, 0, xScreenWidth, xScreenHeight);
        }];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    xWEAKSELF;
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.view.frame = CGRectMake(0, 0, xScreenWidth, xScreenHeight);
    }];
}


///监听应用退到后台
- (void)didEnterBackground{
    
    // 移除定时器
    [self.timer invalidate];
    self.timer = nil;
    [self.imgView.layer removeAnimationForKey:@"animate"];
}

///进入
- (void)didBecomeActive{
    
    //重新添加动画  type 非零即可
    [self changeImageWithAnimation];
}
@end
