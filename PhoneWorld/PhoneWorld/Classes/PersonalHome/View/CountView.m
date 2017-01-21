//
//  CountView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/21.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CountView.h"  
#import "ChooseView.h"

#define chooseViewWidth 66
#define chooseViewHeight 30
#define hw 312.0/375.0

@interface CountView ()
@property (nonatomic) NSMutableArray *chooseViews;
@property (nonatomic) NSString *title;
@end

@implementation CountView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.chooseViews = [NSMutableArray array];
        NSArray *titles = @[@"六个月",@"六年"];
        self.title = title;
        
        for (int i = 0; i < 2; i ++) {
            ChooseView *cv = [[ChooseView alloc] initWithFrame:CGRectMake((screenWidth-chooseViewWidth*2-50)/2.0 + (chooseViewWidth+50)*i, 10, 120, chooseViewHeight) andTitle:titles[i]];
            cv.tag = 100+i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [cv addGestureRecognizer:tap];
            if (i == 0) {
                cv.leftView.layer.borderColor = [Utils colorRGB:@"#0081eb"].CGColor;
                cv.leftView.layer.borderWidth = 3;
                cv.titleLB.textColor = [Utils colorRGB:@"#0081eb"];
            }
            [self.chooseViews addObject:cv];
            [self addSubview:cv];
        }
        //金额／开户量label
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(34, 40, 60, 14)];
        lb.text = title;
        lb.textColor = [Utils colorRGB:@"#666666"];
        lb.font = [UIFont systemFontOfSize:textfont12];
        lb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lb];
        
        [self lineChart];
    }
    return self;
}

- (PNLineChart *)lineChart{
    if (_lineChart == nil) {
        int height = (int)((screenWidth - 27*2)*hw);
        _lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(27, 58, screenWidth - 27*2, height)];
        [_lineChart setXLabels:@[@"",@"",@"",@"",@"",@""]];
        [_lineChart setShowCoordinateAxis:YES];
        [_lineChart setAxisColor:[Utils colorRGB:@"#cccccc"]];
        [_lineChart setXLabelColor:[Utils colorRGB:@"#999999"]];
        [_lineChart setYLabelColor:[Utils colorRGB:@"#999999"]];
        [self addSubview:_lineChart];
        [_lineChart strokeChart];
    }
    return _lineChart;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    for (ChooseView *chooseV in self.chooseViews) {
        chooseV.leftView.layer.borderColor = [Utils colorRGB:@"#cccccc"].CGColor;
        chooseV.leftView.layer.borderWidth = 1;
        chooseV.titleLB.textColor = [Utils colorRGB:@"#666666"];
    }
    ChooseView *cv = (ChooseView *)tap.view;
    cv.leftView.layer.borderColor = [Utils colorRGB:@"#0081eb"].CGColor;
    cv.leftView.layer.borderWidth = 3;
    cv.titleLB.textColor = [Utils colorRGB:@"#0081eb"];
    
    if (tap.view.tag == 100) {//六个月
        [Utils drawChartLineWithLineChart:self.lineChart andXArray:self.accountsOpenedMonthArr andYArray:self.accountsOpenedArr andMax:self.max andAverage:self.average andTitle:self.title];
    }else{//六年
        [Utils drawChartLineWithLineChart:self.lineChart andXArray:self.accountsOpenedYearArr andYArray:self.accountsOpendCountYearArr andMax:self.max2 andAverage:self.average2 andTitle:self.title];
    }
}

@end
