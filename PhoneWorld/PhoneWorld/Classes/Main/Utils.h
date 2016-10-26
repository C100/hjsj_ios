//
//  Utils.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (BOOL)isSIMInstalled;

+ (UIColor *)colorRGB:(NSString *)color;

+ (BOOL)isMobile:(NSString *)mobileNumbel;

+ (BOOL)isNumber:(NSString *)number;

+ (BOOL)isEmailAddress:(NSString *)email;

+ (BOOL)isIDNumber:(NSString *)idNumber;

+ (BOOL)checkPassword:(NSString*) password;

+(void)toastview:(NSString *)title;

+ (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andStr:(NSString *)str;

+ (UIBarButtonItem *)returnBackButton;

+ (NSMutableAttributedString *)setTextColor:(NSString *)text FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor;

+ (UIButton *)returnBextButtonWithTitle:(NSString *)title;

@end
