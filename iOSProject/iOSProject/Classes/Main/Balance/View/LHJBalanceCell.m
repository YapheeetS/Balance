//
//  LHJBalanceCell.m
//  iOSProject
//
//  Created by Jame on 2019/10/19.
//  Copyright © 2019 Thomas. All rights reserved.
//

#import "LHJBalanceCell.h"

@interface LHJBalanceCell ()
@property (nonatomic, strong) PieChartView *chartView;
@end

@implementation LHJBalanceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.chartView = [[PieChartView alloc] init];
        [self addSubview:self.chartView];
        [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top);
            make.width.mas_equalTo(self.mas_width).offset(-50);
            make.height.mas_equalTo(self.mas_width).offset(-50);
        }];
        
        [self setupPieChartView:self.chartView];
        self.chartView.entryLabelColor = UIColor.whiteColor;
        self.chartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
        self.chartView.data = [self setChartData];
        [self.chartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
        
        
    }
    return self;
}


- (void)setupPieChartView:(PieChartView *)chartView
{
    chartView.usePercentValuesEnabled = YES;
    chartView.drawSlicesUnderHoleEnabled = NO;
    chartView.holeRadiusPercent = 0.58;
    chartView.transparentCircleRadiusPercent = 0.61;
    chartView.chartDescription.enabled = NO;

    [chartView setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];//饼状图距离边缘的间隙
    chartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
    
    
    chartView.holeRadiusPercent = 0.5;//空心半径占比
    chartView.holeColor = [UIColor clearColor];//空心颜色
    chartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
    chartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"Health365\nby Team3"];
    [centerText setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, centerText.length)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f],
                                NSForegroundColorAttributeName: UIColor.grayColor
                                } range:NSMakeRange(13, centerText.length - 13)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:11.f],
                                NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
                                } range:NSMakeRange(centerText.length - 6, 6)];
    chartView.centerAttributedText = centerText;
    
    chartView.drawHoleEnabled = YES;
    chartView.rotationAngle = 0.0;
    chartView.rotationEnabled = YES;
    chartView.highlightPerTapEnabled = YES;
    chartView.legend.enabled = false;
    
    ChartLegend *l = chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 0.0;
    l.yOffset = 0.0;
}

- (PieChartData *)setChartData{
    
    double mult = 100;
    int count =2;//饼状图总共有几块组成
    
    //每个区块的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        
//        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:randomVal];
        PieChartDataEntry *entry = [[PieChartDataEntry alloc] initWithValue:i == 0 ? 2100 : 1500 label:i == 0 ? @"consume" : @"intake"];
        [yVals addObject:entry];
    }
    
    //每个区块的名称或描述
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        NSString *title = [NSString stringWithFormat:@"part%d", i+1];
        [xVals addObject:title];
    }
    
    //dataSet
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yVals label:@""];;

    dataSet.drawValuesEnabled = YES;//是否绘制显示数据
    NSMutableArray *colors = [[NSMutableArray alloc] init];
//    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//    [colors addObjectsFromArray:ChartColorTemplates.joyful];
//    [colors addObjectsFromArray:ChartColorTemplates.colorful];
//    [colors addObjectsFromArray:ChartColorTemplates.liberty];
//    [colors addObjectsFromArray:ChartColorTemplates.pastel];
//    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    [colors addObject:x_theme];
    [colors addObject:x_theme2];
    dataSet.colors = colors;//区块颜色
    dataSet.sliceSpace = 3;//相邻区块之间的间距
    dataSet.selectionShift = 8;//选中区块时, 放大的半径
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
    //数据与区块之间的用于指示的折线样式
    dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
    dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
    dataSet.valueLineWidth = 1;//折线的粗细
    dataSet.valueLineColor = [UIColor brownColor];//折线颜色

    //data
    PieChartData *data = [[PieChartData alloc] initWithDataSets:@[dataSet]];

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    formatter.maximumFractionDigits = 0;//小数位数
    formatter.multiplier = @1.f;
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];//设置显示数据格式
    [data setValueTextColor:[UIColor brownColor]];
    [data setValueFont:[UIFont systemFontOfSize:10]];
    
    
    return data;
}


@end
