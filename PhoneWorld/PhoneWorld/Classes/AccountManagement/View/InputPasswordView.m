//
//  InputPasswordView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "InputPasswordView.h"

@implementation InputPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (UIButton *)backButton{
    if (_backButton == nil) {
        _backButton = [[UIButton alloc] init];
        [self addSubview:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    return _backButton;
}

@end
