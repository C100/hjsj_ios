//
//  TopCallMoneyView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TopCallMoneyView.h"
#import "TopResultViewController.h"

#import "FailedView.h"
#import "CreatePayPasswordViewController.h"

#define btnWidth (screenWidth - 46)/3.0
#define hw 70/113.0
#define btnTopDistance (btnWidth*hw - 16 - 4 - 13)/2.0

@interface TopCallMoneyView ()

@property (nonatomic) NSMutableArray *buttonArr;//优惠按钮数组
@property (nonatomic) CGFloat money;//金额
@property (nonatomic) NSMutableArray *inputViews;//账户余额＋手机号码
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) InputView *topMoney;//其他充值金额

@property (nonatomic) FailedView *processView;//支付过程提示框

@property (nonatomic) NSDictionary *currentDic;//当前选中的优惠组合

@property (nonatomic) BOOL getDiscount;
@property (nonatomic) BOOL isOtherMoney;

@end

@implementation TopCallMoneyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonArr = [NSMutableArray array];
        self.backgroundColor = COLOR_BACKGROUND;
        self.inputViews = [NSMutableArray array];
        self.getDiscount = NO;
        self.isOtherMoney = NO;
        self.leftTitles = @[@"账户余额",@"手机号码"];
        for (int i = 0; i < 2; i ++) {
            InputView *inputV = [[InputView alloc] initWithFrame:CGRectMake(0, 50*i, screenWidth, 40)];
            [self addSubview:inputV];
            inputV.leftLabel.text = self.leftTitles[i];
            if (i == 0) {
                inputV.textField.text = @"0元";
                inputV.textField.userInteractionEnabled = NO;
                self.accountMoneyIV = inputV;
            }else{
                inputV.textField.placeholder = @"请输入手机号码";
            }
            [self.inputViews addObject:inputV];
        }
        [self topMoney];
        [self nextButton];
        
        
        
        
    }
    return self;
}

- (void)setDiscountArray:(NSArray *)discountArray{
    _discountArray = discountArray;
    [self topMoneyNumber];
    
    [self.topMoney mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.topMoneyNumber.mas_bottom).mas_equalTo(1);
    }];
    
    [self.nextButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(171);
        make.top.mas_equalTo(self.topMoney.mas_bottom).mas_equalTo(40);
    }];
}

- (UIView *)topMoneyNumber{
    if (_topMoneyNumber == nil) {
        _topMoneyNumber = [[UIView alloc] init];
        _topMoneyNumber.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topMoneyNumber];
        InputView *inputV = self.inputViews.lastObject;
        
        NSInteger line = self.discountArray.count/3;
        if (self.discountArray.count % 3 != 0 && self.discountArray.count != 0) {
            line ++;
        }
        
        [_topMoneyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(inputV.mas_bottom).mas_equalTo(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(btnWidth*hw*line + 58);
        }];
        
        UILabel *lb = [[UILabel alloc] init];
        [_topMoneyNumber addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(16);
        }];
        lb.text = @"选择充值金额";
        lb.textColor = [UIColor blackColor];
        lb.font = [UIFont systemFontOfSize:textfont16];
        
        for (int i = 0; i < self.discountArray.count; i++) {
            NSDictionary *discountDictionary = self.discountArray[i];
            NSInteger line = i/3;
            NSInteger queue = i%3;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15 + (btnWidth + 8)*queue, 40 + (btnWidth*hw + 8)*line, btnWidth, btnWidth*hw)];
            [_topMoneyNumber addSubview:btn];
            btn.tag = 600+i;
            btn.layer.cornerRadius = 6;
            btn.layer.borderColor = [Utils colorRGB:@"#008bd5"].CGColor;
            btn.layer.borderWidth = 1;
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArr addObject:btn];
            
            UILabel *titleLB = [[UILabel alloc] init];
            [btn addSubview:titleLB];
            titleLB.textColor = [Utils colorRGB:@"#008bd5"];
            titleLB.font = [UIFont systemFontOfSize:textfont14];
            titleLB.text = [NSString stringWithFormat:@"%@元",discountDictionary[@"actualAmount"]];
            [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(btn.mas_top).mas_equalTo(btnTopDistance);
                make.centerX.mas_equalTo(0);
            }];
            
            UILabel *detailLB = [[UILabel alloc] init];
            [btn addSubview:detailLB];
            detailLB.textColor = [Utils colorRGB:@"#008bd5"];
            detailLB.font = [UIFont systemFontOfSize:textfont11];
            detailLB.text = [NSString stringWithFormat:@"售价：%@元",discountDictionary[@"discountAmount"]];;
            [detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(titleLB.mas_bottom).mas_equalTo(4);
                make.centerX.mas_equalTo(0);
            }];
        }
    }
    return _topMoneyNumber;
}

