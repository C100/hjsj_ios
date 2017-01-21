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

//点击次数
+ (void)requestWithTouchTimes;

//佣金模块信息
+ (void)requestCommissionCountWithDate:(NSString *)date andCallBack:(WebUtilsCallBack1)callBack;

//开户统计模块
+ (void)requestOpenCountWithDate:(NSString *)date andCallBack:(WebUtilsCallBack1)callBack;

//号码充值（充值手机号）
+ (void)requestTopInfoWithNumber:(NSString *)phoneNumber andMoney:(NSString  *)money andPayPassword:(NSString *)payPassword andCallBack:(WebUtilsCallBack1)callBack;

//登陆
+ (void)requestLoginResultWithUserName:(NSString *)username andPassword:(NSString *)password andWebUtilsCallBack:(WebUtilsCallBack1)callBack;
//登出
+ (void)requestLogoutResultWithCallBack:(WebUtilsCallBack1)callBack;
//注册
+ (void)requestRegisterResultWithRegisterModel:(RegisterModel *)registerModel andCallBack:(WebUtilsCallBack1)callBack;
//修改登录密码
+ (void)requestAlterPasswordWithOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)newPassword andCallBack:(WebUtilsCallBack1)callBack;
//忘记密码  password相当于修改过后的新密码
+ (void)requestForgetPasswordWithTel:(NSString *)tel andCaptcha:(NSString *)captcha andPassword:(NSString *)password andCallBack:(WebUtilsCallBack1)callBack;
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
//验证号段信息 （验证手机号是否为话机世界所拥有的手机号）
+ (void)requestSegmentWithTel:(NSString *)tel andCallBack:(WebUtilsCallBack1)callBack;

//意见反馈
+ (void)requestSuggestWithContent:(NSString *)content andCallBack:(WebUtilsCallBack1)callBack;

//成卡开户---------------------------------------------------
//成卡开户之puk码验证
+ (void)requestFinishedCardWithTel:(NSString *)tel andPUK:(NSString *)puk andCallBack:(WebUtilsCallBack1)callBack;
//成卡开户——根据套餐id的到活动包信息
+ (void)requestPackagesWithID:(NSString *)pid andCallBack:(WebUtilsCallBack1)callBack;
//成卡开户——金额信息
+ (void)requestMoneyInfoWithPrestore:(NSString *)prestore andPromotionId:(NSString *)promotionId andCallBack:(WebUtilsCallBack1)callBack;
//成卡开户
+ (void)requestSetOpenWithDictionary:(NSDictionary *)dic andcallBack:(WebUtilsCallBack1)callBack;

//白卡开户---------------------------------------------------
//白卡开户返回号码池
+ (void)requestWhiteCardPhoneNumbersWithCallBack:(WebUtilsCallBack1)callBack;
//根据号码池id和靓号规则返回随机号码
+ (void)requestPhoneNumbersWithNumberPool:(int)pool andNumberType:(NSString *)type andCallBack:(WebUtilsCallBack1)callBack;
//白卡开户——号码锁定
+ (void)requestLockNumberWithNumber:(NSString *)number andNumberpoolId:(NSString *)poolId andNumberType:(NSString *)numberType andCallBack:(WebUtilsCallBack1)callBack;
//白卡开户——获取imsi信息
+ (void)requestImsiInfoWithNumber:(NSString *)number andICCID:(NSString *)iccid andCallBack:(WebUtilsCallBack1)callBack;
//白卡开户——写卡状态（已经与预开户结合，这个不用调用）
+ (void)requestCardResultWithICCID:(NSString *)iccid andCallBack:(WebUtilsCallBack1)callBack;
//白卡开户——预开户
+ (void)requestPreopenWithNumber:(NSString *)number andICCID:(NSString *)iccid andCallBack:(WebUtilsCallBack1)callBack;
//白卡开户
+ (void)requestOpenWhiteWithDictionary:(NSDictionary *)dic andCallBack:(WebUtilsCallBack1)callBack;


