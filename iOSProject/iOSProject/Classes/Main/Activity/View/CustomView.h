#import <UIKit/UIKit.h>

#define PI 3.14159265358979323846

@protocol CustomViewDelegate <NSObject>

@optional

- (void)animationEndForCustomView;

@end

@interface CustomView : UIView
@property (nonatomic, weak) id<CustomViewDelegate> delegate;   // 代理

@property CGFloat cusRadius;        // 圆半径
@property CGFloat cusLineWidth;     // 线宽

//是否画两个圆
@property (nonatomic, assign) BOOL doubleCircle;
//是否开启动画
@property (nonatomic, assign) BOOL animation;
//是否带头部
@property (nonatomic, assign) BOOL isHead;
@property (nonatomic, strong) UIImage *headImage;

/** 设置前景圈颜色 */
- (void)setViewForegroundColor:(UIColor *)color;

/** 设置背景圈颜色 */
- (void)setViewBackgroundColor:(UIColor *)color;

/** 设置显示的启动和结束角度 */
- (void)setStartAngle:(CGFloat)sAngle toEndAngle:(CGFloat)eAngle;

/** 设置显示的启动和结束角度，time 指动画时间 */
- (void)setStartAngle:(CGFloat)sAngle toEndAngle:(CGFloat)eAngle byAnimationTime:(CGFloat)time;

/** 设置显示的启动和结束角度，time 指动画时间 ratio显示进度label*/
- (void)setStartAngle:(CGFloat)sAngle toEndAngle:(CGFloat)eAngle byRatio:(NSString *)ratio byAnimationTime:(CGFloat)time;

- (void)setRadiusFont:(int)font;

@end