- (InputView *)topMoney{
    if (_topMoney == nil) {
        _topMoney = [[InputView alloc] init];
        [self addSubview:_topMoney];
        
        InputView *inputV = self.inputViews.lastObject;
        
        [_topMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(inputV.mas_bottom).mas_equalTo(10);
        }];
        _topMoney.leftLabel.text = @"其它充值金额";
        _topMoney.textField.placeholder = @"请输入金额";
        _topMoney.textField.delegate = self;
        _topMoney.clearsContextBeforeDrawing = YES;
    }
    return _topMoney;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"确认"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topMoney.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        _nextButton.tag = 650;
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - UITextField Delegate


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    for (UIButton *btn in self.buttonArr) {
        btn.backgroundColor = [UIColor clearColor];
        for (UILabel *lb in btn.subviews) {
            [lb setTextColor:[Utils colorRGB:@"#008bd5"]];
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textColor = [Utils colorRGB:@"#666666"];
    textField.text = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    __block __weak TopCallMoneyView *weakself = self;

    if (![textField.text isEqualToString:@""]) {
        
        if([Utils isNumber:self.topMoney.textField.text] == NO){
            [Utils toastview:@"请输入整数"];
            return;
        }
        if (self.topMoney.textField.text.floatValue == 0.00) {
            [Utils toastview:@"请输入充值金额"];
            return;
        }
        
        if([Utils isNumber:self.topMoney.textField.text] == YES && self.topMoney.textField.text.floatValue != 0.00){
            [WebUtils requestOtherRechargeDiscountWithMoney:textField.text andCallBack:^(id obj) {
                if (obj) {
                    NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                    if ([code isEqualToString:@"10000"]) {
                        //保存
                        weakself.currentDic = obj[@"data"];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSString *discountString = [NSString stringWithFormat:@"%@",weakself.currentDic[@"discountAmount"]];
                            NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@ ￥%@",discountString,textField.text]];
                            //添加中划线
                            [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(discountString.length + 2, textField.text.length+1)];
                            //添加中划线颜色
                            [newPrice addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(discountString.length + 2, textField.text.length+1)];
                            //添加优惠金额颜色
                            [newPrice addAttribute:NSForegroundColorAttributeName value:[Utils colorRGB:@"#0081eb"] range:NSMakeRange(0, discountString.length+1)];
                            weakself.topMoney.textField.attributedText = newPrice;
                        });
                    }
                }
            }];
        }
    }
}

#pragma mark - Method

