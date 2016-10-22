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

@interface CountView ()

@property (nonatomic) UIView *yearView;
@property (nonatomic) NSMutableArray *chooseViews;

@end

@implementation CountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.chooseViews = [NSMutableArray array];
        NSArray *titles = @[@"半年",@"一年"];
        for (int i = 0; i < 2; i ++) {
            ChooseView *cv = [[ChooseView alloc] initWithFrame:CGRectMake((screenWidth-chooseViewWidth*2-50)/2.0 + (chooseViewWidth+50)*i, 10, chooseViewWidth, chooseViewHeight) andTitle:titles[i]];
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
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 36, 14)];
        lb.text = @"开户量";
        lb.textColor = [Utils colorRGB:@"#666666"];
        lb.font = [UIFont systemFontOfSize:12];
        [self addSubview:lb];
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
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
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
    
    [[Utils colorRGB:@"#cccccc"] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
}

@end
