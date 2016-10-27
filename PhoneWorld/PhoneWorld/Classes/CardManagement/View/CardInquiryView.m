//
//  CardInquiryView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/20.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CardInquiryView.h"
#import "TopView.h"
#import "FilterView.h"
#import "OrderView.h"

@interface CardInquiryView ()

@property (nonatomic) TopView *topView;
@property (nonatomic) FilterView *selectView;
@property (nonatomic) UIView *grayView;
@property (nonatomic) OrderView *contentView;
@property (nonatomic) NSArray *arrTitles;
@property (nonatomic) UIView *yellowLineView;

@end

@implementation CardInquiryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        [self topView];
        [self contentView];
        [self selectView];
        self.arrTitles = @[@"起始时间：",@"截止时间：",@"订单状态：",@"手机号码："];
        [self yellowLineView];
        __block __weak CardInquiryView *weakself = self;
        [self.topView setCallback:^(NSInteger tag) {
            /*---按钮点击事件---*/
            NSInteger i = tag - 10;
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = weakself.yellowLineView.frame;
                frame.origin.x = i*screenWidth/4;
                weakself.yellowLineView.frame = frame;
            }];
        }];
        
        [self.topView setTopCallBack:^(id obj) {
            if (weakself.selectView.hidden == NO) {
                weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
            }else{
                weakself.topView.showButton.transform = CGAffineTransformIdentity;
            }
            weakself.selectView.hidden = weakself.selectView.hidden == YES ? NO:YES;
            weakself.grayView.hidden = weakself.grayView.hidden == YES ? NO:YES;
        }];
        
        [self grayView];
        [self.contentView setOrderViewCallBack:^(NSInteger section) {
            //什么都不做
        }];
        
        [self.selectView setFilterCallBack:^(NSArray *array,NSString *string) {
            for (int i = 0; i < array.count; i++) {
                UILabel *lb = weakself.topView.resultArr[i];
                if (array[i]) {
                    lb.text = [NSString stringWithFormat:@"%@%@",weakself.arrTitles[i],array[i]];
                    if (i == array.count - 1) {
                        if ([weakself.selectView.titles.lastObject isEqualToString:@"请选择"]) {
                            lb.text = [NSString stringWithFormat:@"充值类型：%@",array[i]];
                        }
                    }
                }
            }
            
            [weakself.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(130);
            }];
            weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
            
            if ([string isEqualToString:@"查询"]) {
                weakself.selectView.hidden = YES;
                weakself.grayView.hidden = YES;
            }
        }];
        
        [self.selectView setDismissPickerViewCallBack:^(id obj) {
            weakself.selectView.beginDatePicker.hidden = YES;
            weakself.selectView.pickView.hidden = YES;
            weakself.selectView.pickerView.hidden = YES;
            weakself.selectView.closeImagePickerButton.hidden = YES;
            weakself.selectView.cancelButton.hidden = YES;
        }];
        
    }
    return self;
}

- (UIView *)yellowLineView{
    if (_yellowLineView == nil) {
        _yellowLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, screenWidth/4, 1)];
        _yellowLineView.backgroundColor = MainColor;
        [self addSubview:_yellowLineView];
    }
    return _yellowLineView;
}

- (TopView *)topView{
    if (_topView == nil) {
        _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 130) andTitles:@[@"全部",@"待审核",@"通过",@"未通过"]];
        [self addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(80);
        }];
    }
    return _topView;
}

- (FilterView *)selectView{
    if (_selectView == nil) {
        /*-----筛选框new--------*/
        _selectView = [[FilterView alloc] initWithFrame:CGRectMake(0, 81, screenWidth, 240)];
        _selectView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_selectView];
        _selectView.hidden = YES;
        self.selectView.titles = @[@"起始时间",@"截止时间",@"订单类型",@"手机号码"];
        _selectView.orderStates = @[@"全部",@"补卡",@"过户"];
        [_selectView.filterTableView reloadData];
    }
    return _selectView;
}

- (UIView *)grayView{
    if (_grayView == nil) {
        _grayView = [[UIView alloc] init];
        [self addSubview:_grayView];
        _grayView.backgroundColor = [UIColor lightGrayColor];
        _grayView.alpha = 0.5;
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(self.selectView.mas_bottom).mas_equalTo(0);
        }];
        _grayView.hidden = YES;
        UITapGestureRecognizer *tapGrayGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_grayView addGestureRecognizer:tapGrayGR];
    }
    return _grayView;
}

- (OrderView *)contentView{
    if (_contentView == nil) {
        _contentView = [[OrderView alloc] init];
        _contentView.titles = @[@"姓名：",@"号码：",@"类型：",@"状态："];
        [_contentView.orderTableView reloadData];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _contentView;
}

#pragma mark - Method
- (void)tapAction{
    [self endEditing:YES];
    __block __weak CardInquiryView *weakself = self;
    
    //    [UIView animateWithDuration:0.3 animations:^{
    weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
    weakself.selectView.hidden = YES;
    weakself.grayView.hidden = YES;
    //    }];
}

@end
