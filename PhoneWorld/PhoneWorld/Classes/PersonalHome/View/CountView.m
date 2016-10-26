//
//  CountView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/21.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CountView.h"  
#import "ChooseView.h"

#define wh 375/312.0  //宽高比
#define chooseViewWidth 66
#define chooseViewHeight 30
#define widthSix (screenWidth - 58*2 - 30)/5  //6个月时间距
#define widthTwelve (screenWidth - 58*2 - 30)/11  //12个月间距

@interface CountView ()

@property (nonatomic) UIView *yearView;
@property (nonatomic) NSMutableArray *chooseViews;
@property (nonatomic) NSMutableArray *monthesArr;
@property (nonatomic) NSMutableArray *viewArr;
@property (nonatomic) NSInteger currentMonthes;

@end

@implementation CountView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.chooseViews = [NSMutableArray array];
        self.monthesArr = [NSMutableArray array];
        self.viewArr = [NSMutableArray array];
        NSArray *titles = @[@"半年",@"一年"];
        self.currentMonthes = 6;
        
        self.accountsOpenedArr = @[@23,@54,@76,@87,@12,@89,@11,@54,@76,@87,@12,@89];

        for (int i = 0; i < 2; i ++) {
            ChooseView *cv = [[ChooseView alloc] initWithFrame:CGRectMake((screenWidth-chooseViewWidth*2-50)/2.0 + (chooseViewWidth+50)*i, 10, chooseViewWidth, chooseViewHeight) andTitle:titles[i]];
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
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 40, 14)];
        lb.text = title;
        lb.textColor = [Utils colorRGB:@"#666666"];
        lb.font = [UIFont systemFontOfSize:12];
        [self addSubview:lb];
        
        for (int i = 0; i < 4; i ++) {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(33, 227-50*i, 23, 16)];
            lb.textAlignment = NSTextAlignmentRight;
            lb.textColor = [Utils colorRGB:@"#999999"];
            lb.font = [UIFont systemFontOfSize:10];
            lb.text = [NSString stringWithFormat:@"%d",25*(i+1)];
            [self addSubview:lb];
        }
    }
    return self;
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
    
    if (tap.view.tag == 100) {
        self.currentMonthes = 6;
        //半年
        [self setNeedsDisplay];
    }else{
        self.currentMonthes = 12;
        //一年
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    NSInteger monthWidth = self.currentMonthes == 6?widthSix:widthTwelve;
    for (UILabel *lb in self.monthesArr) {
        [lb removeFromSuperview];
    }
    for (UIView *v in self.viewArr) {
        [v removeFromSuperview];
    }
    
    for (int i = 0; i < self.currentMonthes; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(58+i * monthWidth - monthWidth/10, 290, monthWidth, 30)];
        lb.textColor = [Utils colorRGB:@"#999999"];
        lb.numberOfLines = 0;
        lb.font = [UIFont systemFontOfSize:10];
        lb.text = [NSString stringWithFormat:@"%d月",i+1];
        [self addSubview:lb];
        lb.textAlignment = NSTextAlignmentCenter;
        [self.monthesArr addObject:lb];
        [bezierPath moveToPoint:CGPointMake(58 + i*monthWidth, 285)];
        [bezierPath addLineToPoint:CGPointMake(58+ i*monthWidth, 282)];
    }
    
    for (int i = 0; i < self.currentMonthes; i ++) {
        NSInteger integ = [self.accountsOpenedArr[i] integerValue];
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(58-4 + monthWidth*i, 85+(100 - integ)*2 - 4, 8, 8)];
        v.backgroundColor = [UIColor whiteColor];
        v.layer.cornerRadius = 4;
        v.layer.borderColor = [Utils colorRGB:@"#eb000c"].CGColor;
        v.layer.borderWidth = 1;
        [self addSubview:v];
        [self.viewArr addObject:v];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(58-10 + monthWidth*i, 85+(100 - integ)*2 - 16, 20, 12)];
        lb.text = [NSString stringWithFormat:@"%d",integ];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont systemFontOfSize:10];
        lb.textColor = [Utils colorRGB:@"#666666"];
        [self addSubview:lb];
        [self.monthesArr addObject:lb];
    }
    UIBezierPath *bezierPath2 = [[UIBezierPath alloc] init];
    
    for (int i = 0; i < self.currentMonthes - 1; i++) {
        NSInteger integ1 = [self.accountsOpenedArr[i] integerValue];
        NSInteger integ2 = [self.accountsOpenedArr[i+1] integerValue];
        [bezierPath2 moveToPoint:CGPointMake(58 + monthWidth*i, 85+(100 - integ1)*2)];
        [bezierPath2 addLineToPoint:CGPointMake(58 + monthWidth*(i+1), 85+(100 - integ2)*2)];
    }
    
    [[Utils colorRGB:@"#eb000c"] setStroke];
    bezierPath2.lineWidth = 1;
    [bezierPath2 stroke];
    
    //58 60
    [bezierPath moveToPoint:CGPointMake(58, 60)];
    //58 285
    [bezierPath addLineToPoint:CGPointMake(58, 285)];
    //screenWidth-40 285
    [bezierPath addLineToPoint:CGPointMake(screenWidth - 40, 285)];
    
    [bezierPath moveToPoint:CGPointMake(53, 65)];
    [bezierPath addLineToPoint:CGPointMake(58, 60)];
    [bezierPath addLineToPoint:CGPointMake(63, 65)];
    
    [bezierPath moveToPoint:CGPointMake(screenWidth-45, 280)];
    [bezierPath addLineToPoint:CGPointMake(screenWidth-40, 285)];
    [bezierPath addLineToPoint:CGPointMake(screenWidth-45, 290)];
    
    for (int i = 0; i < 4; i ++) {
        [bezierPath moveToPoint:CGPointMake(58, 235-50*i)];
        [bezierPath addLineToPoint:CGPointMake(60, 235-50*i)];
    }
    
    [[Utils colorRGB:@"#cccccc"] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
}

@end
