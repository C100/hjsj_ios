//
//  WebUtils.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/31.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "WebUtils.h"
#import "BaseWebUtils.h"
#import "Utils.h"

#define mainPath @"http://121.46.26.148:8080/newagency/AgencyInterface"
#define app_key @"382C6A0C7A19D490"
#define app_pwd @"141997CD28D5547D"
#define app_keyMD5 [Utils md5String:app_key]

#define loginPath @"/agency_login"
#define logoutPath @"/agency_logout"
#define registerPath @"/agency_register"
#define alterPasswordPath @"/agency_modifyPwd"
#define forgetPassword @"/agency_forgetPwd"
#define createPayPassword @"/agency_user_pinCreate"
#define alterPayPassword @"/agency_user_pinmodifyPwd"
#define personalInfo @"/agency_information"
#define homeScrollPicture @"/agency_Carousel" //首页轮播图
#define sendCaptcha @"/agency_sendCaptcha"//发送短信验证码
#define checkCaptcha @"/agency_verifyCaptcha" //验证短信验证码是否正确
#define sendSuggest @"/agency_feedback"  //发送意见反馈
#define pukCheck @"/agency_check"  //成卡开户——puk码验证
#define whiteNumberPool @"/agency_whiteNumberPool"  //返回白卡开户号码池
#define randomNumbers @"/agency_randomNumber"  //根据号码池id和靓号规则返回随机号码
#define messageList @"/agency_NoticeList"//消息列表
#define messageDetail @"/agency_getNotice"  //消息具体内容
#define orderListInquiry @"/agency_orderList"//成卡开户／白卡开户查询

@implementation WebUtils
//登录
+ (void)requestLoginResultWithUserName:(NSString *)username andPassword:(NSString *)password andWebUtilsCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,loginPath];//得到完整路径
    NSString *passwordMD5 = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",password]];//得到md5加密过后密码
    NSMutableDictionary *params = [@{@"userName":username,@"password":passwordMD5} mutableCopy];//得到parameter
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];//得到app_sign
    
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}
//登出
+ (void)requestLogoutResultWithCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,logoutPath];//得到完整路径
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [ud objectForKey:@"session_token"];
    NSMutableDictionary *params = [@{@"session_token":sessionToken} mutableCopy];//得到parameter
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];//得到app_sign
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}
//注册
+ (void)requestRegisterResultWithRegisterModel:(RegisterModel *)registerModel andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,registerPath];
    NSString *regString = [Utils MydictionaryToJSON:registerModel.regDic];
    regString = [regString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,regString,app_pwd]];
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":registerModel.regDic} mutableCopy];
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}
//登录密码修改
+ (void)requestAlterPasswordWithOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)newPassword andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,alterPasswordPath];
    NSString *oldPass = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",oldPassword]];
    NSString *newPass = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",newPassword]];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:@"session_token"];
    NSMutableDictionary *params = [@{@"session_token":token,@"old_password":oldPass,@"new_password":newPass} mutableCopy];
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];

    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}
//忘记密码
+ (void)requestForgetPasswordWithUserName:(NSString *)username andTel:(NSString *)tel andCaptcha:(NSString *)captcha andPassword:(NSString *)password andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,forgetPassword];

    NSString *passwordMD5 = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",password]];
    NSMutableDictionary *params = [@{@"userName":username,@"tel":tel,@"captcha":captcha,@"password":passwordMD5} mutableCopy];
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//支付密码创建
+ (void)requestCreatePayPasswordWithPassword:(NSString *)password andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,createPayPassword];
    
    NSString *passwordMD5 = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",password]];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:@"session_token"];
    
    NSMutableDictionary *params = [@{@"session_token":token,@"password":passwordMD5} mutableCopy];
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];

}

//支付密码修改
+ (void)requestAlterPayPasswordWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,alterPayPassword];
    
    NSString *oldPass = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",oldPassword]];
    NSString *newPass = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",newPassword]];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:@"session_token"];
    NSMutableDictionary *params = [@{@"session_token":token,@"old_password":oldPass,@"new_password":newPass} mutableCopy];
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//返回个人信息
+ (void)requestPersonalInfoWithSessionToken:(NSString *)sessionToken andUserName:(NSString *)username andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,personalInfo];
    NSMutableDictionary *params = [@{@"session_token":sessionToken,@"userName":username} mutableCopy];
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];

    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//返回首页轮播图
+ (void)requestHomeScrollPictureWithCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,homeScrollPicture];
    NSMutableDictionary *params = [@{@"parameter":@""} mutableCopy];
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//发送短信验证  根据不同type
+ (void)requestSendCaptchaWithType:(int)type andTel:(NSString *)tel andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,sendCaptcha];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [ud objectForKey:@"session_token"];
    NSString *typeStr = [NSString stringWithFormat:@"%d",type];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (type == 0 || type == 1) {
        params = [@{@"session_token":sessionToken,@"tel":tel,@"captcha_type":typeStr} mutableCopy];//得到parameter
    }else{
        params = [@{@"session_token":sessionToken,@"captcha_type":typeStr} mutableCopy];//得到parameter
    }
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//短信验证码验证
+ (void)requestCaptchaCheckWithCaptcha:(NSString *)captcha andType:(int)type andTel:(NSString *)tel andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,checkCaptcha];

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [ud objectForKey:@"session_token"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (type == 0 || type == 1) {
        params = [@{@"session_token":sessionToken,@"tel":tel,@"captcha":captcha} mutableCopy];//得到parameter
    }else{
        params = [@{@"session_token":sessionToken,@"captcha":captcha} mutableCopy];//得到parameter
    }
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//意见反馈
+ (void)requestSuggestWithContent:(NSString *)content andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,sendSuggest];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [ud objectForKey:@"session_token"];
    
    NSMutableDictionary *params = [@{@"session_token":sessionToken,@"title":@"suggest",@"content":content} mutableCopy];//得到parameter
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//成卡开户------------------
//成卡开户之puk码验证
+ (void)requestFinishedCardWithTel:(NSString *)tel andPUK:(NSString *)puk andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,pukCheck];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [ud objectForKey:@"session_token"];
    
    NSMutableDictionary *params = [@{@"session_token":sessionToken,@"tel":tel,@"puk":puk} mutableCopy];//得到parameter
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//白卡开户------------------
//白卡开户返回号码池
+ (void)requestWhiteCardPhoneNumbersWithCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,whiteNumberPool];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [ud objectForKey:@"session_token"];
    
    NSMutableDictionary *params = [@{@"session_token":sessionToken} mutableCopy];//得到parameter
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//根据号码池和靓号规则返回随机号码
+ (void)requestPhoneNumbersWithNumberPool:(int)pool andNumberType:(NSString *)type andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,randomNumbers];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [ud objectForKey:@"session_token"];
    NSString *poolStr = [NSString stringWithFormat:@"%d",pool];
    NSMutableDictionary *params = [@{@"session_token":sessionToken,@"numberpool":poolStr,@"numberType":type} mutableCopy];//得到parameter
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//消息推送——消息列表
+ (void)requestMessageListWithLinage:(NSString *)linage andPage:(NSString *)page andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,messageList];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [ud objectForKey:@"session_token"];
    NSMutableDictionary *params = [@{@"session_token":sessionToken,@"linage":linage,@"page":page} mutableCopy];//得到parameter
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//消息推送——具体内容
+ (void)requestMessageDetailWithId:(NSString *)messageId andCallBack:(WebUtilsCallBack1)callBack{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,messageDetail];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [ud objectForKey:@"session_token"];
    NSMutableDictionary *params = [@{@"session_token":sessionToken,@"id":messageId} mutableCopy];//得到parameter
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//成卡／白卡开户查询
+ (void)requestInquiryOrderListWithPhoneNumber:(NSString *)number andType:(NSString *)type andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andOrderStatusCode:(NSString *)orderStatusCode andOrderStatusName:(NSString *)orderStatusName andPage:(NSString *)page andLinage:(NSString *)linage andCallBack:(WebUtilsCallBack1)callBack{
    
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,orderListInquiry];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [ud objectForKey:@"session_token"];
    
    NSMutableDictionary *params = [@{@"session_token":sessionToken} mutableCopy];
    if (![number isEqualToString:@"无"]) {
        [params setObject:number forKey:@"number"];
    }
    if (![type isEqualToString:@""]) {
        [params setObject:type forKey:@"type"];
    }
    if (![startTime isEqualToString:@"无"]) {
        [params setObject:startTime forKey:@"startTime"];
    }
    if (![endTime isEqualToString:@"无"]) {
        [params setObject:endTime forKey:@"endTime"];
    }
    if (![orderStatusCode isEqualToString:@"无"]) {
        [params setObject:orderStatusCode forKey:@"orderStatusCode"];
    }
    if (![orderStatusName isEqualToString:@"无"]) {
        [params setObject:orderStatusName forKey:@"orderStatusName"];
    }
    [params setObject:page forKey:@"page"];
    [params setObject:linage forKey:@"linage"];
    
    NSString *paramsString = [Utils MydictionaryToJSON:params];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":params} mutableCopy];
    
    [BaseWebUtils postSynRequestWithURL:path paramters:sendParams finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

@end
