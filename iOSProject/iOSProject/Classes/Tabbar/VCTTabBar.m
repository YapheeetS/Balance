//
//  VCTTabBar.m
//
//
//

#import "VCTTabBar.h"
#import "VCTTabbarButton.h"

@interface VCTTabBar ()
@property (strong, nonatomic) NSMutableArray *redViewArr;
@end

@implementation VCTTabBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)plusButtonClick {
    if ([self.delegate respondsToSelector:@selector(tabBardidPlusButton:)]) {
        [self.delegate tabBardidPlusButton:self];
    }
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item {
    // 创建按钮
    VCTTabbarButton *button = [[VCTTabbarButton alloc]init];
    [self.tabBarButtons addObject:button];
    button.item = item;
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];

    // 默认选中
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

- (void)buttonClick:(VCTTabbarButton *)button {
    //1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    //2.控制器选中按钮
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

// 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];

    //1. 4个按钮
    CGFloat buttonW = xScreenWidth / self.tabBarButtons.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;

    for (NSInteger index = 0; index < self.tabBarButtons.count; index++) {
        VCTTabbarButton *button = self.tabBarButtons[index];
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = index;
    }
}

// !!!: 选中某个button
- (void)setSelectButtonAtIndex:(NSInteger)index {
    if (index < self.tabBarButtons.count) {
        VCTTabbarButton *button = self.tabBarButtons[index];
        self.selectedButton.selected = NO;
        button.selected = YES;
        self.selectedButton = button;
    }
}

// !!!: lazy
- (NSMutableArray *)tabBarButtons {
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (NSMutableArray *)redViewArr {
    if (_redViewArr == nil) {
        _redViewArr = [NSMutableArray array];
    }
    return _redViewArr;
}

@end