- (void)buttonClickAction:(UIButton *)button{
    if (button.tag != 650) {
        self.topMoney.textField.text = @"";
        for (UIButton *btn in self.buttonArr) {
            btn.backgroundColor = [UIColor clearColor];
            for (UILabel *lb in btn.subviews) {
                [lb setTextColor:[Utils colorRGB:@"#008bd5"]];
            }
        }
        
        for (UILabel *lb in button.subviews) {
            [lb setTextColor:[UIColor whiteColor]];
        }
        button.backgroundColor = [Utils colorRGB:@"#008bd5"];
        
        self.currentDic = self.discountArray[button.tag - 600];
        self.money = [self.discountArray[button.tag - 600][@"actualAmount"] floatValue];
    }else{
        [self endEditing:YES];

        if (![self.topMoney.textField.text isEqualToString:@""]) {
            if([Utils isNumber:self.topMoney.textField.text] == YES && self.topMoney.textField.text.floatValue != 0.00){
                [WebUtils requestOtherRechargeDiscountWithMoney:self.topMoney.textField.text andCallBack:^(id obj) {
                    if (obj) {
                        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                        if ([code isEqualToString:@"10000"]) {
                            self.currentDic = obj[@"data"];
                        }
                    }
                }];
            }
        }
        
        InputView *phoneView = self.inputViews.lastObject;
        
        if (![Utils isMobile:phoneView.textField.text]) {
            [Utils toastview:@"请输入正确格式手机号"];
        }else{
            if (!self.currentDic && [self.topMoney.textField.text isEqualToString:@""]) {
                [Utils toastview:@"请选择充值金额"];
            }else{
                //不准输入小数和0
//                if (![self.topMoney.textField.text isEqualToString:@""]) {
//                    if([Utils isNumber:self.topMoney.textField.text] == NO){
//                        [Utils toastview:@"请输入整数"];
//                        return;
//                    }
//                    self.money = self.topMoney.textField.text.floatValue;
//                    
//                    if (self.money == 0.00) {
//                        [Utils toastview:@"请输入充值金额"];
//                        return;
//                    }
//                }
                
                //判断账户余额和充值金额大小
                CGFloat leftMoney = [self.accountMoneyIV.textField.text floatValue];
                CGFloat topMoney = [self.currentDic[@"discountAmount"] floatValue];
                if (topMoney > leftMoney) {
                    [Utils toastview:@"余额不足"];
                    return;
                }
                
//                __block __weak TopCallMoneyView *weakself = self;
                
                /*
                 判断用户是否有支付密码，如果没有支付密码则跳转到创建用户支付密码
                 */
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                BOOL hasPayPass = [ud boolForKey:@"hasPayPassword"];
                if (hasPayPass != YES || !hasPayPass) {
                    [WebUtils requestHasPayPasswordWithCallBack:^(id obj) {
                        if (obj) {
                            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                            if ([code isEqualToString:@"10000"]) {
                                //如果有支付密码
                                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                                [ud setBool:YES forKey:@"hasPayPassword"];
                                [ud synchronize];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self payAction];
                                });
                            }else{
                                //如果没有支付密码
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"该用户未创建支付密码" preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"创建密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                        CreatePayPasswordViewController *vc = [[CreatePayPasswordViewController alloc] init];
                                        vc.type = 1;
                                        [[self viewController].navigationController pushViewController:vc animated:YES];
                                    }];
                                    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                    }];
                                    [ac addAction:action1];
                                    [ac addAction:action2];
                                    [[self viewController] presentViewController:ac animated:YES completion:nil];
                                });
                            }
                        }
                    }];
                }else{
                    [self payAction];
                }
                
            }
        }
    }
}

- (void)payAction{
    __block __weak TopCallMoneyView *weakself = self;

    /*---------支付操作----------*/
    self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.grayView.backgroundColor = [UIColor blackColor];
    self.grayView.alpha = 0;
    [self addSubview:self.grayView];
    self.payView = [[PayView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, 500)];
    [self addSubview:self.payView];
    
    
    [self.payView.textField becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.payView.frame;
        frame.origin.y = screenHeight - 500;
        self.payView.frame = frame;
        weakself.grayView.alpha = 0.4;
    }];
    
    
    [self.payView setPayCallBack:^(NSString *password) {
        /*
         输入完毕，支付操作
         */
        weakself.processView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"正在支付" andDetail:@"请稍候..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
        [[UIApplication sharedApplication].keyWindow addSubview:weakself.processView];
        [weakself endEditing:YES];
        
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            [Utils toastview:@"网络不好"];
            [weakself.processView removeFromSuperview];
        }
        
        CGFloat topMoney = [weakself.currentDic[@"discountAmount"] floatValue];
        
        NSString *moneyString = [NSString stringWithFormat:@"%f",topMoney];
        
        InputView *phoneView = weakself.inputViews.lastObject;
        
        [WebUtils requestTopInfoWithNumber:phoneView.textField.text andMoney:moneyString andPayPassword:password andCallBack:^(id obj) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.processView removeFromSuperview];
            });
            if (obj) {
                
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    //支付成功
                    NSString *numbers = [NSString stringWithFormat:@"%@",obj[@"data"][@"numbers"]];
                    weakself.topCallMoneyCallBack(topMoney, phoneView.textField.text,numbers, @"支付成功");
                    
                }else{
                    if (![code isEqualToString:@"39999"]) {
                        //支付有问题
                        NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                        
                        weakself.topCallMoneyCallBack(topMoney, phoneView.textField.text, @"无", mes);
                    }
                }
            }
            
        }];
    }];
    
    [self.payView setClosePayCallBack:^(id obj) {
        [weakself endEditing:YES];
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = weakself.payView.frame;
            frame.origin.y = screenHeight;
            weakself.payView.frame = frame;
            weakself.grayView.alpha = 0;
        } completion:^(BOOL finished) {
            [weakself.grayView removeFromSuperview];
        }];
    }];
    

    
    
    /*----------支付操作---------*/
}

@end
