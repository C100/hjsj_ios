//
//  FinishCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "FinishCardView.h"
#import "FailedView.h"
#import "ChoosePackageViewController.h"
#import "InputView.h"

@interface FinishCardView ()

@property (nonatomic) FailedView *failedView;
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSMutableArray *inputViews;

@end

@implementation FinishCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.leftTitles = @[@"手机号码",@"PUK码"];
        self.inputViews = [NSMutableArray array];
        for (int i = 0; i < self.leftTitles.count; i++) {
            InputView *inputView = [[InputView alloc] initWithFrame:CGRectMake(0, 41*i, screenWidth, 40)];
            [self addSubview:inputView];
            inputView.leftLabel.text = self.leftTitles[i];
            inputView.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
            [self.inputViews addObject:inputView];
        }
        
        [self nextButton];
    }
    return self;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        InputView *inputV = self.inputViews.lastObject;
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(inputV.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:MainColor forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 20;
        _nextButton.layer.borderColor = MainColor.CGColor;
        _nextButton.layer.borderWidth = 1;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method

- (void)buttonClickAction:(UIButton *)button{
    [self endEditing:YES];
    InputView *phone = self.inputViews.firstObject;
    InputView *puk = self.inputViews.lastObject;
    if ([Utils isMobile:phone.textField.text] && [Utils isNumber:puk.textField.text]) {
        //检测
        //成功
        ChoosePackageViewController *vc = [ChoosePackageViewController new];
        vc.userinfosDic = [@{@"phoneNumber":phone.textField.text,@"phoneAddress":@"浙江省杭州市",@"phoneState":@"已激活",@"networkType":@"话机通信"} mutableCopy];
        UIViewController *viewController = [self viewController];
        [viewController.navigationController pushViewController:vc animated:YES];
        
        //失败
        self.failedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"验证失败" andDetail:@"手机号码或PUK码错误" andImageName:@"attention" andTextColorHex:@"#333333"];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.failedView];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeGrayView) userInfo:nil repeats:NO];
    }else{
        if (![Utils isMobile:phone.textField.text]) {
            [Utils toastview:@"请输入正确格式手机号"];
        }else if(![Utils isNumber:puk.textField.text]){
            [Utils toastview:@"请输入正确格式PUK码"];
        }
    }
}

- (void)removeGrayView{
    [UIView animateWithDuration:0.5 animations:^{
        self.failedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.failedView removeFromSuperview];
    }];
}

@end
