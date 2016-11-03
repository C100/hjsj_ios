//
//  AlterLoginPasswordView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AlterLoginPasswordView.h"
#import "InputView.h"
#import "FailedView.h"

@interface AlterLoginPasswordView ()
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) FailedView *failedView;
@end

@implementation AlterLoginPasswordView

- (instancetype)initWithFrame:(CGRect)frame andType:(NSInteger)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftTitles = @[@"原密码",@"新密码",@"确认密码"];
        self.backgroundColor = COLOR_BACKGROUND;
        self.inputViews = [NSMutableArray array];
        
        for (int i = 0; i < self.leftTitles.count; i ++) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            view.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
            [view addGestureRecognizer:tap];
            view.tag = 100+i;
            [self.inputViews addObject:view];
            [self addSubview:view];
            
            if (type == 2) {
                UILabel *lb = [[UILabel alloc] init];
                [self addSubview:lb];
                [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-10);
                    make.width.mas_equalTo(80);
                    make.height.mas_equalTo(20);
                    make.top.mas_equalTo(130);
                }];
                lb.textAlignment = NSTextAlignmentCenter;
                lb.text = @"忘记密码？";
                lb.textColor = MainColor;
                lb.font = [UIFont systemFontOfSize:12];
                lb.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPasswordAction:)];
                [lb addGestureRecognizer:tap];
            }
        }
        
        [self saveButton];
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 120)];
        v.backgroundColor = [UIColor whiteColor];
        [self addSubview:v];
        
    }
    return self;
}

- (UIButton *)saveButton{
    if (_saveButton == nil) {
        _saveButton = [Utils returnBextButtonWithTitle:@"确定"];
        [self addSubview:_saveButton];
        [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(160);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

#pragma mark - Method
- (void)tapAction:(UITapGestureRecognizer *)tap{
    InputView *view = (InputView *)tap.view;
    [view.textField becomeFirstResponder];
}

- (void)saveAction:(UIButton *)button{
    InputView *iv0 = self.inputViews[0];//原密码
    InputView *iv1 = self.inputViews[1];//新密码
    InputView *iv2 = self.inputViews[2];//新密码
    //判断愿密码是否正确
    //判断新密码输入是否一致
    if ([iv1.textField.text isEqualToString:iv2.textField.text] && ![iv0.textField.text isEqualToString:@""]) {
        
        if ([iv0.textField.text isEqualToString:iv1.textField.text]) {
            [Utils toastview:@"原密码不能与新密码一致"];
        }else{
            [self endEditing:YES];
            _AlterPasswordCallBack(button);
        }
        
    }else{
        [Utils toastview:@"两次密码输入不一致"];
    }
}

- (void)forgetPasswordAction:(UITapGestureRecognizer *)tap{
    //弹窗
    self.failedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"请联系客服" andDetail:@"" andImageName:@"attention" andTextColorHex:@"#333333"];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.failedView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeGrayView) userInfo:nil repeats:NO];
}

- (void)removeGrayView{
    [UIView animateWithDuration:0.5 animations:^{
        self.failedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.failedView removeFromSuperview];
    }];
}

@end
