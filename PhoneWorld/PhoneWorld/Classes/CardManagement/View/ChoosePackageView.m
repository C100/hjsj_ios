//
//  ChoosePackageView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChoosePackageView.h"
#import "InformationCollectionViewController.h"
#import "InputView.h"

@interface ChoosePackageView ()

@property (nonatomic) NSArray *titles;

@property (nonatomic) NSMutableArray *topLabelsArr;
@property (nonatomic) NSArray *topLabelsKeysArr;

@property (nonatomic) UIView *phoneNumberView;

@end

@implementation ChoosePackageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.topLabelsArr = [NSMutableArray array];
//        self.topLabelsKeysArr = @[@"number",@"cityName",@"numberStatus",@"operatorName"];
        self.topLabelsKeysArr = @[@"number"];

//        self.titles = @[@"号码：",@"号码归属地：",@"号码状态：",@"网络机制："];
        self.titles = @[@"号码："];

        [self addTopStateView];
        [self tableView];
        [self nextButton];
    }
    return self;
}

- (void)setDetailModel:(PhoneDetailModel *)detailModel{
    _detailModel = detailModel;
    self.tableView.packagesDic = detailModel.packages;

    self.tableView.detailModel = detailModel;
    for (int i = 0; i < self.titles.count; i ++) {
        NSString *str = [self.detailModel valueForKey:self.topLabelsKeysArr[i]];
        UILabel *lb = self.topLabelsArr[i];
        lb.text = [self.titles[i] stringByAppendingString:str];
        NSRange range = [lb.text rangeOfString:self.titles[i]];
        lb.attributedText = [Utils setTextColor:lb.text FontNumber:[UIFont systemFontOfSize:textfont16] AndRange:range AndColor:[Utils colorRGB:@"#999999"]];
    }
    
}

- (void)addTopStateView{
    UIView *v = [[UIView alloc] init];
    [self addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    v.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10 + 30*i, screenWidth - 30, 16)];
        lb.text = [self.titles[i] stringByAppendingString:@"无"];
        lb.font = [UIFont systemFontOfSize:textfont14];
        lb.textColor = [Utils colorRGB:@"#333333"];
        NSRange range = [lb.text rangeOfString:self.titles[i]];
        lb.attributedText = [Utils setTextColor:lb.text FontNumber:[UIFont systemFontOfSize:textfont14] AndRange:range AndColor:[Utils colorRGB:@"#999999"]];
        [v addSubview:lb];
        [self.topLabelsArr addObject:lb];
    }
    self.phoneNumberView = v;
}

- (ChoosePackageTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[ChoosePackageTableView alloc] init];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.phoneNumberView.mas_bottom).mas_equalTo(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(119);
        }];
        
//        _tableView.inputView.textField.text = self.detailModel.prestore;
//        _tableView.inputView.textField.userInteractionEnabled = NO;
    }
    return _tableView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnNextButtonWithTitle:@"下一步"];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tableView.mas_bottom).mas_equalTo(40);
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
    
    if (!self.tableView.currentDic) {
        [Utils toastview:@"请选择套餐"];
        return;
    }
    
    if (!self.tableView.currentPromotionDic) {
        [Utils toastview:@"请选择活动包"];
        return;
    }
    
    /*---跳转到采集信息界面---*/
    if ([Utils isNumber:self.tableView.inputView.textField.text] && ![self.tableView.inputView.textField.text isEqualToString:@""]) {
        
        UIViewController *viewController = [self viewController];
        InformationCollectionViewController *vc = [InformationCollectionViewController new];
        vc.isFinished = YES;
        vc.detailModel = self.detailModel;
        vc.currentPackageDictionary = self.tableView.currentDic;
        vc.currentPromotionDictionary = self.tableView.currentPromotionDic;
        vc.moneyString = self.tableView.inputView.textField.text;
        [viewController.navigationController pushViewController:vc animated:YES];
        
    }else{
        [Utils toastview:@"请输入预存金额"];
    }
}

@end