//消息推送——消息列表
+ (void)requestMessageListWithLinage:(NSString *)linage andPage:(NSString *)page andCallBack:(WebUtilsCallBack1)callBack;
//消息推送——具体内容
+ (void)requestMessageDetailWithId:(NSString *)messageId andCallBack:(WebUtilsCallBack1)callBack;

//订单查询---------------------------------------------------
//  成卡／白卡开户查询
+ (void)requestInquiryOrderListWithPhoneNumber:(NSString *)number andType:(NSString *)type andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andOrderStatusCode:(NSString *)orderStatusCode andOrderStatusName:(NSString *)orderStatusName andPage:(NSString *)page andLinage:(NSString *)linage andCallBack:(WebUtilsCallBack1)callBack;

//  过户／补卡查询
+ (void)requestCardTransferListWithNumber:(NSString *)number andType:(NSString *)type andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andStartCode:(NSString *)startCode andStartName:(NSString *)startName andPage:(NSString *)page andLinage:(NSString *)linage andCallBack:(WebUtilsCallBack1)callBack;
//充值查询
+ (void)requestRechargeListWithNumber:(NSString *)number andRechargeType:(NSString *)rechargeType andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andPage:(NSString *)page andLinage:(NSString *)linage andCallBack:(WebUtilsCallBack1)callBack;

//开户详情  (成卡开户／白卡开户)
+ (void)requestOrderDetailWithOrderNo:(NSString *)orderNo andCallBack:(WebUtilsCallBack1)callBack;
//过户详情
+ (void)requestTransferDetailWithId:(NSString *)orderId andCallBack:(WebUtilsCallBack1)callBack;
//根据订单编号得到----补卡详情
+ (void)requestCardTransferDetailWithId:(NSString *)cardId andCallBack:(WebUtilsCallBack1)callBack;

//账户管理------------------------------
//账户余额查询
+ (void)requestAccountMoneyWithCallBack:(WebUtilsCallBack1)callBack;
//账户充值－预订单（就是需要微信支付或者支付宝支付的）
+ (void)requestReAddRechargeRecordWithNumber:(NSString *)number andMoney:(NSString *)money andRechargeMethod:(NSString *)method andCallBack:(WebUtilsCallBack1)callBack;

//卡片管理-------------------------------
//过户信息提交
+ (void)requestTransferInfoWithDic:(NSDictionary *)dic andCallBack:(WebUtilsCallBack1)callBack;

//补卡信息提交
+ (void)requestRepairInfoWithDic:(NSDictionary *)dic andCallBack:(WebUtilsCallBack1)callBack;

//渠道商管理
+ (void)requestChannelListWithPage:(int)page andLinage:(int)linage andCallBack:(WebUtilsCallBack1)callBack;

//订单记录
+ (void)requestOrderListWithOrgCode:(NSString *)orgCode andMonthCount:(NSString *)count andPage:(int)page andLinage:(int)linage andCallBack:(WebUtilsCallBack1)callBack;
    
//话费余额查询
+ (void)requestPhoneNumberMoneyWithNumber:(NSString *)number andCallBack:(WebUtilsCallBack1)callBack;

//接口44  登陆时验证是否是话机世界手机号
+ (void)requestIsHJSJNumberWithNumber:(NSString *)number andCallBack:(WebUtilsCallBack1)callBack;

//关于我们
+ (void)requestAboutUsWithCallBack:(WebUtilsCallBack1)callBack;

//充值优惠
+ (void)requestDiscountInfoWithCallBack:(WebUtilsCallBack1)callBack;

//是否有支付密码
+ (void)requestHasPayPasswordWithCallBack:(WebUtilsCallBack1)callBack;

//话费充值其他金额优惠信息
+ (void)requestOtherRechargeDiscountWithMoney:(NSString *)money andCallBack:(WebUtilsCallBack1)callBack;

@end
