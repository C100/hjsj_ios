//
//  RepairCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RepairCardView.h"
#import "InputView.h"
#import "ChooseImageView.h"
#import "FailedView.h"

@interface RepairCardView ()

@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) NSArray *choices;//邮寄选项
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) ChooseImageView *chooseImageView;
@property (nonatomic) FailedView *finishedView;

@end

@implementation RepairCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(screenWidth, 650);
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = COLOR_BACKGROUND;
        self.inputViews = [NSMutableArray array];
        self.choices = @[@"顺丰到付",@"充值一百免邮费"];
        self.leftTitles = @[@"补卡号码",@"补卡人姓名",@"证件号码",@"证件地址",@"联系电话",@"近期联系号码",@"邮寄地址",@"收件人姓名",@"收件人电话",@"邮寄选项"];
        
        for (int i = 0; i < self.leftTitles.count; i++) {
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            view.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
            if ([self.leftTitles[i] isEqualToString:@"邮寄选项"]) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseEmailAction)];
                [view addGestureRecognizer:tap];
                UIImageView *imageView = [[UIImageView alloc] init];
                [view addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-15);
                    make.centerY.mas_equalTo(0);
                    make.width.mas_equalTo(10);
                    make.height.mas_equalTo(16);
                }];
                imageView.image = [UIImage imageNamed:@"right"];
                imageView.contentMode = UIViewContentModeScaleToFill;
                view.textField.userInteractionEnabled = NO;
                view.textField.text = @"请选择";
                [view.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(0);
                    make.right.mas_equalTo(imageView.mas_left).mas_equalTo(-10);
                    make.left.mas_equalTo(view.leftLabel.mas_right).mas_equalTo(10);
                    make.height.mas_equalTo(30);
                }];
            }
            [self.inputViews addObject:view];
            [self addSubview:view];
        }
        
        [self chooseImageView];
        [self nextButton];
    }
    return self;
}

- (ChooseImageView *)chooseImageView{
    if (_chooseImageView == nil) {
        _chooseImageView = [[ChooseImageView alloc] initWithFrame:CGRectZero andTitle:@"图片（点击图片可放大）" andDetail:@[@"手持身份证正面照",@"身份证背面照"] andCount:2];
        [self addSubview:_chooseImageView];
        InputView *inputV = self.inputViews.lastObject;
        [_chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(inputV.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(130);
        }];
    }
    return _chooseImageView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnBextButtonWithTitle:@"提交"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.chooseImageView.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
            make.bottom.mas_equalTo(-40);
        }];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method
- (void)chooseEmailAction{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"邮寄选项" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < self.choices.count; i++) {
        InputView *inputView = self.inputViews.lastObject;
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.choices[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            inputView.textField.text = self.choices[i];
        }];
        [ac addAction:action1];
    }
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [ac addAction:action2];
    [[self viewController] presentViewController:ac animated:YES completion:nil];
}

- (void)buttonClickAction:(UIButton *)button{
    NSLog(@"--------------下一步");
    //判断信息栏
    for (int i = 0; i < self.leftTitles.count; i ++) {
        InputView *inputV = self.inputViews[i];
        if (i == self.leftTitles.count - 1) {
            if ([inputV.textField.text isEqualToString:@"请选择"]) {
                [Utils toastview:@"请选择邮寄选项"];
                return;
            }
        }
        if ([inputV.textField.text isEqualToString:@""]) {
            NSString *string = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
            [Utils toastview:string];
            return;
        }
    }
    
    for (int i = 0; i < self.chooseImageView.imageViews.count; i ++) {
        UIImageView *imageV = self.chooseImageView.imageViews[i];
        if (!imageV.image) {
            [Utils toastview:@"请选择图片"];
            return;
        }
    }
    
    self.finishedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"提交成功" andDetail:@"请耐心等待..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
    [[UIApplication sharedApplication].keyWindow addSubview:self.finishedView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeGrayView) userInfo:nil repeats:NO];
}

- (void)removeGrayView{
    [UIView animateWithDuration:0.5 animations:^{
        self.finishedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.finishedView removeFromSuperview];
        UIViewController *vc = [self viewController];
        [vc.navigationController popToRootViewControllerAnimated:YES];
    }];
}

@end
