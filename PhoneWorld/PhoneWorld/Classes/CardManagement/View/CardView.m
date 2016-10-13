//
//  CardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CardView.h"

#define buttonWidth (screenWidth-135)/2

@interface CardView ()

@property (nonatomic) NSArray *imageNames;

@end

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self imageNames];
        for (int i = 0; i < 5; i ++) {
            NSInteger line = i/2;
            NSInteger queue = i%2;
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50 + (buttonWidth + 35)*queue, 50 + (buttonWidth + 35)*line, buttonWidth, buttonWidth)];
            [btn setBackgroundImage:[UIImage imageNamed:self.imageNames[i]] forState:UIControlStateNormal];
            btn.tag = 300+i;
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)buttonClicked:(UIButton *)button{
    _myCallBack(button.tag);
}

- (NSArray *)imageNames{
    if (_imageNames == nil) {
        _imageNames = @[@"Group",@"Group",@"Group",@"Group",@"Group"];
    }
    return _imageNames;
}

@end
