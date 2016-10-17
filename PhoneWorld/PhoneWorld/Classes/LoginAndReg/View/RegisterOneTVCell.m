//
//  RegisterOneTVCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RegisterOneTVCell.h"

@implementation RegisterOneTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lb = [[UILabel alloc] init];
        lb.text = @"图片（点击图片可放大）";
        lb.textColor = [Utils colorRGB:@"#666666"];
        lb.font = [UIFont systemFontOfSize:14];
        NSRange range = [lb.text rangeOfString:@"（点击图片可放大）"];
        [self setTextColor:lb FontNumber:[UIFont systemFontOfSize:10] AndRange:range AndColor:[Utils colorRGB:@"#cccccc"]];
        [self addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(135);
            make.height.mas_equalTo(16);
        }];

    }
    return self;
}

//设置不同字体颜色
-(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    label.attributedText = str;
}

@end
