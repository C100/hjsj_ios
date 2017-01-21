//
//  NormalOrderView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "NormalOrderDetailView.h"

#define imageWH 354/225.0

@interface NormalOrderDetailView ()

@property (nonatomic) NSArray *titles;
@property (nonatomic) NSArray *firstTitles;
@property (nonatomic) NSArray *secondTitles;
@property (nonatomic) NSArray *thirdTitles;
@property (nonatomic) NSMutableArray *firstContents;
@property (nonatomic) NSMutableArray *secondContents;
@property (nonatomic) NSMutableArray *thirdContents;

@property (nonatomic) NSMutableArray<UILabel *> *firstLabelArray;
@property (nonatomic) NSMutableArray<UILabel *> *secondLabelArray;
@property (nonatomic) NSMutableArray<UILabel *> *thirdLabelArray;

@property (nonatomic) UIImageView *imageView1;
@property (nonatomic) UIImageView *imageView2;

@property (nonatomic) UIView *allImagesView;//放图片的view

@end

@implementation NormalOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = @[@"订单信息",@"资费信息",@"客户信息"];
        self.firstTitles = @[@"    订单编号：",@"    订单时间：",@"    订单类型：",@"    订单状态：",@"    审核时间：",@"    审核结果：",@"    开户号码："];
        self.secondTitles = @[@"    预存金额：",@"    活动包：",@"    靓号规则："];
        self.thirdTitles = @[@"    姓名：",@"    身份证号码：",@"    身份证地址："];
        
        self.firstContents = [NSMutableArray array];
        self.secondContents = [NSMutableArray array];
        self.thirdContents = [NSMutableArray array];
        
        self.firstLabelArray = [NSMutableArray array];
        self.secondLabelArray = [NSMutableArray array];
        self.thirdLabelArray = [NSMutableArray array];
        
        self.titleButtons = [NSMutableArray array];
        self.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
        [self headView];
        [self moveView];
        [self contentView];

    }
    return self;
}

- (void)setDetailModel:(OrderDetailModel *)detailModel{
    _detailModel = detailModel;
    
    
    [self.firstContents addObject:detailModel.orderNo];
    NSString *dateString = [[NSString  stringWithFormat:@"%@",detailModel.createDate] componentsSeparatedByString:@" "].firstObject;
    [self.firstContents addObject:dateString];
    NSString *cardTypeString = @"成卡开户";
    if ([detailModel.cardType isEqualToString:@"ESIM"]) {
        cardTypeString = @"白卡开户";
    }
    [self.firstContents addObject:cardTypeString];
    NSString *orderStateString = @"无";
    if ([detailModel.orderStatus isEqualToString:@"PENDING"] || [detailModel.orderStatus isEqualToString:@"已提交"]) {
        orderStateString = @"已提交";
    }
    if ([detailModel.orderStatus isEqualToString:@"WAITING"] || [detailModel.orderStatus isEqualToString:@"等待中"]) {
        orderStateString = @"等待中";
    }
    if ([detailModel.orderStatus isEqualToString:@"SUCCESS"] || [detailModel.orderStatus isEqualToString:@"成功"]) {
        orderStateString = @"成功";
    }
    if ([detailModel.orderStatus isEqualToString:@"FAIL"] || [detailModel.orderStatus isEqualToString:@"失败"]) {
        orderStateString = @"失败";
    }
    if ([detailModel.orderStatus isEqualToString:@"CANCEL"] || [detailModel.orderStatus isEqualToString:@"已取消"]) {
        orderStateString = @"已取消";
    }

    [self.firstContents addObject:orderStateString];
    if (detailModel.updateDate) {
        NSString *dateString = [[NSString  stringWithFormat:@"%@",detailModel.updateDate] componentsSeparatedByString:@" "].firstObject;
        [self.firstContents addObject:dateString];
    }else{
        [self.firstContents addObject:@"无"];

    }
    if (!detailModel.startTime) {
        [self.firstContents addObject:@"无"];
    }else{
        [self.firstContents addObject:detailModel.startTime];
    }
    
    [self.firstContents addObject:detailModel.number];

    
    
    [self.secondContents addObject:detailModel.prestore];
    [self.secondContents addObject:detailModel.promotion];
    [self.secondContents addObject:detailModel.isLiang];

    
    
    [self.thirdContents addObject:detailModel.customerName];
    [self.thirdContents addObject:detailModel.certificatesNo];
    [self.thirdContents addObject:detailModel.address];

    
    
    [self firstView];
    [self secondView];
    [self thirdView];
    
    
    
    MBProgressHUD *progressHUD1 = [[MBProgressHUD alloc] init];
    [self.allImagesView addSubview:progressHUD1];
    [progressHUD1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(self.imageView1.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    [progressHUD1 showAnimated:YES];
    progressHUD1.removeFromSuperViewOnHide = YES;
    progressHUD1.mode = MBProgressHUDModeAnnularDeterminate;
    
    
    [self.imageView1 sd_setImageWithURL:detailModel.photoFront placeholderImage:[UIImage imageNamed:@"identifyCard2"] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        float receive = receivedSize;
        float expect = expectedSize;
        progressHUD1.progress = (receive/expect);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [progressHUD1 removeFromSuperview];
    }];
    
    MBProgressHUD *progressHUD2 = [[MBProgressHUD alloc] init];
    [self.allImagesView addSubview:progressHUD2];
    [progressHUD2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(self.imageView2.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    [progressHUD2 showAnimated:YES];
    progressHUD2.removeFromSuperViewOnHide = YES;
    progressHUD2.mode = MBProgressHUDModeAnnularDeterminate;
    
    [self.imageView2 sd_setImageWithURL:detailModel.photoBack placeholderImage:[UIImage imageNamed:@"identifyCard1"] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        float receive = receivedSize;
        float expect = expectedSize;
        progressHUD2.progress = (receive/expect);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [progressHUD2 removeFromSuperview];
    }];
}

- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        for (int i = 0; i < self.titles.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth/3.0)*i, 0, screenWidth/3.0, 40)];
            [button setTitle:self.titles[i] forState:UIControlStateNormal];
            [_headView addSubview:button];
            [button setTitleColor:[Utils colorRGB:@"#333333"] forState:UIControlStateNormal];
            [button setTitleColor:MainColor forState:UIControlStateSelected];
            button.tag = 1130+i;
            button.titleLabel.font = [UIFont systemFontOfSize:textfont14];
            [button addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                button.selected = YES;
            }
            [self.titleButtons addObject:button];
        }
    }
    return _headView;
}

