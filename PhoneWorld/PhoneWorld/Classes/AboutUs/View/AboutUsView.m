//
//  AboutUsView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/14.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "AboutUsView.h"

@implementation AboutUsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        [self aboutUsTV];
    }
    return self;
}

- (UITextView *)aboutUsTV{
    if (_aboutUsTV == nil) {
        _aboutUsTV = [[UITextView alloc] init];
        [self addSubview:_aboutUsTV];
        _aboutUsTV.bounces = NO;
        [_aboutUsTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(200);
        }];
        _aboutUsTV.text = @"关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们";
        _aboutUsTV.font = [UIFont systemFontOfSize:14];
        _aboutUsTV.textColor = [Utils colorRGB:@"#666666"];
        _aboutUsTV.userInteractionEnabled = NO;
    }
    return _aboutUsTV;
}

@end
