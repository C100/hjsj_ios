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
@property (nonatomic) NSArray *titlesTwo;
@property (nonatomic) NSMutableDictionary *userinfosDic;

@end

@implementation ChoosePackageView

- (instancetype)initWithFrame:(CGRect)frame andUserinfos:(NSMutableDictionary *)userinfos
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.titles = @[@"号码：",@"号码归属地：",@"号码状态：",@"网络机制："];
        self.titlesTwo = @[@"套餐选择",@"活动包选择",@"预存金额"];
        self.userinfosDic = userinfos;
        [self addTopStateView];
        [self tableView];
        [self nextButton];
    }
    return self;
}

- (void)addTopStateView{
    UIView *v = [[UIView alloc] init];
    [self addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(130);
    }];
    v.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"phoneNumber",@"phoneAddress",@"phoneState",@"networkType"];
    for (int i = 0; i < self.userinfosDic.count; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10 + 30*i, screenWidth - 30, 16)];
        lb.text = [self.titles[i] stringByAppendingString:self.userinfosDic[arr[i]]];
        lb.font = [UIFont systemFontOfSize:14];
        lb.textColor = [Utils colorRGB:@"#333333"];
        NSRange range = [lb.text rangeOfString:self.titles[i]];
        lb.attributedText = [Utils setTextColor:lb.text FontNumber:[UIFont systemFontOfSize:14] AndRange:range AndColor:[Utils colorRGB:@"#999999"]];

        [v addSubview:lb];
    }
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[ChoosePackageTableView alloc] init];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(140);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(119);
        }];
    }
    return _tableView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [Utils returnBextButtonWithTitle:@"下一步"];
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
    /*---跳转到采集信息界面---*/
    if ([Utils isNumber:self.tableView.inputView.textField.text] && ![self.tableView.inputView.textField.text isEqualToString:@""]) {
        [self.userinfosDic addEntriesFromDictionary:@{@"prestoreMoney":self.tableView.inputView.textField.text}];
        
        UIViewController *viewController = [self viewController];
        InformationCollectionViewController *vc = [InformationCollectionViewController new];
        vc.userinfosDic = self.userinfosDic;
        [viewController.navigationController pushViewController:vc animated:YES];
    }else{
        [Utils toastview:@"请输入预存金额"];
    }
}

@end
