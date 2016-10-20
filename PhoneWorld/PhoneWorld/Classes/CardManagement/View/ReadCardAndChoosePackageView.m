//
//  ReadCardAndChoosePackageView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ReadCardAndChoosePackageView.h"
#import "ChoosePackageTableView.h"
#import "FailedView.h"

@interface ReadCardAndChoosePackageView ()

@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSArray *infos;

@property (nonatomic) ChoosePackageTableView *chooseTableView;
@property (nonatomic) FailedView *failedView;

@end

@implementation ReadCardAndChoosePackageView

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSArray *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.leftTitles = @[@"号码：",@"号码归属地：",@"号码状态：",@"网络制式：",@"ICCID："];
        self.infos = info;
        [self infoView];
        [self nextButton];
    }
    return self;
}

- (UIView *)infoView{
    if (_infoView == nil) {
        _infoView = [[UIView alloc] init];
        _infoView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_infoView];
        [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(160);
        }];
        
        for (int i = 0; i < 5; i ++) {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10 + 30 * i, screenWidth - 30, 16)];
            [_infoView addSubview:lb];
            lb.text = [self.leftTitles[i] stringByAppendingString:self.infos[i]];
            lb.font = [UIFont systemFontOfSize:14];
            lb.textColor = [Utils colorRGB:@"#333333"];
            NSRange range = [lb.text rangeOfString:self.leftTitles[i]];
            lb.attributedText = [Utils setTextColor:lb.text FontNumber:[UIFont systemFontOfSize:14] AndRange:range AndColor:[Utils colorRGB:@"#999999"]];
        }
        
    }
    return _infoView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(200);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton setTitle:@"读卡" forState:UIControlStateNormal];
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

- (UITextField *)moneyTF{
    if (_moneyTF == nil) {
        _moneyTF = [[UITextField alloc] init];
        [self addSubview:_moneyTF];
        [_moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.left.mas_equalTo(90);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(255);
        }];
        _moneyTF.borderStyle = UITextBorderStyleRoundedRect;
        _moneyTF.textColor = [Utils colorRGB:@"#666666"];
        _moneyTF.font = [UIFont systemFontOfSize:12];
        _moneyTF.returnKeyType = UIReturnKeyDone;
        _moneyTF.delegate = self;
        [_moneyTF addTarget:self action:@selector(textFieldStateChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _moneyTF;
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([Utils isNumber:self.moneyTF.text]) {
        self.moneyTF.hidden = YES;
        [self endEditing:YES];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        UITableViewCell *cell = [self.chooseTableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = self.moneyTF.text;
        cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
    }else{
        [Utils toastview:@"请输入数字"];
    }
    return YES;
}

#pragma mark - Method

- (void)buttonClickAction:(UIButton *)button{
    if ([button.currentTitle isEqualToString:@"读卡"]) {
        //读卡操作
        
        //读卡成功
        if (_chooseTableView == nil) {
            self.chooseTableView = [[ChoosePackageTableView alloc] initWithFrame:CGRectMake(0, 170, screenWidth, 119) style:UITableViewStylePlain];
            [self addSubview:self.chooseTableView];
        }
        __block __weak ReadCardAndChoosePackageView *weakself = self;
        [self.chooseTableView setChoosePackageCallBack:^(NSInteger row) {
            if (row == 2) {
                [weakself moneyTF];
            }
        }];
        [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [self.nextButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(330);
        }];
        //读卡失败
        self.failedView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"读卡失败" andDetail:@"SIM卡状态不正确" andImageName:@"icon_cry"];
        [[UIApplication sharedApplication].keyWindow addSubview:self.failedView];
        
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(removeGrayView) userInfo:nil repeats:NO];
        
    }else{
        //下一步
        
    }
}

- (void)textFieldStateChanged:(UITextField *)textField{
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:2 inSection:0];
    UITableViewCell *cell = [self.chooseTableView cellForRowAtIndexPath:indexP];
    cell.detailTextLabel.text = textField.text;
}

- (void)removeGrayView{
    [UIView animateWithDuration:1.0 animations:^{
        self.failedView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.failedView removeFromSuperview];
    }];
}

@end
