//
//  XLCardSwitchFlowLayout.m
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "XLCardSwitchFlowLayout.h"

//居中卡片宽度与据屏幕宽度比例
static float CardWidthScale = 0.75f;
static float CardHeightScale = 0.9f;

@implementation XLCardSwitchFlowLayout

//初始化方法
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
}

//设置缩放动画
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //扩大控制范围，防止出现闪屏现象
    CGRect bigRect = rect;
    bigRect.size.width = rect.size.width + 2*[self cellWidth];
    bigRect.origin.x = rect.origin.x - [self cellWidth];
    
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:bigRect]];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    return arr;
}

#pragma mark -
#pragma mark 配置方法

//卡片宽度
- (CGFloat)cellWidth {
    return self.collectionView.bounds.size.width * CardWidthScale;
}

//卡片间隔
- (float)cellMargin {
    return (self.collectionView.bounds.size.width - [self cellWidth])/50.0f;
}

//设置左右缩进
- (CGFloat)collectionInset {
    return self.collectionView.bounds.size.width/2.0f - [self cellWidth]/2.0f;
}

#pragma mark -
#pragma mark 约束设定
//最小纵向间距
- (CGFloat)minimumLineSpacing {
    return [self cellMargin];
}
//cell大小
- (CGSize)itemSize {
    return CGSizeMake([self cellWidth],self.collectionView.bounds.size.height * CardHeightScale);
}

#pragma mark -
#pragma mark 其他设定
//是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}


- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *attriArray = [super layoutAttributesForElementsInRect:targetRect];
    CGFloat horizontalCenterX = proposedContentOffset.x + (self.collectionView.bounds.size.width/2.0);
    CGFloat offsetAdjustment = (CGFloat)MAXFLOAT;
    for (UICollectionViewLayoutAttributes *layoutAttributes in attriArray) {
        CGFloat itemHorizontalCenterX = layoutAttributes.center.x;
        if(fabs(itemHorizontalCenterX-horizontalCenterX) < fabs(offsetAdjustment)){
            offsetAdjustment = itemHorizontalCenterX - horizontalCenterX;
        }
        
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end
