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

+ (NSString *)getRightICCIDWithString:(NSString *)iccidString;

+ (NSString *)getRightIMSIWithString:(NSString *)imsiString;

+ (BOOL)isRightString:(NSString *)string;//判断只能输入中文、字母、数字

+ (int)compareDateWithNewDate:(NSString *)newDate andOldDate:(NSString *)oldDate;//日期比较（精确到时分秒）

+ (int)compareFilterDateWithNewDate:(NSString *)newDate andOldDate:(NSString *)oldDate;//筛选日期大小比较（不精确到时分秒）

+ (UITextField *)returnTextFieldWithImageName:(NSString *)imageName andPlaceholder:(NSString *)placeholder;//返回左边带图片的UITextField

+ (UIButton *)returnNextButtonWithTitle:(NSString *)title;//返回下一步样式的按钮

+ (UIBarButtonItem *)returnBackButton;//导航栏返回按钮样式


+ (void)drawChartLineWithLineChart:(PNLineChart *)lineChart andXArray:(NSArray *)xArray andYArray:(NSArray *)YArray andMax:(CGFloat)max andAverage:(CGFloat)average andTitle:(NSString *)title;//PNLineChart画线

+ (NSString *)getLastMonth;//得到上个月

+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view;//得到navigationcontroller下navigationBar底下的线视图

+ (BOOL)logoutAction:(NSString *)message;//如果有接口返回mes为sessionToken有误则跳到登陆界面

+ (NSString *)getSessionToken;

+ (NSString *)md5String:(NSString *)inputText;//md5密码加密

+ (NSString*)imagechange:(UIImage *)image;//图片base64变成string

+ (UIImage *)stringToUIImageWithString:(NSString *)string;//image转换成string

+ (NSString *)dictionaryToJSON:(NSDictionary *)dic;//字典转换称json  系统提供

+ (NSString *)MydictionaryToJSON:(NSDictionary *)dic;

+ (NSString *)JSONToOnlyString:(NSString *)string;//json格式字符串去掉空白字符与换行符

+ (UIColor *)colorRGB:(NSString *)color;

+ (BOOL)isMobile:(NSString *)mobileNumbel;//话机号码

+ (BOOL)isNumber:(NSString *)number;

+ (BOOL)isEmailAddress:(NSString *)email;

+ (BOOL)isIDNumber:(NSString *)idNumber;

+ (BOOL)checkPassword:(NSString*) password;

+ (BOOL)checkPayPassword:(NSString *)payPassword;

+(void)toastview:(NSString *)title;

+ (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andStr:(NSString *)str;

+ (NSMutableAttributedString *)setTextColor:(NSString *)text FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor;

+ (void)clearAllUserDefaultsData;//清除userdefaults所有数据

+ (NSString *)getSwapSmscent:(NSString *)smscent;

@end
