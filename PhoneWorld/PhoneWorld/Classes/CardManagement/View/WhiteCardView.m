//
//  WhiteCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "WhiteCardView.h"
#import "WhiteCardCell.h"
#import "ReadCardAndChoosePackageViewController.h"

@interface WhiteCardView ()

@property (nonatomic) NSArray *phoneNumbers;
@property (nonatomic) NSArray *grayArrs;
@property (nonatomic) WhiteCardCell *currentCell;

@end

@implementation WhiteCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.contentSize = CGSizeMake(screenWidth, 474);
        self.grayArrs = @[@0,@3,@4,@7,@8,@11,@12,@15,@16,@19,@20];
        self.phoneNumbers = @[@"18754369021",@"13234543564",@"15732535555"];
        [self siftView];
        [self contentView];
        [self addButton];
    }
    return self;
}

- (UIView *)siftView{
    if (_siftView == nil) {
        _siftView = [[UIView alloc] init];
        [self addSubview:_siftView];
        [_siftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.width.mas_equalTo(screenWidth);
            make.height.mas_equalTo(64);
        }];
        _siftView.backgroundColor = [UIColor redColor];
    }
    return _siftView;
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
            make.top.mas_equalTo(self.siftView.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(screenHeight - 128 - 120);
        }];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        [_contentView registerClass:[WhiteCardCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _contentView;
}

- (void)addButton{
    NSArray *arr = @[@"换一批",@"下一步"];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10 + (10+(screenWidth-30)/2.0)*i, screenHeight - 140, (screenWidth-30)/2.0, 40)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:MainColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
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
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WhiteCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.phoneLB.text = self.phoneNumbers[indexPath.row%3];
    if ([self.grayArrs containsObject:@(indexPath.row)]) {
        cell.backgroundColor = [Utils colorRGB:@"#f3f4f5"];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(screenWidth/2, 40);
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
            ReadCardAndChoosePackageViewController *vc = [[ReadCardAndChoosePackageViewController alloc] init];
            vc.infos = @[self.currentCell.phoneLB.text,@"浙江省杭州市",@"已激活",@"话机通信",@""];
            UIViewController *viewController = [self viewController];
            [viewController.navigationController pushViewController:vc animated:YES];
        }else{
            [Utils toastview:@"请选择手机号"];
        }
    }else{
        //换一批
    }
}

@end
