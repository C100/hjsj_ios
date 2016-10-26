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

@end

@implementation RepairCardDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.titles = @[@"    订单编号：",@"    订单时间：",@"    订单类型：",@"    订单状态：",@"    审核时间：",@"    审核结果：",@"    补卡人姓名：",@"    补卡号码：",@"    证件号码：",@"    证件地址：",@"    联系电话：",@"    近期联系号码：",@"    收件人姓名：",@"    收件人号码：",@"    收件人地址：",@"    邮寄选项：",@"    状态："];
        [self addInfo];
        self.bounces = NO;
    }
    return self;
}

- (void)addInfo{
    CGFloat y = 0;
    UILabel *lastLB = nil;
    for (int i = 0; i < self.titles.count; i++) {
        CGSize size = [Utils sizeWithFont:[UIFont systemFontOfSize:14] andMaxSize:CGSizeMake(screenWidth, 0) andStr:self.titles[i]];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, y, screenWidth, size.height+14)];
        [self addSubview:lb];
        lb.backgroundColor = [UIColor whiteColor];
        lb.text = self.titles[i];
        lb.font = [UIFont systemFontOfSize:14];
        lb.textColor = [Utils colorRGB:@"#666666"];
        y = lb.origin.y + lb.size.height;
        lastLB = lb;
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
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    
    UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, screenWidth - 30, (screenWidth - 30)/(354/225.0))];
    imageV1.image = [UIImage imageNamed:@"identifyCard2"];
    [v addSubview:imageV1];
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo((screenWidth - 30)/(354/225.0));
    }];
    [imageV1 addGestureRecognizer:tap1];
    imageV1.userInteractionEnabled = YES;
    
    UIImageView *imageV2 = [[UIImageView alloc] init];
    imageV2.image = [UIImage imageNamed:@"identifyCard1"];
    [v addSubview:imageV2];
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV1.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo((screenWidth - 30)/(354/225.0));
        make.bottom.mas_equalTo(-10);
    }];
    [imageV2 addGestureRecognizer:tap2];
    imageV2.userInteractionEnabled = YES;
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
