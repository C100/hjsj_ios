//
//  RepairCardDetailView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RepairCardDetailView.h"

#define imageWH 354/225.0

@interface RepairCardDetailView ()

@property (nonatomic) NSArray *titles;
@property (nonatomic) NSMutableArray *contents;
@property (nonatomic) NSMutableArray *contentLabelArray;
@property (nonatomic) UIImageView *imageView1;

@property (nonatomic) UIView *allImagesView;

@end

@implementation RepairCardDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.titles = @[@"    订单编号：",@"    订单时间：",@"    订单类型：",@"    订单状态：",@"    审核时间：",@"    审核结果：",@"    补卡人姓名：",@"    补卡号码：",@"    证件号码：",@"    证件地址：",@"    联系电话：",@"    近期联系号码：",@"    收件人姓名：",@"    收件人号码：",@"    收件人地址：",@"    邮寄选项：",@"    状态："];
        self.contents = [NSMutableArray array];
        self.contentLabelArray = [NSMutableArray array];
        self.bounces = NO;
    }
    return self;
}


- (void)setDetailModel:(CardRepairDetailModel *)detailModel{
    _detailModel = detailModel;
    
    [self.contents addObject:self.listModel.order_id];
    NSString *dateString = [self.listModel.startTime componentsSeparatedByString:@" "].firstObject;
    [self.contents addObject:dateString];
    [self.contents addObject:detailModel.cardId];
    [self.contents addObject:@"补卡"];
    if (!detailModel.updateDate) {
        [self.contents addObject:@"无"];
    }else{
        NSString *dateString = [[NSString stringWithFormat:@"%@",detailModel.updateDate] componentsSeparatedByString:@" "].firstObject;
        [self.contents addObject:dateString];
    }
    if (!detailModel.startName) {
        [self.contents addObject:@"无"];
    }else{
        [self.contents addObject:detailModel.startName];
    }
    [self.contents addObject:detailModel.name];
    [self.contents addObject:detailModel.number];
    [self.contents addObject:detailModel.cardId];
    [self.contents addObject:detailModel.address];
    [self.contents addObject:detailModel.tel];
    NSString *number = @"无";
    if (detailModel.numOne) {
        number = detailModel.numOne;
    }
    NSString *numString = [NSString stringWithFormat:@"%@",number];
    [self.contents addObject:numString];
    [self.contents addObject:detailModel.receiveName];
    [self.contents addObject:detailModel.receiveTel];
    [self.contents addObject:detailModel.mailingAddress];
    [self.contents addObject:detailModel.mailMethod];
    [self.contents addObject:self.listModel.startName];
    
    
    [self addInfo];

    
    //imageviewnew1
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
    
    
    [self.imageView1 sd_setImageWithURL:detailModel.photo placeholderImage:[UIImage imageNamed:@"identifyCard2"] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        float receive = receivedSize;
        float expect = expectedSize;
        progressHUD1.progress = (receive/expect);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [progressHUD1 removeFromSuperview];
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
        lb.text = str;
        lb.numberOfLines = 0;
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
        make.bottom.mas_equalTo(0);
    }];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    
    UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, screenWidth - 30, (screenWidth - 30)/(354/225.0))];
    imageV1.image = [UIImage imageNamed:@"identifyCard2"];
    [v addSubview:imageV1];
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo((screenWidth - 30)/(354/225.0));
        make.bottom.mas_equalTo(-10);
    }];
    [imageV1 addGestureRecognizer:tap1];
    imageV1.userInteractionEnabled = YES;
    self.imageView1 = imageV1;
    
    self.allImagesView = v;
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
