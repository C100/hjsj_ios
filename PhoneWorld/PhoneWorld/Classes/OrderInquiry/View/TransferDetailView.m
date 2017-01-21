//
//  TransferDetailView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TransferDetailView.h"

#define imageWH 354/225.0

@interface TransferDetailView ()
@property (nonatomic) NSMutableArray *titles;
@property (nonatomic) NSMutableArray *contentLabelArray;

@property (nonatomic) UIImageView *imageViewNew1;
@property (nonatomic) UIImageView *imageViewNew2;//新

@property (nonatomic) UIImageView *imageViewOld1;
@property (nonatomic) UIImageView *imageViewOld2;

@property (nonatomic) UIView *allImagesView;
@property (nonatomic) NSMutableArray *allImagesArray;//点击查看大图的数组

@property (nonatomic) NSMutableArray *contents;

@end

@implementation TransferDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.titles = [@[@"    订单编号：",@"    订单时间：",@"    订单类型：",@"    订单状态：",@"    审核时间：",@"    审核结果：",@"    姓名：",@"    过户号码：",@"    证件号码：",@"    证件地址：",@"    联系电话："] mutableCopy];
        self.contents = [NSMutableArray array];
        self.contentLabelArray = [NSMutableArray array];
        self.allImagesArray = [NSMutableArray array];
        self.bounces = NO;
    }
    return self;
}


