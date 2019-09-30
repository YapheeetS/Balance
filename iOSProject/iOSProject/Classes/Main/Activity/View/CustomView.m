#import "CustomView.h"
#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * (degrees))/ 180)

@interface CustomView ()

@property (strong, nonatomic) UILabel *ratioLabel;

@property CGFloat startAngle;       // 开始角度
@property CGFloat endAngle;         // 结束角度
@property CGFloat animCountAngle;   // 动画结束角度

@property (strong, nonatomic) NSString *ratio;          // 百分比
@property (strong, nonatomic) NSString *animRatio;      // 动画百分比

@property CGFloat animTime;             // 动画时间

@property UIColor *foregroundColor;     // 前景颜色
@property UIColor *cusBackgroundColor;  // 背景圈颜色

@property int radiuFont;

@end

@implementation CustomView

- (void)setViewForegroundColor:(UIColor *)color {
    _foregroundColor = color;
    [self setNeedsDisplay];
}

- (void)setViewBackgroundColor:(UIColor *)color {
    _cusBackgroundColor = color;
    [self setNeedsDisplay];
}

- (void)setStartAngle:(CGFloat)sAngle toEndAngle:(CGFloat)eAngle {
    [self setStartAngle:sAngle toEndAngle:eAngle byAnimationTime:0];
}

- (void)setStartAngle:(CGFloat)sAngle toEndAngle:(CGFloat)eAngle byAnimationTime:(CGFloat)time {
    [self setStartAngle:sAngle toEndAngle:eAngle byRatio:nil byAnimationTime:time];
}

- (void)setStartAngle:(CGFloat)sAngle toEndAngle:(CGFloat)eAngle byRatio:(NSString *)ratio byAnimationTime:(CGFloat)time {
    if (ratio == nil) {
        _ratio = nil;
        _animRatio = nil;
    }
    
    if (time > 0) {
        if (ratio != nil) {
            _ratio = @"0";
            _animRatio = ratio;
        }
        
        _startAngle = sAngle;
        _endAngle = sAngle;
        _animCountAngle = eAngle;
        _animTime = time;
        
        [NSThread detachNewThreadSelector:@selector(doSomething) toTarget:self withObject:nil];
    }else {
        if (ratio != nil) {
            _ratio = ratio;
        }
        
        _startAngle = sAngle;
        _endAngle = eAngle;
        _animTime = 0;
        
        [self setNeedsDisplay];
    }
}

