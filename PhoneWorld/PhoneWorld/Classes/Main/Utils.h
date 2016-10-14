//
//  Utils.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
+ (UIColor *)colorRGB:(NSString *)color;

+ (BOOL)isMobile:(NSString *)mobileNumbel;

+ (BOOL)isNumber:(NSString *)number;

+(void)toastview:(NSString *)title;

+ (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andStr:(NSString *)str;

+ (BOOL)checkPassword:(NSString*) password;

@end
