//
//  RightItemView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/11/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RightItemView.h"

static RightItemView *_rightItemView;

@implementation RightItemView

+ (RightItemView *)sharedRightItemView{
    if (_rightItemView == nil) {
        _rightItemView = [[RightItemView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    }
    return _rightItemView;
}

- (void)unreadAction:(NSNotification *)noti{
    self.redLabel.hidden = NO;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"NO" forKey:@"redItem"];
//    [ud setBool:NO forKey:@"redItem"];
    [ud synchronize];
}

- (void)readAction:(NSNotification *)noti{
    self.redLabel.hidden = YES;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"YES" forKey:@"redItem"];
    [ud synchronize];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self rightButton];
        [self redLabel];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readAction:) name:@"readNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unreadAction:) name:@"unreadNotification" object:nil];
    }
    return self;
}

- (UIButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [[UIButton alloc] init];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
        }];
        
        [_rightButton setImage:[UIImage imageNamed:@"news_white"] forState:UIControlStateNormal];
//        _rightButton.adjustsImageWhenHighlighted = NO;//图片高亮时自适应关闭
        
        [_rightButton setImage:[UIImage imageNamed:@"news_white"] forState:UIControlStateHighlighted];
        
        [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, -30)];//设置图片这个属性改变图片在button上的位置
        
        [_rightButton setTintColor:[UIColor redColor]];
    }
    return _rightButton;
}

- (UILabel *)redLabel{
    if (_redLabel == nil) {
        _redLabel = [[UILabel alloc] init];
        [self addSubview:_redLabel];
        [_redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.right.mas_equalTo(2);
            make.width.height.mas_equalTo(6);
        }];
        _redLabel.backgroundColor = [UIColor whiteColor];
        _redLabel.layer.cornerRadius = 3;
        _redLabel.layer.masksToBounds = YES;
    }
    return _redLabel;
}

@end
