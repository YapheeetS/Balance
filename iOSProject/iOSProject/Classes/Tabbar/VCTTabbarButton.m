//
//  VCTTabbarButton.m
//
//
//

#import "VCTTabbarButton.h"
const double VCTTabBarImageRatio = 0.6;//缩放比例
@implementation VCTTabbarButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //1.图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //2.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:[UIColor colorFromHexCode:@"#878787"] forState:UIControlStateNormal];
        [self setTitleColor:x_theme forState:UIControlStateSelected];

        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//去掉父类在高亮时所作的操作
- (void)setHighlighted:(BOOL)highlighted {
}

#pragma mark - 覆盖父类的2个方法
#pragma mark - 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY = contentRect.size.height * VCTTabBarImageRatio;
    CGFloat titleH = contentRect.size.height - titleY;
    CGFloat titleW = contentRect.size.width;
    return CGRectMake(0, titleY, titleW,  titleH);
}

#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageH = contentRect.size.height * VCTTabBarImageRatio;
    CGFloat imageW = contentRect.size.width;
    return CGRectMake(0, 0, imageW,  imageH);
}

- (void)setItem:(UITabBarItem *)item {
    _item = item;

    //1.利用kvo监听item属性值的改变
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:0  context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0  context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0  context:nil];

    //2.属性赋值
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

/**
 *  KVO监听必须在监听器释放的时候，移除监听操作
 *  通知也得在释放的时候移除监听
 */
- (void)dealloc {
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}

/**
 *  监听item的属性值改变
 *
 *  @param keyPath 哪个属性改变了
 *  @param object  哪个对象的属性改变了
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *, id> *)change context:(void *)context {
    //设置文字（两种状态）
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    //设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
}

@end