- (UIView *)moveView{
    if (_moveView == nil) {
        _moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, screenWidth/3, 1)];
        [self addSubview:_moveView];
        _moveView.backgroundColor = MainColor;
    }
    return _moveView;
}

- (UIScrollView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.tag = 1500;
        _contentView.delegate = self;
        _contentView.contentSize = CGSizeMake(screenWidth*3, 0);
        _contentView.bounces = NO;
        _contentView.pagingEnabled = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.headView.mas_bottom).mas_equalTo(1);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _contentView;
}

- (UIView *)firstView{
    if (_firstView == nil) {
        CGFloat y = 0;

        _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 104)];
        [self.contentView addSubview:_firstView];
        _firstView.backgroundColor = COLOR_BACKGROUND;
        
        for (int i = 0; i < self.firstTitles.count; i++) {
            NSString *str = [NSString stringWithFormat:@"%@%@",self.firstTitles[i],self.firstContents[i]];
            CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont14] andMaxSize:CGSizeMake(screenWidth, 0) andStr:str];
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, y, screenWidth, size.height + 14)];
            lb.backgroundColor = [UIColor whiteColor];
            [_firstView addSubview:lb];
            lb.text = str;
            lb.font = [UIFont systemFontOfSize:textfont14];
            lb.textColor = [Utils colorRGB:@"#999999"];
            [self.firstLabelArray addObject:lb];
            y = lb.origin.y + lb.size.height;

        }
        
    }
    return _firstView;
}

- (UIView *)secondView{
    if (_secondView == nil) {
        CGFloat y = 0;
        _secondView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth, 0, screenWidth, screenHeight - 104)];
        [self.contentView addSubview:_secondView];
        _secondView.backgroundColor = COLOR_BACKGROUND;
        
        for (int i = 0; i < self.secondTitles.count; i++) {
            NSString *str = [NSString stringWithFormat:@"%@%@",self.secondTitles[i],self.secondContents[i]];
            CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont14] andMaxSize:CGSizeMake(screenWidth, 0) andStr:str];
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, y, screenWidth, size.height + 14)];
            lb.backgroundColor = [UIColor whiteColor];
            [_secondView addSubview:lb];
            lb.text = str;
            lb.font = [UIFont systemFontOfSize:textfont14];
            lb.textColor = [Utils colorRGB:@"#999999"];
            [self.secondLabelArray addObject:lb];
            y = lb.origin.y + lb.size.height;

        }
    }
    return _secondView;
}

