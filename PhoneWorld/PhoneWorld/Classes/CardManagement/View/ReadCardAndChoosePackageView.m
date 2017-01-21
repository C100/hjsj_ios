//
//  ReadCardAndChoosePackageView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ReadCardAndChoosePackageView.h"
#import "InformationCollectionViewController.h"

@interface ReadCardAndChoosePackageView ()

@end

@implementation ReadCardAndChoosePackageView

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSArray *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.leftTitles = @[@"号码：",@"ICCID："];
        self.infos = [info mutableCopy];
        [self infoView];
        [self nextButton];
    }
    return self;
}

- (UIView *)infoView{
    if (_infoView == nil) {
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 75)];
        _infoView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_infoView];
//        [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.mas_equalTo(0);
//            make.width.mas_equalTo(screenWidth);
//            make.height.mas_equalTo(self.leftTitles.count * 30 + 15);
//        }];
        
        for (int i = 0; i < 2; i ++) {
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10 + 30 * i, screenWidth - 30, 16)];
            [_infoView addSubview:lb];
            if (i == 1) {
                lb.text = @"ICCID：无";
            }else{
                lb.text = [self.leftTitles[i] stringByAppendingString:self.infos[i]];
            }
            lb.font = [UIFont systemFontOfSize:textfont14];
            lb.textColor = [Utils colorRGB:@"#333333"];
            NSRange range = [lb.text rangeOfString:self.leftTitles[i]];
            lb.attributedText = [Utils setTextColor:lb.text FontNumber:[UIFont systemFontOfSize:textfont14] AndRange:range AndColor:[Utils colorRGB:@"#999999"]];
            if (i == 1) {
                self.iccidStringLabel = lb;
            }
        }
    }
    return _infoView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"写卡"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.infoView.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - Method

- (void)buttonClickAction:(UIButton *)button{
    if ([button.currentTitle isEqualToString:@"写卡"]) {
        
        _BlueToothCallBack(button);
        
    }else{
        //下一步
        
        UIViewController *viewController = [self viewController];
        InformationCollectionViewController *vc = [InformationCollectionViewController new];
        vc.imsiModel = self.chooseTableView.imsiModel;
        vc.currentPackageDictionary = self.chooseTableView.currentDic;
        vc.currentPromotionDictionary = self.chooseTableView.currentPromotionDic;
        vc.isFinished = NO;
        
//        self.infos = [@[self.whiteCardPhoneNumber] mutableCopy];//用输入框中的代替
        
        vc.infosArray = self.infos;//白卡号码选择得到的信息数组
        vc.iccidString = self.iccidString;
        vc.moneyString = self.chooseTableView.inputView.textField.text;
        [viewController.navigationController pushViewController:vc animated:YES];

    }
}

@end
