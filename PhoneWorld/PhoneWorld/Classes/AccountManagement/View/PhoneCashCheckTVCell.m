//
//  PhoneCashCheckTVCell.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "PhoneCashCheckTVCell.h"

@implementation PhoneCashCheckTVCell


- (void)setUserinfos:(NSArray *)userinfos{
    _userinfos = userinfos;
    for (int i = 0; i < 4; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + 30*i, screenWidth - 30, 16)];
        [self addSubview:lb];
        lb.font = [UIFont systemFontOfSize:textfont14];
        lb.textColor = [Utils colorRGB:@"#666666"];
        lb.text = self.userinfos[i];
        if (i == 0) {
            [lb setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        }
    }
}

@end
