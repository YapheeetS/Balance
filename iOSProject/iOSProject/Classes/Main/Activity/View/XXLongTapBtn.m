#import "XXLongTapBtn.h"
#define DurationTime 1.5
#define kRadius (self.frame.size.width) / 2
@interface XXLongTapBtn()

@property (nonatomic , assign) CGFloat progress;
@property (nonatomic , strong) CAShapeLayer *progressLayer;
@property (nonatomic , strong) CAShapeLayer *outLayer;
@property (nonatomic , strong) CALayer *gradientLayer;
@property (nonatomic , assign) BOOL isFinished;
@property (nonatomic , strong) NSTimer *timer;
@end

@implementation XXLongTapBtn

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
        self.circleColor = [UIColor redColor];
    }
    return self;
}


-(void)setupUI {
    
    CGRect frame = self.frame;
    self.layer.cornerRadius = frame.size.width / 2;
    self.layer.masksToBounds = true;
    self.bgcImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//    self.bgcImageView.image = [UIImage imageNamed:@"826bff842ed4180f05bf73352c6b5465"];
    [self insertSubview:self.bgcImageView atIndex:0];
    [self.bgcImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.size);
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
    }];
    if (self.durationTime == 0) {
        self.durationTime = DurationTime;
    }
    
    [self drawOutCycle];
    self.isFinished = true;
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(start:)];
    longPressGesture.minimumPressDuration = 0.2f;//设置长按 时间
    [self addGestureRecognizer:longPressGesture];
}

// !!!: 恢复初始化界面
-(void)reset {
    
    [self.timer invalidate];
    self.timer = nil;
    [self.progressLayer removeAllAnimations];
    [self.progressLayer removeFromSuperlayer];
    self.progressLayer = nil;
}

// !!!: 中途取消动画
-(void)cancel {
    
//    if (!self.isFinished) {
//        self.isFinished = true;
//        if (self.didFinishBlock) {
//            self.didFinishBlock();
//        }
//    }
    [self reset];
}

// !!!: 长按手势 绘制图形及开始动画
-(void)start:(UILongPressGestureRecognizer *)longRecognizer {
    
    
    if (longRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"long pressTap state : begin");
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(startLongRecognizer)]) {
            [self.delegate startLongRecognizer];
        }
        
        self.isFinished = false;
        [self reset];
        __weak typeof(self) weakSelf = self;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_durationTime repeats:false block:^(NSTimer * _Nonnull timer) {
            
            
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
            weakSelf.isFinished = true;
            // 一段时间后执行
            if (weakSelf.didFinishBlock) {
                weakSelf.didFinishBlock();
            }
        }];
        
        [self drawCycleProgress];
        
        // 添加动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = _durationTime;
        animation.removedOnCompletion = true;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = @(0);
        animation.toValue = @(1);
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.progressLayer addAnimation:animation forKey:@"drawCircleAnimation"];
    }else if(longRecognizer.state != UIGestureRecognizerStateChanged){
        NSLog(@"long pressTap state : end");
        [self cancel];
    }
}

// !!!: 绘制占位圆形
- (void)drawOutCycle {
    
    self.outLayer = [CAShapeLayer layer];
    CGRect rect = {0, 0, self.frame.size.width, self.frame.size.height};
    UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:rect];
    self.outLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.outLayer.lineWidth = 10;
    self.outLayer.fillColor =  [UIColor clearColor].CGColor;
    self.outLayer.lineCap = kCALineCapRound;
    self.outLayer.path = path1.CGPath;
    [self.layer addSublayer:self.outLayer];
}

// !!!: 绘制进度圆
- (void)drawCycleProgress {
    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);  //设置圆心位置
    CGFloat radius = kRadius;  //设置半径
    CGFloat startA = - M_PI_2;  //圆起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2;  //圆终点位置
    
    
    //获取环形路径（画一个圆形，填充色透明，设置线框宽度为10，这样就获得了一个环形）
    _progressLayer = [CAShapeLayer layer];//创建一个track shape layer
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
    _progressLayer.strokeColor = [self.circleColor CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
    _progressLayer.opacity = 1; //背景颜色的透明度
    _progressLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _progressLayer.lineWidth = 2;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];//上面说明过了用来构建圆形
    _progressLayer.path = [path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    [self.layer addSublayer:_progressLayer];
    
    
    
//    // 一下代码用于 生成渐变色
//    _gradientLayer = [CALayer layer];
//
//    //左侧渐变色
//    CAGradientLayer *leftLayer = [CAGradientLayer layer];
//    leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);    // 分段设置渐变色
//    leftLayer.locations = @[@0.3, @0.9, @1];
//    leftLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor greenColor].CGColor];
//    [_gradientLayer addSublayer:leftLayer];
//
//    //右侧渐变色
//    CAGradientLayer *rightLayer = [CAGradientLayer layer];
//    rightLayer.frame = CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height);
//    rightLayer.locations = @[@0.3, @0.9, @1];
//    rightLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor redColor].CGColor];
//    [_gradientLayer addSublayer:rightLayer];
//
//    [self.layer setMask:_progressLayer]; //用progressLayer来截取渐变层
//    [self.layer addSublayer:_gradientLayer];
}

@end