- (void)doSomething {
    // 获取循环次数
    int count = (_animCountAngle - _startAngle)/2 + 1;
    if (count <= 0) count = 1;
    
    // 定义时间间隔
    CGFloat timeSlot = _animTime * 1.0/count;     // 每一度停止时间
    if (timeSlot < 0) timeSlot = 0;
    
    // 获取角度间隔
    int angleSlot = 2;
    
    // 获取百分比间隔
    CGFloat ratioSlot = 0;
    if (_animRatio != nil) ratioSlot = [_animRatio floatValue]* 1.0/count;
    
    @synchronized(self) {
        // 循环更新UI
        for (int i = 0; i <= count; i++) {
            // 设置显示的角度
            _endAngle = _startAngle + i * angleSlot;
            if (_endAngle > _animCountAngle) _endAngle = _animCountAngle;
            
            // 设置
            if (_animRatio != nil) _ratio = [NSString stringWithFormat:@"%.2f",(float)(0 + i * ratioSlot)];
            else _ratio = nil;
            
            [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
            if (self.animation) {
                [NSThread sleepForTimeInterval:timeSlot];
            }
        }
    }
    [self performSelectorOnMainThread:@selector(adimEnd) withObject:nil waitUntilDone:YES];
}

//更新UI
- (void)updateUI {
    [self setNeedsDisplay];
}

// 等会结束
- (void)adimEnd {
     //判断是否定义了回调协议，调用协议
    if([self.delegate respondsToSelector:@selector(animationEndForCustomView)]) {
        [self.delegate animationEndForCustomView];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat bgsAngle = _endAngle;
    CGFloat bgeAngle = _startAngle;
    if (_endAngle == 0 && _startAngle == 0 ) {
        bgsAngle = 0;
        bgeAngle = 360;
    }
    if (_endAngle == 360 && _startAngle == 360) {
        bgsAngle = 0;
        bgeAngle = 360;
    }
    CGFloat centerX = CGRectGetWidth(rect)/2.0;
    CGFloat centerY = CGRectGetHeight(rect)/2.0;
    CGFloat radius = _cusRadius;
    if (radius <= 0) radius = 30;
    
    CGFloat lineWidth = _cusLineWidth;
    if (lineWidth <= 0) lineWidth = 3.0;
    //An opaque type that represents a Quartz 2D drawing environment.
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*画圆*/
    
    //边框圆 -- 底色
    UIColor *aColor = _cusBackgroundColor;
    if (!aColor) aColor = [UIColor colorWithRed:78/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);  //画笔线的颜色
    
    CGContextSetLineWidth(context, lineWidth);//线的宽度
     CGContextAddArc(context, centerX, centerY, radius, 2*PI*(bgsAngle/360.0),8*PI*(bgeAngle/360.0), NO);      // 添加一个圆
    CGContextDrawPath(context, kCGPathStroke);              // 绘制路径
    
    //边框圆 -- 前景色
    UIColor *bColor = _foregroundColor;
    if (!bColor) bColor = [UIColor colorWithRed:27/255.0 green:158/255.0 blue:255/255.0 alpha:1];
    CGContextSetStrokeColorWithColor(context, bColor.CGColor);  //画笔线的颜色
    
    CGContextSetLineWidth(context, lineWidth);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    
    CGContextAddArc(context, centerX, centerY, radius, 2*PI*(_startAngle/360.0), 2*PI*(_endAngle/360), NO);      // 添加一个圆
    CGContextDrawPath(context, kCGPathStroke);              // 绘制路径
    if (_isHead) {
        // 画圆弧头部的图片
        CGFloat circleX = 0;
        CGFloat circleY = 0;
        CGFloat imageWidth = 10;
//        CGFloat progressRadian = DEGREES_TO_RADIANS(_endAngle + 90);    // 完成比的弧度
        CGFloat progressRadian;
        if (_endAngle == 0) {
            progressRadian = DEGREES_TO_RADIANS(_endAngle);
        } else {
            progressRadian = DEGREES_TO_RADIANS(_endAngle + 90);
        }
        
        circleX = radius * sin(progressRadian)- imageWidth / 2;
        circleY = -radius * cos(progressRadian)- imageWidth / 2;
        // 从圆心坐标系便宜到左上方原点坐标系
        CGFloat headImgX = self.bounds.size.width/2 + circleX;
        CGFloat headImgY = self.bounds.size.height/2 + circleY;
        
        CGRect imgFrame = CGRectMake(headImgX, headImgY, imageWidth, imageWidth);
        UIImage *headImg;
        if (self.headImage) {
            headImg = self.headImage;
        } else {
            headImg = [UIImage imageNamed:@"sports_progress_head"];
        }
        
        [headImg drawInRect:imgFrame];
    }
    if (self.doubleCircle) {
        /*画圆*/
        
        //边框圆 -- 底色
        UIColor *aColor = _cusBackgroundColor;
        if (!aColor) aColor = [UIColor colorWithRed:78/255.0 green:77/255.0 blue:77/255.0 alpha:1];
        CGContextSetStrokeColorWithColor(context, aColor.CGColor);  //画笔线的颜色
        
        CGContextSetLineWidth(context, 2);//线的宽度
        //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
        // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
        
        CGContextAddArc(context, centerX, centerY, radius + lineWidth / 2 + 5, 2*PI*(bgsAngle/360.0),8*PI*(bgeAngle/360.0), NO);      // 添加一个圆
        CGContextDrawPath(context, kCGPathStroke);              // 绘制路径
        
        //边框圆 -- 前景色
        UIColor *bColor = _foregroundColor;
        if (!bColor) bColor = [UIColor colorWithRed:27/255.0 green:158/255.0 blue:255/255.0 alpha:1];
        CGContextSetStrokeColorWithColor(context, bColor.CGColor);  //画笔线的颜色
        
        CGContextSetLineWidth(context, 2);//线的宽度
        //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
        // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
        
        CGContextAddArc(context, centerX, centerY, radius + lineWidth / 2 + 5, 2*PI*(_startAngle/360.0), 2*PI*(_endAngle/360), NO);      // 添加一个圆
        CGContextDrawPath(context, kCGPathStroke);              // 绘制路径

    }
    // 选择文字
    if (_ratio != nil) {
        NSString *msg = [NSString stringWithFormat:@"%d%@",(int)[_ratio floatValue],@"%"];
        if (!self.ratioLabel) {
            self.ratioLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
            self.ratioLabel.center = CGPointMake(centerX, centerY);
            [self addSubview:self.ratioLabel];
            
            _ratioLabel.backgroundColor = [UIColor clearColor];
            _ratioLabel.font = [UIFont systemFontOfSize:self.radiuFont];
            _ratioLabel.textColor = [UIColor colorWithRed:80 / 255.0 green:80 / 255.0 blue:80 / 255.0 alpha:1];
            _ratioLabel.textAlignment = NSTextAlignmentCenter;
        }
        self.ratioLabel.center = CGPointMake(centerX, centerY);
        NSMutableAttributedString *pStr = [[NSMutableAttributedString alloc] initWithString:msg];
        [pStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.radiuFont] range:NSMakeRange(0, msg.length - 1)];
        [pStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.radiuFont / 2] range:NSMakeRange(msg.length - 1, 1)];
        [pStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1] range:NSMakeRange(0, msg.length - 1)];
        [pStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(msg.length - 1, 1)];
        self.ratioLabel.attributedText = pStr;
    }else {
        [self.ratioLabel removeFromSuperview];
    }
}

- (void)setRadiusFont:(int)font{
//    _ratioLabel.font = [UIFont systemFontOfSize:font];
    self.radiuFont = font;
}

@end
