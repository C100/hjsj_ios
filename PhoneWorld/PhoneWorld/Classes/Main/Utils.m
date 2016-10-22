//
//  Utils.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+ (UIColor *)colorRGB:(NSString *)color{
    // 转换成标准16进制数
    NSString *newColor = [color stringByReplacingCharactersInRange:[color rangeOfString:@"#"] withString:@"0x"];
    // 十六进制字符串转成整形。
    long colorLong = strtoul([newColor cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B =  colorLong & 0x0000FF;
    UIColor *rgbColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    return rgbColor;
}

#pragma mark - 正则表达式
+ (BOOL)isMobile:(NSString *)mobileNumbel{
    /**
          * 手机号码
          * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
          * 联通：130,131,132,152,155,156,185,186
          * 电信：133,1349,153,180,189,181(增加)
          */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
          10         * 中国移动：China Mobile
          11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
          12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
          15         * 中国联通：China Unicom
          16         * 130,131,132,152,155,156,185,186
          17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
          20         * 中国电信：China Telecom
          21         * 133,1349,153,180,189,181(增加)
          22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNumber:(NSString *)number{
    NSString *numberZ = @"^[0-9]*$";
    NSPredicate *regextestNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberZ];
    if ([regextestNumber evaluateWithObject:number]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isEmailAddress:(NSString *)email{
   NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *regextestEmail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([regextestEmail evaluateWithObject:email]) {
        return YES;
    }
   return NO;
}

+ (BOOL)isIDNumber:(NSString *)idNumber{
    NSString *idNumberRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *regextestID = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idNumberRegex];
    BOOL isMatch=[regextestID evaluateWithObject:idNumber];
    return isMatch;
}

+ (BOOL)checkPassword:(NSString*) password{
    NSString*pattern=@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch=[pred evaluateWithObject:password];
    return isMatch;
}

#pragma mark -- 提醒弹窗
+(void)toastview:(NSString *)title
{
    [[[UIApplication sharedApplication] keyWindow] makeToast:title duration:1.0 position:CSToastPositionCenter];
}

+ (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andStr:(NSString *)str{
    NSDictionary *dic = @{NSFontAttributeName : font};
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

+ (UIBarButtonItem *)returnBackButton{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"返回";
    [backButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    return backButton;
}

+ (NSMutableAttributedString *)setTextColor:(NSString *)text FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    return str;
}

@end