- (void)setDetailModel:(CardTransferDetailModel *)detailModel{
    _detailModel = detailModel;
    
    
    [self.contents addObject:self.listModel.order_id];
    NSString *timeString = [self.listModel.startTime componentsSeparatedByString:@" "].firstObject;

    [self.contents addObject:timeString];
    [self.contents addObject:@"过户"];
    [self.contents addObject:self.listModel.startName];
    if (!detailModel.updateDate) {
        [self.contents addObject:@"无"];
    }else{
        [self.contents addObject:self.detailModel.updateDate];
    }
    if (!detailModel.startName) {
        [self.contents addObject:@"无"];
    }else{
        [self.contents addObject:self.detailModel.startName];
    }
    [self.contents addObject:self.detailModel.name];
    [self.contents addObject:self.detailModel.number];
    [self.contents addObject:self.detailModel.cardId];
    [self.contents addObject:self.detailModel.address];
    [self.contents addObject:self.detailModel.tel];

    [self addInfo];

    
    
    //imageviewnew1
    MBProgressHUD *progressHUD1 = [[MBProgressHUD alloc] init];
    [self.allImagesView addSubview:progressHUD1];
    [progressHUD1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(self.imageViewNew1.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    [progressHUD1 showAnimated:YES];
    progressHUD1.removeFromSuperViewOnHide = YES;
    progressHUD1.mode = MBProgressHUDModeAnnularDeterminate;
    
    
    [self.imageViewNew1 sd_setImageWithURL:detailModel.photoOne placeholderImage:[UIImage imageNamed:@"identifyCard2"] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        float receive = receivedSize;
        float expect = expectedSize;
        progressHUD1.progress = (receive/expect);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [progressHUD1 removeFromSuperview];
    }];
    
    //imageviewnew2
    MBProgressHUD *progressHUD2 = [[MBProgressHUD alloc] init];
    [self.allImagesView addSubview:progressHUD2];
    [progressHUD2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(self.imageViewNew2.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    [progressHUD2 showAnimated:YES];
    progressHUD2.removeFromSuperViewOnHide = YES;
    progressHUD2.mode = MBProgressHUDModeAnnularDeterminate;
    
    [self.imageViewNew2 sd_setImageWithURL:detailModel.photoThree placeholderImage:[UIImage imageNamed:@"identifyCard1"] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        float receive = receivedSize;
        float expect = expectedSize;
        progressHUD2.progress = (receive/expect);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [progressHUD2 removeFromSuperview];
    }];
    
    //imageviewold1
    MBProgressHUD *progressHUD3 = [[MBProgressHUD alloc] init];
    [self.allImagesView addSubview:progressHUD3];
    [progressHUD3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(self.imageViewOld1.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    [progressHUD3 showAnimated:YES];
    progressHUD3.removeFromSuperViewOnHide = YES;
    progressHUD3.mode = MBProgressHUDModeAnnularDeterminate;
    
    
    [self.imageViewOld1 sd_setImageWithURL:detailModel.photoTwo placeholderImage:[UIImage imageNamed:@"identifyCard2"] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        float receive = receivedSize;
        float expect = expectedSize;
        progressHUD3.progress = (receive/expect);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [progressHUD3 removeFromSuperview];
    }];
    
    //imageviewold2
    MBProgressHUD *progressHUD4 = [[MBProgressHUD alloc] init];
    [self.allImagesView addSubview:progressHUD4];
    [progressHUD4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(self.imageViewOld2.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    [progressHUD4 showAnimated:YES];
    progressHUD4.removeFromSuperViewOnHide = YES;
    progressHUD4.mode = MBProgressHUDModeAnnularDeterminate;
    
    [self.imageViewOld2 sd_setImageWithURL:detailModel.photoFour placeholderImage:[UIImage imageNamed:@"identifyCard1"] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        float receive = receivedSize;
        float expect = expectedSize;
        progressHUD4.progress = (receive/expect);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [progressHUD4 removeFromSuperview];
    }];
    
    
}

- (void)addInfo{
    CGFloat y = 0;
    UILabel *lastLB = nil;
    for (int i = 0; i < self.titles.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%@%@",self.titles[i],self.contents[i]];
        CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont14] andMaxSize:CGSizeMake(screenWidth, 0) andStr:str];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, y, screenWidth, size.height+14)];
        [self addSubview:lb];
        
        lb.backgroundColor = [UIColor whiteColor];
        lb.numberOfLines = 0;
        lb.text = str;
        lb.font = [UIFont systemFontOfSize:textfont14];
        lb.textColor = [Utils colorRGB:@"#666666"];
        y = lb.origin.y + lb.size.height;
        lastLB = lb;
        [self.contentLabelArray addObject:lb];
    }
    
    UIView *v = [[UIView alloc] init];
    [self addSubview:v];
    v.backgroundColor = [UIColor whiteColor];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastLB.mas_bottom).mas_equalTo(10);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(screenWidth);
        make.bottom.mas_equalTo(-10);
    }];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = @"新用户";
    lb.textColor = [UIColor colorWithRed:254/255.0 green:34/255.0 blue:37/255.0 alpha:1];
    lb.font = [UIFont systemFontOfSize:textfont14];
    [v addSubview:lb];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    
    UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, screenWidth - 30, (screenWidth - 30)/(354/225.0))];
    imageV1.image = [UIImage imageNamed:@"identifyCard2"];
    [v addSubview:imageV1];
    imageV1.tag = 0;
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lb.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo((screenWidth - 30)/(354/225.0));
    }];
    [imageV1 addGestureRecognizer:tap1];
    imageV1.userInteractionEnabled = YES;
    
    self.imageViewNew1 = imageV1;
    
    UIImageView *imageV2 = [[UIImageView alloc] init];
    imageV2.image = [UIImage imageNamed:@"identifyCard1"];
    [v addSubview:imageV2];
    imageV2.tag = 1;
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV1.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo((screenWidth - 30)/(354/225.0));
    }];
    [imageV2 addGestureRecognizer:tap2];
    imageV2.userInteractionEnabled = YES;
    
    self.imageViewNew2 = imageV2;
    
    
    UILabel *lbOld = [[UILabel alloc] init];
    lbOld.textAlignment = NSTextAlignmentCenter;
    lbOld.text = @"老用户";
    lbOld.textColor = [Utils colorRGB:@"#0081eb"];
    lbOld.font = [UIFont systemFontOfSize:textfont14];
    [v addSubview:lbOld];
    [lbOld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV2.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    
    UIImageView *imageV11 = [[UIImageView alloc] init];
    imageV11.image = [UIImage imageNamed:@"identifyCard2"];
    [v addSubview:imageV11];
    imageV11.tag = 2;
    [imageV11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbOld.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo((screenWidth - 30)/(354/225.0));
    }];
    [imageV11 addGestureRecognizer:tap3];
    imageV11.userInteractionEnabled = YES;
    
    self.imageViewOld1 = imageV11;
    
    UIImageView *imageV22 = [[UIImageView alloc] init];
    imageV22.image = [UIImage imageNamed:@"identifyCard1"];
    [v addSubview:imageV22];
    imageV22.tag = 3;
    [imageV22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV11.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo((screenWidth - 30)/(354/225.0));
        make.bottom.mas_equalTo(v.mas_bottom).mas_equalTo(0);
    }];
    [imageV22 addGestureRecognizer:tap4];
    imageV22.userInteractionEnabled = YES;
    
    self.imageViewOld2 = imageV22;
    
    self.allImagesView = v;
    [self.allImagesArray addObject:self.imageViewNew1];
    [self.allImagesArray addObject:self.imageViewNew2];
    [self.allImagesArray addObject:self.imageViewOld1];
    [self.allImagesArray addObject:self.imageViewOld2];
}

#pragma mark - Method

- (void)imageTapAction:(UITapGestureRecognizer *)tap{
    
    UIImageView *tapedImageView = (UIImageView *)tap.view;
    
    [PhotoBroswerVC show:[UIApplication sharedApplication].keyWindow.rootViewController type:PhotoBroswerVCTypeZoom index:tapedImageView.tag photoModelBlock:^NSArray *{
        //创建多大容量数组
        NSMutableArray *modelsM = [NSMutableArray array];
        
        for (int i = 0; i < self.allImagesArray.count; i ++) {
            UIImageView *imageView = self.allImagesArray[i];
            if (imageView.image) {
                PhotoModel *pbModel=[[PhotoModel alloc] init];
                pbModel.mid = 10 + i;
                pbModel.image = imageView.image;//设置查看大图的时候的图片
                pbModel.sourceImageView = tapedImageView;//点击返回时图片做动画用
                [modelsM addObject:pbModel];
            }
        }
        
        return modelsM;
    }];
}

@end
