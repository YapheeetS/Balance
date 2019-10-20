#import <UIKit/UIKit.h>

@protocol XXLongTapBtnDelegate <NSObject>
- (void)startLongRecognizer;
@end

@interface XXLongTapBtn : UIButton
@property (nonatomic , strong) UIImageView *bgcImageView;
@property (nonatomic , strong) UIColor *circleColor;
@property (nonatomic , assign) NSInteger durationTime;
@property (nonatomic , copy) void(^didFinishBlock)(void);

@property (nonatomic, weak) id<XXLongTapBtnDelegate> delegate;
@end
