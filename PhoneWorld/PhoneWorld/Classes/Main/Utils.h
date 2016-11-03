//
//  Utils.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Utils : NSObject

+ (NSString *)md5String:(NSString *)inputText;//md5密码加密

+ (NSString*)imagechange:(UIImage *)image;//

+ (NSString *)imageToNSStringWithImage:(UIImage *)image;//base64:string转换成image  有问题

+ (UIImage *)stringToUIImageWithString:(NSString *)string;//image转换成string

+ (NSString *)dictionaryToJSON:(NSDictionary *)dic;//字典转换称json  系统提供

+ (NSString *)MydictionaryToJSON:(NSDictionary *)dic;

+ (NSString *)JSONToOnlyString:(NSString *)string;//json格式字符串去掉空白字符与换行符

+ (BOOL)isSIMInstalled;

+ (UIColor *)colorRGB:(NSString *)color;

+ (BOOL)isMobile:(NSString *)mobileNumbel;//话机号码

+ (BOOL) isNormalMobile:(NSString *)mobileNumbel;//正常手机号

+ (BOOL)isNumber:(NSString *)number;

+ (BOOL)isEmailAddress:(NSString *)email;

+ (BOOL)isIDNumber:(NSString *)idNumber;

+ (BOOL)checkPassword:(NSString*) password;

+(void)toastview:(NSString *)title;

+ (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andStr:(NSString *)str;

+ (UIBarButtonItem *)returnBackButton;

+ (NSMutableAttributedString *)setTextColor:(NSString *)text FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor;

+ (UIButton *)returnBextButtonWithTitle:(NSString *)title;

+ (void)clearAllUserDefaultsData;//清除userdefaults所有数据

@end
