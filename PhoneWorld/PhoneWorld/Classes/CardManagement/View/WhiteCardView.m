//
//  WhiteCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "WhiteCardView.h"

@interface WhiteCardView ()

@property (nonatomic) NSArray *phoneNumbers;
@property (nonatomic) NSArray *grayArrs;
@property (nonatomic) UIView *grayView;
@property (nonatomic) NSArray *topViewTitles;

@end

@implementation WhiteCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.contentSize = CGSizeMake(screenWidth, 474);
        self.grayArrs = @[@0,@3,@4,@7,@8,@11,@12,@15,@16,@19,@20];
        self.topViewTitles = @[@"号码池：",@"靓号规则："];
        [self topView];
        [self contentView];
        [self selectView];
        [self addButton];
        [self grayView];
        
        __block __weak WhiteCardView *weakself = self;

        [self.topView setWhiteCardTopCallBack:^(id obj) {
            if (weakself.selectView.hidden == NO) {
                weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
                [UIView animateWithDuration:0.3 animations:^{
                    weakself.selectView.alpha = 0;
                    weakself.grayView.alpha = 0;
                } completion:^(BOOL finished) {
                    weakself.selectView.hidden = YES;
                    weakself.grayView.hidden = YES;
                }];
            }else{
                weakself.topView.showButton.transform = CGAffineTransformIdentity;
                weakself.selectView.hidden = NO;
                weakself.grayView.hidden = NO;
                weakself.selectView.alpha = 0;
                weakself.grayView.alpha = 0;
                [UIView animateWithDuration:0.3 animations:^{
                    weakself.selectView.alpha = 1;
                    weakself.grayView.alpha = 0.5;
                } completion:^(BOOL finished) {
                }];
            }
        }];
        
        //查询
        [self.selectView setWhiteCardFilterCallBack:^(NSArray *array,NSString *string) {
            
//            if ([string isEqualToString:@"查询"]) {
//                
//            }else{
//                
//            }
            
            
            for (NSString *str in array) {
                if ([str isEqualToString:@"无"]) {
                    [Utils toastview:@"筛选条件不完整"];
                    return ;
                }
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                weakself.selectView.alpha = 0;
                weakself.grayView.alpha = 0;
            } completion:^(BOOL finished) {
                weakself.selectView.hidden = YES;
                weakself.grayView.hidden = YES;
            }];
            
            //显示筛选条件到topView上
            for (int i = 0; i < weakself.topView.resultArr.count; i ++) {
                UILabel *lb = weakself.topView.resultArr[i];
                lb.text = [NSString stringWithFormat:@"%@%@",weakself.topViewTitles[i],array[i]];
                lb.font = [UIFont systemFontOfSize:14*screenWidth/414.0];
            }
            
            [weakself.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.width.mas_equalTo(screenWidth);
                make.height.mas_equalTo(80);
            }];
            
            [weakself.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.width.mas_equalTo(screenWidth);
                make.top.mas_equalTo(weakself.topView.mas_bottom).mas_equalTo(10);
                make.height.mas_equalTo(screenHeight - 128 - 100 - 40);
            }];
            
            weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);

            weakself.topView.resultView.hidden = NO;
            
            NSString *s1 = weakself.selectView.currentPoolId;
            NSString *s2 = weakself.selectView.currentType;
                        
            weakself.WhiteCardSelectCallBack(s1,s2);
        }];
    }
    return self;
}

- (WhiteCardTopView *)topView{
    if (_topView == nil) {
        _topView = [[WhiteCardTopView alloc] initWithFrame:CGRectZero];
        [self addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(1);
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(40);
        }];
    }
    return _topView;
}

- (WhiteCardFilterView *)selectView{
    if (_selectView == nil) {
        _selectView = [[WhiteCardFilterView alloc] init];
        [self addSubview:_selectView];
        [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_top).mas_equalTo(40);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(160);
            make.width.mas_equalTo(screenWidth);
        }];
        _selectView.hidden = YES;
    }
    return _selectView;
}

- (UICollectionView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _contentView.bounces = NO;
        _contentView.backgroundColor = COLOR_BACKGROUND;
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(screenHeight - 128 - 100);
        }];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        [_contentView registerClass:[WhiteCardCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _contentView;
}

- (UIView *)grayView{
    if (_grayView == nil) {
        _grayView = [[UIView alloc] init];
        [self addSubview:_grayView];
        _grayView.backgroundColor = [UIColor blackColor];
        _grayView.alpha = 0.4;
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.top.mas_equalTo(self.selectView.mas_bottom).mas_equalTo(0);
            make.height.mas_equalTo(screenHeight - 64 - 40 - 160);
        }];
        _grayView.hidden = YES;
        UITapGestureRecognizer *tapGrayGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGrayAction:)];
        [_grayView addGestureRecognizer:tapGrayGR];
    }
    return _grayView;
}


- (void)addButton{
    NSArray *arr = @[@"换一批",@"下一步"];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10 + (10+(screenWidth-30)/2.0)*i, screenHeight - 140, (screenWidth-30)/2.0, 40)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:textfont14];
        [button addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 20;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = MainColor.CGColor;
        button.layer.borderWidth = 1;
        [self addSubview:button];
    }
}

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.randomPhoneNumbers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WhitePhoneModel *pModel = self.randomPhoneNumbers[indexPath.row];
    WhiteCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.whitePhoneModel = pModel;
    if ([self.grayArrs containsObject:@(indexPath.row)]) {
        cell.backgroundColor = [Utils colorRGB:@"#f3f4f5"];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(screenWidth/2, 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i < 20; i ++) {
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
        WhiteCardCell *cell = (WhiteCardCell *)[collectionView cellForItemAtIndexPath:indexP];
        cell.leftButton.layer.borderWidth = 1;
        cell.leftButton.layer.borderColor = [Utils colorRGB:@"#cccccc"].CGColor;
    }
    
    WhiteCardCell *cell = (WhiteCardCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.leftButton.layer.borderWidth = 3;
    cell.leftButton.layer.borderColor = [Utils colorRGB:@"#0081eb"].CGColor;
    self.currentCell = cell;
}

#pragma mark - Method
- (void)nextAction:(UIButton *)button{
    if ([button.currentTitle isEqualToString:@"下一步"]) {
        
        if (self.currentCell) {
            _NextCallBack(button);
        }else{
            [Utils toastview:@"请选择手机号"];
        }
    }else{
        //换一批
        _ChangeCallBack(button);
    }
}

- (void)tapGrayAction:(UITapGestureRecognizer *)tap{
    __block __weak WhiteCardView *weakself = self;
    if (weakself.selectView.hidden == NO) {
        weakself.topView.showButton.transform = CGAffineTransformMakeRotation(M_PI_2*2);
        [UIView animateWithDuration:0.3 animations:^{
            weakself.selectView.alpha = 0;
            weakself.grayView.alpha = 0;
        } completion:^(BOOL finished) {
            weakself.selectView.hidden = YES;
            weakself.grayView.hidden = YES;
        }];
    }else{
        weakself.topView.showButton.transform = CGAffineTransformIdentity;
        weakself.selectView.hidden = NO;
        weakself.grayView.hidden = NO;
        weakself.selectView.alpha = 0;
        weakself.grayView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            weakself.selectView.alpha = 1;
            weakself.grayView.alpha = 0.5;
        } completion:^(BOOL finished) {
        }];
    }
}

@end
