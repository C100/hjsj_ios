//
//  Utils.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "Utils.h"

#import "LoginNaviViewController.h"
#import "LoginNewViewController.h"

@interface Utils ()

@end

@implementation Utils

+ (NSString *)getRightICCIDWithString:(NSString *)iccidString{
    NSString *string = [iccidString substringWithRange:NSMakeRange(0, 20)];
    
    NSMutableArray *JArray = [NSMutableArray array];
    for (int i = 0; i < string.length; i ++) {
        [JArray addObject:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    
    for (int i = 0; i < string.length; i ++) {
        if (i % 2 == 0) {
            [JArray exchangeObjectAtIndex:i withObjectAtIndex:i+1];
        }
    }
    
    NSString *newString = @"";
    for (int i = 0; i < JArray.count; i ++) {
        newString = [NSString stringWithFormat:@"%@%@",newString,JArray[i]];
    }
    return newString;
}

+ (NSString *)getRightIMSIWithString:(NSString *)imsiString{
    NSString *string = [NSString stringWithFormat:@"809%@",imsiString];
    NSMutableArray *JArray = [NSMutableArray array];
    for (int i = 0; i < string.length; i ++) {
        [JArray addObject:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    
    for (int i = 0; i < string.length; i ++) {
        if (i % 2 == 0) {
            [JArray exchangeObjectAtIndex:i withObjectAtIndex:i+1];
        }
    }
    
    NSString *newString = @"A0F4000012";
    for (int i = 0; i < JArray.count; i ++) {
        newString = [NSString stringWithFormat:@"%@%@",newString,JArray[i]];
    }
    
    for (int i = 0; i < JArray.count; i ++) {
        newString = [NSString stringWithFormat:@"%@%@",newString,JArray[i]];
    }
    
    return newString;
}

+ (NSString *)getSwapSmscent:(NSString *)smscent{
    smscent = [smscent componentsSeparatedByString:@"+86"].lastObject;
    NSString *string = [NSString stringWithFormat:@"%@F",smscent];
    NSMutableArray *JArray = [NSMutableArray array];
    for (int i = 0; i < string.length; i ++) {
        [JArray addObject:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    
    for (int i = 0; i < string.length; i ++) {
        if (i % 2 == 0) {
            [JArray exchangeObjectAtIndex:i withObjectAtIndex:i+1];
        }
    }
    
    NSString *newString = @"089168";
    for (int i = 0; i < JArray.count; i ++) {
        newString = [NSString stringWithFormat:@"%@%@",newString,JArray[i]];
    }
    
    return newString;
}

+ (BOOL)isRightString:(NSString *)string{//只能输入中文数字下划线
    NSString *content = @"^[a-zA-Z_0-9\u4e00-\u9fa5]*$";
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", content];
    if ([regextest evaluateWithObject:string]) {
        return YES;
    }
    return NO;
}

+ (int)compareDateWithNewDate:(NSString *)newDate andOldDate:(NSString *)oldDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateNew = [dateFormatter dateFromString:newDate];
    NSDate *dateOld = [dateFormatter dateFromString:oldDate];
    NSComparisonResult result = [dateNew compare:dateOld];
    if (result == NSOrderedDescending) {
        return 1;//递减new大
    }
    else if (result ==NSOrderedAscending){
        return -1;//递增old大
    }
    return 0;//一样
}

+ (int)compareFilterDateWithNewDate:(NSString *)newDate andOldDate:(NSString *)oldDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateNew = [dateFormatter dateFromString:newDate];
    NSDate *dateOld = [dateFormatter dateFromString:oldDate];
    NSComparisonResult result = [dateNew compare:dateOld];
    if (result == NSOrderedDescending) {
        return 1;//递减new大
    }
    else if (result ==NSOrderedAscending){
        return -1;//递增old大
    }
    return 0;//一样
}

+ (UITextField *)returnTextFieldWithImageName:(NSString *)imageName andPlaceholder:(NSString *)placeholder{
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    textField.textColor = [Utils colorRGB:@"#333333"];
    textField.font = [UIFont systemFontOfSize:textfont16];
    [textField setValue:[UIFont systemFontOfSize:textfont14] forKeyPath:@"_placeholderLabel.font"];
    [textField setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];

    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.image = [UIImage imageNamed:imageName];
    textField.leftView = imageV;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

+ (void)drawChartLineWithLineChart:(PNLineChart *)lineChart andXArray:(NSArray *)xArray andYArray:(NSArray *)YArray andMax:(CGFloat)max andAverage:(CGFloat)average andTitle:(NSString *)title{
    
    if (xArray != nil && YArray != nil) {
        [lineChart setXLabels:xArray];
        
        PNLineChartData *chartData1 = [[PNLineChartData alloc] init];
        chartData1.color = [UIColor redColor];
        chartData1.lineWidth = 1.0;
        chartData1.inflexionPointWidth = 5.0;
        chartData1.itemCount = lineChart.xLabels.count;
        chartData1.getData = ^(NSUInteger index){
            CGFloat yValue = [YArray[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        chartData1.inflexionPointStyle = PNLineChartPointStyleCircle;
        chartData1.dataTitle = title;
        [lineChart setYFixedValueMax:max];
        lineChart.chartData = @[chartData1];
        [lineChart strokeChart];
    }
}

+ (NSString *)getLastMonth{
    NSDate *mydate = [[NSDate alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:-1];
    
    [adcomps setDay:0];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    return [NSString stringWithFormat:@"%@",newdate];
}

+ (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

+ (BOOL)logoutAction:(NSString *)message{
    if ([message isEqualToString:@"39999"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Utils toastview:@"登录信息失效，请重新登录！"];
        });
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:@"username"];
        [ud removeObjectForKey:@"password"];
        [ud removeObjectForKey:@"session_token"];
        [ud removeObjectForKey:@"grade"];
        [ud removeObjectForKey:@"hasPayPassword"];
        [ud synchronize];
        
        LoginNaviViewController *naviVC = [[LoginNaviViewController alloc] initWithRootViewController:[[LoginNewViewController alloc] init]];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:naviVC animated:YES completion:^{
        }];
        return NO;
    }
    return YES;
}

+ (NSString *)getSessionToken{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [NSString stringWithFormat:@"%@",[ud objectForKey:@"session_token"]];
    return sessionToken;
}

+ (NSString *)md5String:(NSString *)inputText{
    const char *original_str = [inputText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}


+ (NSString*)imagechange:(UIImage *)image
{
    NSData *imgData=UIImageJPEGRepresentation(image, 0.4);
    NSString *base64Str=[imgData base64EncodedStringWithOptions:0];
    imgData=UIImageJPEGRepresentation(image, 102400.0/base64Str.length);
    base64Str=[imgData base64EncodedStringWithOptions:0];
    
    //把编码中的特殊字符转换一下
//    NSString *baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)base64Str,NULL,CFSTR(":/?#[]@!$&’()*+,;="),kCFStringEncodingUTF8);
    
    return base64Str;
}

+ (UIImage *)stringToUIImageWithString:(NSString *)string{
    NSData *decodeImageData = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodeImage = [UIImage imageWithData:decodeImageData];
    return decodeImage;
}

+ (NSString *)dictionaryToJSON:(NSDictionary *)dic{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (NSString *)MydictionaryToJSON:(NSDictionary *)dic{
    NSString *jsonStr = @"{";
    
    NSArray *keys = [dic allKeys];
    
    for (NSString * key in keys) {
        
        jsonStr = [NSString stringWithFormat:@"%@\"%@\":\"%@\",",jsonStr,key,[dic objectForKey:key]];
        
    }
    
    jsonStr = [NSString stringWithFormat:@"%@%@",[jsonStr substringWithRange:NSMakeRange(0, jsonStr.length-1)],@"}"];
    
    return jsonStr;
}

+ (NSString *)JSONToOnlyString:(NSString *)string{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return string;
}


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
    //1开头 且是11位
    NSString *string = @"^1\\d{10}$";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", string];
    if ([regextestct evaluateWithObject:mobileNumbel]) {
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

+ (BOOL)isZeroWithNumber:(NSString *)number{
    NSString *numberZ = @"^[0]*$";
    NSString *numberZZ = @"^[0]+(.[0])*$";
    NSString *numberZZZ = @"^[0]+(.[0])*$";
    NSPredicate *regextestNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberZ];
    NSPredicate *regextestNumberZZ = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberZZ];
    NSPredicate *regextestNumberZZZ = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberZZZ];
    if ([regextestNumber evaluateWithObject:number] || [regextestNumberZZ evaluateWithObject:number] || [regextestNumberZZZ evaluateWithObject:number]) {
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
    NSString*pattern=@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,12}";
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch=[pred evaluateWithObject:password];
    return isMatch;
}

+ (BOOL)checkPayPassword:(NSString *)payPassword;{
    NSString*pattern=@"^\\d{6}$";
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch=[pred evaluateWithObject:payPassword];
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
    [backButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textfont14]} forState:UIControlStateNormal];
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

+ (UIButton *)returnNextButtonWithTitle:(NSString *)title{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:MainColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 20;
    button.layer.borderColor = MainColor.CGColor;
    button.layer.borderWidth = 1;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:textfont14];
    return button;
}

+ (void)clearAllUserDefaultsData
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

@end