- (UIScrollView *)thirdView{
    if (_thirdView == nil) {
        _thirdView = [[UIScrollView alloc] initWithFrame:CGRectMake(screenWidth*2, 0, screenWidth, screenHeight - 104)];
        [self.contentView addSubview:_thirdView];
        _thirdView.backgroundColor = COLOR_BACKGROUND;
        _thirdView.bounces = NO;
        
        CGFloat y = 0;
        
        UILabel *lastLb = nil;
        for (int i = 0; i < self.thirdTitles.count; i++) {
            NSString *str = [NSString stringWithFormat:@"%@%@",self.thirdTitles[i],self.thirdContents[i]];
            CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont14] andMaxSize:CGSizeMake(screenWidth, 0) andStr:str];
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, y, screenWidth, size.height+14)];
            lb.backgroundColor = [UIColor whiteColor];
            [_thirdView addSubview:lb];
            lb.text = str;
            lb.font = [UIFont systemFontOfSize:textfont14];
            lb.textColor = [Utils colorRGB:@"#999999"];
            lb.numberOfLines = 0;
            lastLb = lb;
            [self.thirdLabelArray addObject:lb];
            y = lb.origin.y + lb.size.height;

        }
        
        UIView *v = [[UIView alloc] init];
        [_thirdView addSubview:v];
        v.backgroundColor = [UIColor whiteColor];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastLb.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(screenWidth);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(30+2*(screenWidth - 30)/(354/225.0));
            make.bottom.mas_equalTo(-10);
        }];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];

        
        UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, screenWidth - 30, (screenWidth - 30)/(354/225.0))];
        imageV1.image = [UIImage imageNamed:@"identifyCard2"];
        [v addSubview:imageV1];
        [imageV1 addGestureRecognizer:tap1];
        imageV1.userInteractionEnabled = YES;
        self.imageView1 = imageV1;
        
        UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20+(screenWidth - 30)/(354/225.0), screenWidth - 30, (screenWidth - 30)/(354/225.0))];
        imageV2.image = [UIImage imageNamed:@"identifyCard1"];
        [v addSubview:imageV2];
        [imageV2 addGestureRecognizer:tap2];
        imageV2.userInteractionEnabled = YES;
        self.imageView2 = imageV2;
        
        self.allImagesView = v;
    }
    return _thirdView;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 1500) {
        CGRect frame = self.moveView.frame;
        frame.origin.x = scrollView.contentOffset.x/3.0;
        self.moveView.frame = frame;
        NSInteger i =  scrollView.contentOffset.x/screenWidth;
        for (UIButton *b in self.titleButtons) {
            b.selected = NO;
        }
        UIButton *button = [self viewWithTag:1130+i];
        button.selected = YES;
    }
}

#pragma mark - Method
- (void)buttonClickedAction:(UIButton *)button{
    //1130  1131  1132
    NSInteger i = button.tag - 1130;
    for (UIButton *b in self.titleButtons) {
        b.selected = NO;
    }
    button.selected = YES;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.moveView.frame;
        frame.origin.x = i*screenWidth/3.0;
        self.moveView.frame = frame;
        self.contentView.contentOffset = CGPointMake(screenWidth*i, 0);
    }];
}

- (void)imageTapAction:(UITapGestureRecognizer *)tap{
    UIImageView *imageV = (UIImageView *)tap.view;
    [PhotoBroswerVC show:[UIApplication sharedApplication].keyWindow.rootViewController type:PhotoBroswerVCTypeZoom index:0 photoModelBlock:^NSArray *{
        //创建多大容量数组
        NSMutableArray *modelsM = [NSMutableArray array];
        PhotoModel *pbModel=[[PhotoModel alloc] init];
        pbModel.mid = 11;
        //设置查看大图的时候的图片
        pbModel.image = imageV.image;
        pbModel.sourceImageView = imageV;//点击返回时图片做动画用
        [modelsM addObject:pbModel];
        return modelsM;
    }];
}

@end
