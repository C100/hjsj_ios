//
//  OrderView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneCashCheckView.h"
#import "PhoneCashCheckTVCell.h"
#import "InputView.h"

@interface PhoneCashCheckView ()
@property (nonatomic) InputView *inputView;
@end

@implementation PhoneCashCheckView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        [self inputView];
        [self findButton];
    }
    return self;
}

- (InputView *)inputView{
    if (_inputView == nil) {
        _inputView = [[InputView alloc] init];
        _inputView.leftLabel.text = @"手机号码";
        _inputView.textField.placeholder = @"请输入手机号码";
        [self addSubview:_inputView];
        [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(screenWidth);
        }];
    }
    return _inputView;
}

- (UITableView *)resultTableView{
    if (_resultTableView == nil) {
        _resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 300) style:UITableViewStylePlain];
        [self addSubview:_resultTableView];
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
        _resultTableView.bounces = NO;
        _resultTableView.userInteractionEnabled = NO;
        [_resultTableView registerClass:[PhoneCashCheckTVCell class] forCellReuseIdentifier:@"cell2"];
    }
    return _resultTableView;
}

- (UIButton *)findButton{
    if (_findButton == nil) {
        _findButton = [Utils returnBextButtonWithTitle:@"查询"];
        [self addSubview:_findButton];
        [_findButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.inputView.mas_bottom).mas_equalTo(40);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
        }];
        [_findButton addTarget:self action:@selector(findAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findButton;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.textLabel.text = self.userinfos.firstObject;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            [cell.textLabel setTextColor:[Utils colorRGB:@"#999999"]];
            return cell;
        }
            break;
        case 1:
        {
            PhoneCashCheckTVCell *cell = [[PhoneCashCheckTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.userinfos = [self.userinfos subarrayWithRange:NSMakeRange(1, 4)];
            return cell;
        }
        case 2:
        {
            PhoneCashCheckTVCell *cell = [[PhoneCashCheckTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell.userinfos = [self.userinfos subarrayWithRange:NSMakeRange(5, 4)];
            return cell;
        }
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 40;
            break;
            
        default:
            return 129;
            break;
    }
}

#pragma mark - Method
- (void)findAction:(UIButton *)button{
    [self endEditing:YES];
    if([Utils isMobile:self.inputView.textField.text]){
        _orderCallBack(self.inputView.textField.text);
    }else{
        [Utils toastview:@"手机号格式不正确，请重新输入"];
    }
}

@end
