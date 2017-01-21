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

@interface RepairCardView ()<UITextFieldDelegate>

@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) NSArray *choices;//邮寄选项
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) ChooseImageView *chooseImageView;

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
        self.isHJSJNumber = NO;
        self.choices = @[@"顺丰到付",@"充值一百免邮费"];
        self.leftTitles = @[@"补卡号码",@"补卡人姓名",@"证件号码",@"证件地址",@"联系电话",@"近期联系号码",@"邮寄地址",@"收件人姓名",@"收件人电话",@"邮寄选项"];
        
        for (int i = 0; i < self.leftTitles.count; i++) {
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            view.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
            view.textField.tag = 10+i;
            view.textField.delegate = self;
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

            if ([self.leftTitles[i] isEqualToString:@"联系电话"] || [self.leftTitles[i] isEqualToString:@"近期联系号码"] || [self.leftTitles[i] isEqualToString:@"收件人电话"] || [self.leftTitles[i] isEqualToString:@"补卡号码"]) {
                view.textField.keyboardType = UIKeyboardTypeNumberPad;
            }
            
            [self.inputViews addObject:view];
            [self addSubview:view];
        }
        
        [self chooseImageView];
        [self nextButton];
        
        UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, self.leftTitles.count*40)];
        backV.backgroundColor = [UIColor whiteColor];
        [self addSubview:backV];
        
    }
    return self;
}

- (ChooseImageView *)chooseImageView{
    if (_chooseImageView == nil) {
        _chooseImageView = [[ChooseImageView alloc] initWithFrame:CGRectZero andTitle:@"图片（点击图片可放大）" andDetail:@[@"手持身份证正面照"] andCount:1];
        [self addSubview:_chooseImageView];
        InputView *inputV = self.inputViews.lastObject;
        [_chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(inputV.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(185);
        }];
    }
    return _chooseImageView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"提交"];
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
    
    if (self.isHJSJNumber == YES) {
        
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
        
        for (InputView *iv in self.inputViews) {
            if ([Utils isRightString:iv.textField.text] == NO) {
                [Utils toastview:@"请输入数字、字母、中文或下划线！"];
                return;
            }
        }
        
        NSArray *keys = @[@"number",@"name",@"cardId",@"address",@"tel",@"numOne",@"mailingAddress",@"receiveName",@"receiveTel",@"mailMethod"];
        
        NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < keys.count; i ++) {
            NSString *keyString = keys[i];
            InputView *inputView = self.inputViews[i];
            if (![inputView.textField.text isEqualToString:@""]) {
                [sendDic setObject:inputView.textField.text forKey:keyString];
            }
        }
        
        //11-07 接口文档中只有一张图片
        UIImageView *imageView = self.chooseImageView.imageViews[0];
        NSString *imageString = [Utils imagechange:imageView.image];
        imageString = [imageString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [sendDic setObject:imageString forKey:@"photo"];
        
        _CardRepairCallBack(sendDic);
        
    }else{
        [Utils toastview:@"请输入话机号码！"];
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    __block __weak RepairCardView *weakself = self;
    if (textField.tag == 10) {
        [WebUtils requestSegmentWithTel:textField.text andCallBack:^(id obj) {
            if (obj) {
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.isHJSJNumber = YES;
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils toastview:@"请输入话机号码！"];
                    });
                }
            }
        }];
    }
}

@end
