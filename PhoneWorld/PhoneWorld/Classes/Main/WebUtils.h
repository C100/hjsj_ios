//
//  WebUtils.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/31.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterModel.h"

typedef void(^WebUtilsCallBack1)(id obj);

@interface WebUtils : NSObject

@property (nonatomic) void(^WebUtilsCallBack) (id obj);
//登陆
+ (void)requestLoginResultWithUserName:(NSString *)username andPassword:(NSString *)password andWebUtilsCallBack:(WebUtilsCallBack1)callBack;
//登出
+ (void)requestLogoutResultWithCallBack:(WebUtilsCallBack1)callBack;
//注册
+ (void)requestRegisterResultWithRegisterModel:(RegisterModel *)registerModel andCallBack:(WebUtilsCallBack1)callBack;
//修改登录密码
+ (void)requestAlterPasswordWithOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)newPassword andCallBack:(WebUtilsCallBack1)callBack;
//忘记密码  password相当于修改过后的新密码
+ (void)requestForgetPasswordWithUserName:(NSString *)username andTel:(NSString *)tel andCaptcha:(NSString *)captcha andPassword:(NSString *)password andCallBack:(WebUtilsCallBack1)callBack;
//支付密码创建
+ (void)requestCreatePayPasswordWithPassword:(NSString *)password andCallBack:(WebUtilsCallBack1)callBack;
//支付密码修改
+ (void)requestAlterPayPasswordWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andCallBack:(WebUtilsCallBack1)callBack;
//返回用户信息
+ (void)requestPersonalInfoWithSessionToken:(NSString *)sessionToken andUserName:(NSString *)username andCallBack:(WebUtilsCallBack1)callBack;
//返回轮播图---page31
+ (void)requestHomeScrollPictureWithCallBack:(WebUtilsCallBack1)callBack;

//发送短信验证码
+ (void)requestSendCaptchaWithType:(int)type andTel:(NSString *)tel andCallBack:(WebUtilsCallBack1)callBack;
//短信验证码验证   type 1/2 需要手机号
+ (void)requestCaptchaCheckWithCaptcha:(NSString *)captcha andType:(int)type andTel:(NSString *)tel andCallBack:(WebUtilsCallBack1)callBack;

//意见反馈
+ (void)requestSuggestWithContent:(NSString *)content andCallBack:(WebUtilsCallBack1)callBack;

//成卡开户---------------------------------------------------
//成卡开户之puk码验证
+ (void)requestFinishedCardWithTel:(NSString *)tel andPUK:(NSString *)puk andCallBack:(WebUtilsCallBack1)callBack;

//白卡开户---------------------------------------------------
//白卡开户返回号码池
+ (void)requestWhiteCardPhoneNumbersWithCallBack:(WebUtilsCallBack1)callBack;
//根据号码池id和靓号规则返回随机号码
+ (void)requestPhoneNumbersWithNumberPool:(int)pool andNumberType:(NSString *)type andCallBack:(WebUtilsCallBack1)callBack;

//消息推送——消息列表
+ (void)requestMessageListWithLinage:(NSString *)linage andPage:(NSString *)page andCallBack:(WebUtilsCallBack1)callBack;
//消息推送——具体内容
+ (void)requestMessageDetailWithId:(NSString *)messageId andCallBack:(WebUtilsCallBack1)callBack;

//订单查询---------------------------------------------------
//成卡／白卡开户查询
+ (void)requestInquiryOrderListWithPhoneNumber:(NSString *)number andType:(NSString *)type andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andOrderStatusCode:(NSString *)orderStatusCode andOrderStatusName:(NSString *)orderStatusName andPage:(NSString *)page andLinage:(NSString *)linage andCallBack:(WebUtilsCallBack1)callBack;

@end
