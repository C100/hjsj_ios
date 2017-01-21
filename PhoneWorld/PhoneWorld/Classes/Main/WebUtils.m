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


#define app_key @"382C6A0C7A19D490"
#define app_pwd @"141997CD28D5547D"
#define app_keyMD5 [Utils md5String:app_key]

#define topPhoneNumber @"/agency_recharge" //手机号充值
#define homeScrollPicture @"/agency_Carousel" //首页轮播图
#define sendCaptcha @"/agency_sendCaptcha"//发送短信验证码
#define checkCaptcha @"/agency_verifyCaptcha" //验证短信验证码是否正确
#define numberSegment @"/agency_numberSegment" //验证手机号是否为话机世界所拥有的手机号
#define sendSuggest @"/agency_feedback"  //发送意见反馈
#define pukCheck @"/agency_check"  //成卡开户——puk码验证
#define packageGet @"/agency_promotion" //成卡开户——根据套餐id得到活动包
#define whiteNumberPool @"/agency_whiteNumberPool"  //返回白卡开户号码池
#define randomNumbers @"/agency_randomNumber"  //根据号码池id和靓号规则返回随机号码
#define messageList @"/agency_NoticeList"//消息列表
#define messageDetail @"/agency_getNotice"  //消息具体内容
#define orderListInquiry @"/agency_orderList"//成卡开户／白卡开户查询
#define cardTransferList @"/agency_cardTransferList" //过户补卡查询
#define rechargeList @"/agency_rechargeList" //充值列表
#define openOrderInfo @"/agency_openOrderInfo"//开户详情
#define transferOrderInfo @"/agency_transferOrderInfo"//过户详情
#define remakecardOrderInfo @"/agency_remakecardOrderInfo"  //补卡详情
#define balanceQuery @"/agency_balanceQuery" //账户余额查询
#define transferInfo @"/agency_transfer" //过户信息提交
#define repairInfo @"/agency_repairCard" //补卡信息提交

@implementation WebUtils

//点击次数
+ (void)requestWithTouchTimes{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int phoneRecharge = (int)[ud integerForKey:@"phoneRecharge"];//话费充值
    int accountRecharge = (int)[ud integerForKey:@"accountRecharge"];//账户充值
    int transform = (int)[ud integerForKey:@"transform"];//过户
    int renewOpen = (int)[ud integerForKey:@"renewOpen"];//成卡开户
    int newOpen = (int)[ud integerForKey:@"newOpen"];//白卡开户
    int replace = (int)[ud integerForKey:@"replace"];//补卡
    int phoneBanlance = (int)[ud integerForKey:@"phoneBanlance"];//号码余额查询
    int accountRecord = (int)[ud integerForKey:@"accountRecord"];//账户充值查询
    int cardQuery = (int)[ud integerForKey:@"cardQuery"];//过户补卡状态查询
    int orderQueryRenew = (int)[ud integerForKey:@"orderQueryRenew"];//订单查询成卡开户
    int orderQueryNew = (int)[ud integerForKey:@"orderQueryNew"];//订单查询白卡开户
    int orderQueryTransform = (int)[ud integerForKey:@"orderQueryTransform"];//订单查询过户
    int orderQueryReplace = (int)[ud integerForKey:@"orderQueryReplace"];//订单查询补卡
    int orderQueryRecharge = (int)[ud integerForKey:@"orderQueryRecharge"];//订单查询话费充值
    int qdsList = (int)[ud integerForKey:@"qdsList"];//渠道商列表
    int qdsOrderList = (int)[ud integerForKey:@"qdsOrderList"];//渠道商订单列表
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (phoneRecharge > 0) {
        [params setObject:@(phoneRecharge) forKey:@"phoneRecharge"];
    }
    if (accountRecharge > 0) {
        [params setObject:@(accountRecharge) forKey:@"accountRecharge"];
    }
    if (transform > 0) {
        [params setObject:@(transform) forKey:@"transform"];
    }
    if (renewOpen > 0) {
        [params setObject:@(renewOpen) forKey:@"renewOpen"];
    }
    if (newOpen > 0) {
        [params setObject:@(newOpen) forKey:@"newOpen"];
    }
    if (replace > 0) {
        [params setObject:@(replace) forKey:@"replace"];
    }
    if (accountRecord > 0) {
        [params setObject:@(accountRecord) forKey:@"accountRecord"];
    }
    if (cardQuery > 0) {
        [params setObject:@(cardQuery) forKey:@"cardQuery"];
    }
    if (phoneBanlance > 0) {
        [params setObject:@(phoneBanlance) forKey:@"phoneBanlance"];
    }
    if (orderQueryRenew > 0) {
        [params setObject:@(orderQueryRenew) forKey:@"orderQueryRenew"];
    }
    if (orderQueryNew > 0) {
        [params setObject:@(orderQueryNew) forKey:@"orderQueryNew"];
    }
    if (orderQueryTransform > 0) {
        [params setObject:@(orderQueryTransform) forKey:@"orderQueryTransform"];
    }
    if (orderQueryReplace > 0) {
        [params setObject:@(orderQueryReplace) forKey:@"orderQueryReplace"];
    }
    if (orderQueryRecharge > 0) {
        [params setObject:@(orderQueryRecharge) forKey:@"orderQueryRecharge"];
    }
    if (qdsList > 0) {
        [params setObject:@(qdsList) forKey:@"qdsList"];
    }
    if (qdsOrderList > 0) {
        [params setObject:@(qdsOrderList) forKey:@"qdsOrderList"];
    }
    
    //一个都没有的话就不传了
    if (params.count > 0) {
        [BaseWebUtils postRequestWithURL:@"/agency_FunctionStatistics" paramters:params finshedBlock:^(id obj) {
            
        }];
    }
    
}

//佣金模块信息
+ (void)requestCommissionCountWithDate:(NSString *)date andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"date":date} mutableCopy];//得到parameter
    [params setObject:[Utils getSessionToken] forKey:@"session_token"];
    [BaseWebUtils postRequestWithURL:@"/agency_commissionsQuery" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
        
    }];
}

//开户统计模块
+ (void)requestOpenCountWithDate:(NSString *)date andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"date":date} mutableCopy];//得到parameter
    [params setObject:[Utils getSessionToken] forKey:@"session_token"];
    [BaseWebUtils postRequestWithURL:@"/agency_statistic" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//号码充值（充值手机号）
+ (void)requestTopInfoWithNumber:(NSString *)phoneNumber andMoney:(NSString  *)money andPayPassword:(NSString *)payPassword andCallBack:(WebUtilsCallBack1)callBack{
    NSString *passwordMD5 = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",payPassword]];//得到md5加密过后密码
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"number":phoneNumber,@"money":money,@"pay_password":passwordMD5} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:topPhoneNumber paramters:params finshedBlock:^(id obj) {
        
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }else{
            callBack(obj);
        }
    }];
}

//登录
+ (void)requestLoginResultWithUserName:(NSString *)username andPassword:(NSString *)password andWebUtilsCallBack:(WebUtilsCallBack1)callBack{
    
//    NSString *passwordMD5 = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",password]];//得到md5加密过后密码
    NSMutableDictionary *params = [@{@"userName":username,@"password":password} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:@"/agency_login" paramters:params finshedBlock:^(id obj) {
        callBack(obj);
    }];
}
//登出
+ (void)requestLogoutResultWithCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken]} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:@"/agency_logout" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}
//注册
+ (void)requestRegisterResultWithRegisterModel:(RegisterModel *)registerModel andCallBack:(WebUtilsCallBack1)callBack{
    
    
    if (registerModel.photoOne == nil && registerModel.photoTwo == nil) {
        NSString *regString = [Utils MydictionaryToJSON:registerModel.regDic];
        regString = [regString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,regString,app_pwd]];
        NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":registerModel.regDic} mutableCopy];
        [BaseWebUtils postSynRequestWithURL:@"/agency_register" paramters:sendParams finshedBlock:^(id obj) {
            callBack(obj);
        }];
    }else{
        NSMutableDictionary *imageParamsDic = [NSMutableDictionary dictionary];//得到parameter
        [imageParamsDic setObject:@"4" forKey:@"type"];
        
        NSString *photoString = [Utils MydictionaryToJSON:imageParamsDic];
        photoString = [photoString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        NSString *app_sign_photo = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,photoString,app_pwd]];
        
        NSMutableDictionary *imageLoadParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign_photo} mutableCopy];
        
        NSMutableDictionary *photoDic = [NSMutableDictionary dictionary];
        
        if (![registerModel.photoOne isEqualToString:@"无"] && ![registerModel.photoTwo isEqualToString:@"无"]) {
            [photoDic setObject:registerModel.photoOne forKey:@"photo1"];
            [photoDic setObject:registerModel.photoTwo forKey:@"photo2"];
        }else if(![registerModel.photoOne isEqualToString:@"无"] && [registerModel.photoTwo isEqualToString:@"无"]){
            [photoDic setObject:registerModel.photoOne forKey:@"photo1"];
        }else if([registerModel.photoOne isEqualToString:@"无"] && ![registerModel.photoTwo isEqualToString:@"无"]){
            [photoDic setObject:registerModel.photoTwo forKey:@"photo1"];
        }
        [imageLoadParams setObject:photoDic forKey:@"photo"];
        
        [imageLoadParams setObject:imageParamsDic forKey:@"parameter"];
        
        [BaseWebUtils postImageRequestWithParamters:imageLoadParams finshedBlock:^(id obj) {
            if ([Utils logoutAction:obj[@"code"]] == YES) {
                callBack(obj);
            }
            if (obj) {
                NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                if ([code isEqualToString:@"10000"]) {
                    if (![registerModel.photoOne isEqualToString:@"无"] && ![registerModel.photoTwo isEqualToString:@"无"]) {
                        
                        [registerModel.regDic setObject:obj[@"data"][@"photo1"] forKey:@"photoOne"];
                        [registerModel.regDic setObject:obj[@"data"][@"photo2"] forKey:@"photoTwo"];
                        
                    }else if(![registerModel.photoOne isEqualToString:@"无"] && [registerModel.photoTwo isEqualToString:@"无"]){
                        
                        [registerModel.regDic setObject:obj[@"data"][@"photo1"] forKey:@"photoOne"];
                        
                    }else if([registerModel.photoOne isEqualToString:@"无"] && ![registerModel.photoTwo isEqualToString:@"无"]){
                        
                        [registerModel.regDic setObject:obj[@"data"][@"photo1"] forKey:@"photoTwo"];
                    }
                    
                    NSString *regString = [Utils MydictionaryToJSON:registerModel.regDic];
                    regString = [regString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,regString,app_pwd]];
                    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":registerModel.regDic} mutableCopy];
                    [BaseWebUtils postSynRequestWithURL:@"/agency_register" paramters:sendParams finshedBlock:^(id obj) {
                        callBack(obj);
                    }];

                }else{
                    callBack(obj);
                }
                
                
            }
            
        }];
    }
}
//登录密码修改
+ (void)requestAlterPasswordWithOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)newPassword andCallBack:(WebUtilsCallBack1)callBack{
    
    NSString *oldPass = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",oldPassword]];
    NSString *newPass = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",newPassword]];
    
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"old_password":oldPass,@"new_password":newPass} mutableCopy];
    [BaseWebUtils postRequestWithURL:@"/agency_modifyPwd" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}
//忘记密码
+ (void)requestForgetPasswordWithTel:(NSString *)tel andCaptcha:(NSString *)captcha andPassword:(NSString *)password andCallBack:(WebUtilsCallBack1)callBack{

    NSString *passwordMD5 = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",password]];
    NSMutableDictionary *params = [@{@"userName":tel,@"captcha":captcha,@"password":passwordMD5} mutableCopy];
    [BaseWebUtils postRequestWithURL:@"/agency_forgetPwd" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//支付密码创建
+ (void)requestCreatePayPasswordWithPassword:(NSString *)password andCallBack:(WebUtilsCallBack1)callBack{
    NSString *passwordMD5 = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",password]];
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"password":passwordMD5} mutableCopy];
    [BaseWebUtils postRequestWithURL:@"/agency_user_pinCreate" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//支付密码修改
+ (void)requestAlterPayPasswordWithNewPassword:(NSString *)newPassword andOldPassword:(NSString *)oldPassword andCallBack:(WebUtilsCallBack1)callBack{
    
    NSString *oldPass = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",oldPassword]];
    NSString *newPass = [Utils md5String:[NSString stringWithFormat:@"HJSJ%@2015GK#S",newPassword]];
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"old_password":oldPass,@"new_password":newPass} mutableCopy];
    [BaseWebUtils postRequestWithURL:@"/agency_user_pinmodifyPwd" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//返回个人信息
+ (void)requestPersonalInfoWithSessionToken:(NSString *)sessionToken andUserName:(NSString *)username andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":sessionToken,@"userName":username} mutableCopy];
    [BaseWebUtils postRequestWithURL:@"/agency_information" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }else{
            callBack(obj);
        }
    }];
}

//返回首页轮播图
+ (void)requestHomeScrollPictureWithCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"parameter":@""} mutableCopy];
    [BaseWebUtils postRequestWithURL:homeScrollPicture paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//发送短信验证  根据不同type
+ (void)requestSendCaptchaWithType:(int)type andTel:(NSString *)tel andCallBack:(WebUtilsCallBack1)callBack{
    
    NSString *typeStr = [NSString stringWithFormat:@"%d",type];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (type == 2 || type == 1) {//注册和忘记号码需要手机号码
        params = [@{@"tel":tel} mutableCopy];//得到parameter
    }else{//3、4不需要手机号
        params = [@{@"session_token":[Utils getSessionToken]} mutableCopy];//得到parameter
    }
    [params setObject:typeStr forKey:@"captcha_type"];
    [BaseWebUtils postRequestWithURL:sendCaptcha paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//短信验证码验证
+ (void)requestCaptchaCheckWithCaptcha:(NSString *)captcha andType:(int)type andTel:(NSString *)tel andCallBack:(WebUtilsCallBack1)callBack{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (type == 2 || type == 1) {
        params = [@{@"tel":tel,@"captcha":captcha} mutableCopy];//得到parameter
    }else{
        params = [@{@"session_token":[Utils getSessionToken],@"captcha":captcha} mutableCopy];//得到parameter
    }
    [BaseWebUtils postRequestWithURL:checkCaptcha paramters:params finshedBlock:^(id obj) {
        callBack(obj);
    }];
}

//验证号段信息 （验证手机号是否为话机世界所拥有的手机号）
+ (void)requestSegmentWithTel:(NSString *)tel andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"tel":tel} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:numberSegment paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//意见反馈
+ (void)requestSuggestWithContent:(NSString *)content andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"title":@"suggest",@"content":content} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:sendSuggest paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//成卡开户------------------
//成卡开户之puk码验证
+ (void)requestFinishedCardWithTel:(NSString *)tel andPUK:(NSString *)puk andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"tel":tel,@"puk":puk} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:pukCheck paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//成卡开户——根据套餐id的到活动包信息
+ (void)requestPackagesWithID:(NSString *)pid andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"packageId":pid} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:packageGet paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//成卡开户——金额信息
+ (void)requestMoneyInfoWithPrestore:(NSString *)prestore andPromotionId:(NSString *)promotionId andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"prestore":prestore,@"promotionId":promotionId} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:@"/agency_money" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//成卡开户
+ (void)requestSetOpenWithDictionary:(NSDictionary *)dic andcallBack:(WebUtilsCallBack1)callBack{
//    NSMutableDictionary *params = [dic mutableCopy];//得到parameter
    
    
    /*----------图片上传-------------*/
    NSMutableDictionary *imageParamsDic = [NSMutableDictionary dictionary];//得到parameter
    [imageParamsDic setObject:[Utils getSessionToken] forKey:@"session_token"];
    [imageParamsDic setObject:@"0" forKey:@"type"];
    
    NSString *photoString = [Utils MydictionaryToJSON:imageParamsDic];
    photoString = [photoString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *app_sign_photo = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,photoString,app_pwd]];
    
    NSMutableDictionary *imageLoadParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign_photo} mutableCopy];
    
    NSMutableDictionary *photoDic = [NSMutableDictionary dictionary];
    [photoDic setObject:[dic objectForKey:@"photoFront"] forKey:@"photo1"];
    [photoDic setObject:[dic objectForKey:@"photoBack"] forKey:@"photo2"];
    
    [imageLoadParams setObject:photoDic forKey:@"photo"];
    
    [imageLoadParams setObject:imageParamsDic forKey:@"parameter"];
    
    [BaseWebUtils postImageRequestWithParamters:imageLoadParams finshedBlock:^(id obj) {
        
        if ([Utils logoutAction:obj[@"code"]] == YES) {
           
        
        if (obj) {
            
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
                [params setObject:[dic objectForKey:@"number"] forKey:@"number"];
                [params setObject:[dic objectForKey:@"authenticationType"] forKey:@"authenticationType"];
                [params setObject:[dic objectForKey:@"customerName"] forKey:@"customerName"];
                [params setObject:[dic objectForKey:@"certificatesType"] forKey:@"certificatesType"];
                [params setObject:[dic objectForKey:@"certificatesNo"] forKey:@"certificatesNo"];
                [params setObject:[dic objectForKey:@"address"] forKey:@"address"];
                if ([dic objectForKey:@"description"]) {
                    [params setObject:[dic objectForKey:@"description"] forKey:@"description"];
                }
                [params setObject:[dic objectForKey:@"cardType"] forKey:@"cardType"];
                [params setObject:[dic objectForKey:@"simId"] forKey:@"simId"];
                [params setObject:[dic objectForKey:@"simICCID"] forKey:@"simICCID"];
                
                [params setObject:[dic objectForKey:@"packageId"] forKey:@"packageId"];
                [params setObject:[dic objectForKey:@"promotionsId"] forKey:@"promotionsId"];
                [params setObject:[dic objectForKey:@"orderAmount"] forKey:@"orderAmount"];
                [params setObject:[dic objectForKey:@"org_number_poolsId"] forKey:@"org_number_poolsId"];
                
                [params setObject:obj[@"data"][@"photo1"] forKey:@"photoFront"];
                [params setObject:obj[@"data"][@"photo2"] forKey:@"photoBack"];

                [params setObject:[Utils getSessionToken] forKey:@"session_token"];
                [BaseWebUtils postRequestWithURL:@"/agency_setOpen" paramters:params finshedBlock:^(id obj) {
                    
                    callBack(obj);
                }];
            }else{
                callBack(obj);
            }
            
            
        }
        
        }else{
            callBack(obj);
        }
        
        
    }];
    /*----------图片上传-------------*/
    
    
}

//白卡开户------------------
//白卡开户返回号码池
+ (void)requestWhiteCardPhoneNumbersWithCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken]} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:whiteNumberPool paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//根据号码池和靓号规则返回随机号码
+ (void)requestPhoneNumbersWithNumberPool:(int)pool andNumberType:(NSString *)type andCallBack:(WebUtilsCallBack1)callBack{
    NSString *poolStr = [NSString stringWithFormat:@"%d",pool];
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"numberpool":poolStr,@"numberType":type} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:randomNumbers paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//白卡开户——号码锁定
+ (void)requestLockNumberWithNumber:(NSString *)number andNumberpoolId:(NSString *)poolId andNumberType:(NSString *)numberType andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"number":number,@"numberpoolId":poolId,@"numberType":numberType} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:@"/agency_lockNumber" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//白卡开户——获取imsi信息
+ (void)requestImsiInfoWithNumber:(NSString *)number andICCID:(NSString *)iccid andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"number":number,@"iccid":iccid} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:@"/agency_imsi" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}
//白卡开户——写卡状态
+ (void)requestCardResultWithICCID:(NSString *)iccid andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"iccid":iccid} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:@"/agency_cardResults" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//白卡开户——预开户
+ (void)requestPreopenWithNumber:(NSString *)number andICCID:(NSString *)iccid andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"number":number,@"iccid":iccid} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:@"/agency_preopen" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//白卡开户
+ (void)requestOpenWhiteWithDictionary:(NSDictionary *)dic andCallBack:(WebUtilsCallBack1)callBack{
//    NSMutableDictionary *params = [dic mutableCopy];//得到parameter
    
    
    /*----------图片上传-------------*/
    NSMutableDictionary *imageParamsDic = [NSMutableDictionary dictionary];//得到parameter
    [imageParamsDic setObject:[Utils getSessionToken] forKey:@"session_token"];
    [imageParamsDic setObject:@"0" forKey:@"type"];
    
    NSString *photoString = [Utils MydictionaryToJSON:imageParamsDic];
    photoString = [photoString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *app_sign_photo = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,photoString,app_pwd]];
    
    NSMutableDictionary *imageLoadParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign_photo} mutableCopy];
    
    NSMutableDictionary *photoDic = [NSMutableDictionary dictionary];
    [photoDic setObject:[dic objectForKey:@"photoFront"] forKey:@"photo1"];
    [photoDic setObject:[dic objectForKey:@"photoBack"] forKey:@"photo2"];
    
    [imageLoadParams setObject:photoDic forKey:@"photo"];
    
    [imageLoadParams setObject:imageParamsDic forKey:@"parameter"];
    
    [BaseWebUtils postImageRequestWithParamters:imageLoadParams finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
         

        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                
#warning 白卡开户white-----图片字段没有
                
                NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
                [params setObject:[dic objectForKey:@"address"] forKey:@"address"];
                [params setObject:[dic objectForKey:@"cardType"] forKey:@"cardType"];
                [params setObject:[dic objectForKey:@"simId"] forKey:@"simId"];
                [params setObject:[dic objectForKey:@"certificatesType"] forKey:@"certificatesType"];
                [params setObject:[dic objectForKey:@"certificatesNo"] forKey:@"certificatesNo"];
                [params setObject:[dic objectForKey:@"iccid"] forKey:@"iccid"];
                [params setObject:[dic objectForKey:@"imsi"] forKey:@"imsi"];
                [params setObject:[dic objectForKey:@"customerName"] forKey:@"customerName"];
                [params setObject:[dic objectForKey:@"orderAmount"] forKey:@"orderAmount"];
                [params setObject:[dic objectForKey:@"number"] forKey:@"number"];
                [params setObject:[dic objectForKey:@"packageId"] forKey:@"packageId"];
                [params setObject:[dic objectForKey:@"promotionsId"] forKey:@"promotionsId"];
                [params setObject:[dic objectForKey:@"payAmount"] forKey:@"payAmount"];
                
                [params setObject:[Utils getSessionToken] forKey:@"session_token"];
                [BaseWebUtils postRequestWithURL:@"/agency_whiteSetOpen" paramters:params finshedBlock:^(id obj) {
                    if([Utils logoutAction:obj[@"code"]] == YES){
                        callBack(obj);
                    }
                    
                }];
            }else{
                callBack(obj);
            }
        }
            
        }else{
            callBack(obj);
        }
    }];
    /*----------图片上传-------------*/
    
}


//消息推送——消息列表
+ (void)requestMessageListWithLinage:(NSString *)linage andPage:(NSString *)page andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"linage":linage,@"page":page} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:messageList paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//消息推送——具体内容
+ (void)requestMessageDetailWithId:(NSString *)messageId andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"id":messageId} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:messageDetail paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//订单查询----------成卡／白卡开户查询--------------
+ (void)requestInquiryOrderListWithPhoneNumber:(NSString *)number andType:(NSString *)type andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andOrderStatusCode:(NSString *)orderStatusCode andOrderStatusName:(NSString *)orderStatusName andPage:(NSString *)page andLinage:(NSString *)linage andCallBack:(WebUtilsCallBack1)callBack{
    
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken]} mutableCopy];
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
    //这个重复不需要，删除
//    if (![orderStatusName isEqualToString:@"无"]) {
//        [params setObject:orderStatusName forKey:@"orderStatusName"];
//    }
    [params setObject:page forKey:@"page"];
    [params setObject:linage forKey:@"linage"];
    
    [BaseWebUtils postRequestWithURL:orderListInquiry paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }else{
            callBack(obj);
        }
    }];
}

//  过户／补卡查询
+ (void)requestCardTransferListWithNumber:(NSString *)number andType:(NSString *)type andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andStartCode:(NSString *)startCode andStartName:(NSString *)startName andPage:(NSString *)page andLinage:(NSString *)linage andCallBack:(WebUtilsCallBack1)callBack{
    
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken]} mutableCopy];
    if (![number isEqualToString:@"无"]) {
        [params setObject:number forKey:@"number"];
    }
    if (![type isEqualToString:@"无"]) {
        [params setObject:type forKey:@"type"];
    }
    if (![startTime isEqualToString:@"无"]) {
        [params setObject:startTime forKey:@"startTime"];
    }
    if (![endTime isEqualToString:@"无"]) {
        [params setObject:endTime forKey:@"endTime"];
    }
    if (![startCode isEqualToString:@"无"]) {
        [params setObject:startCode forKey:@"startCode"];
    }
    if (![startName isEqualToString:@"无"]) {
        [params setObject:startName forKey:@"startName"];
    }
    [params setObject:page forKey:@"page"];
    [params setObject:linage forKey:@"linage"];
    
    [BaseWebUtils postRequestWithURL:cardTransferList paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }else{
            callBack(obj);
        }
    }];
}

//充值查询
+ (void)requestRechargeListWithNumber:(NSString *)number andRechargeType:(NSString *)rechargeType andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andPage:(NSString *)page andLinage:(NSString *)linage andCallBack:(WebUtilsCallBack1)callBack{
    
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken]} mutableCopy];
    if (![number isEqualToString:@"无"]) {
        [params setObject:number forKey:@"number"];
    }
    if (![rechargeType isEqualToString:@"无"]) {
        [params setObject:rechargeType forKey:@"rechargeType"];
    }
    if (![startTime isEqualToString:@"无"]) {
        [params setObject:startTime forKey:@"startTime"];
    }
    if (![endTime isEqualToString:@"无"]) {
        [params setObject:endTime forKey:@"endTime"];
    }
    
    [params setObject:page forKey:@"page"];
    [params setObject:linage forKey:@"linage"];
    
    [BaseWebUtils postRequestWithURL:rechargeList paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }else{
            callBack(obj);
        }
    }];
}
//开户详情  (成卡开户／白卡开户)
+ (void)requestOrderDetailWithOrderNo:(NSString *)orderNo andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"orderNo":orderNo} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:openOrderInfo paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }else{
            callBack(obj);
        }
    }];
}
//过户详情
+ (void)requestTransferDetailWithId:(NSString *)orderId andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"id":orderId} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:transferOrderInfo paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }else{
            callBack(obj);
        }
    }];
}

//根据订单编号得到----补卡详情
+ (void)requestCardTransferDetailWithId:(NSString *)cardId andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"id":cardId} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:remakecardOrderInfo paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }else{
            callBack(obj);
        }
    }];
}

//账户管理------------------------------
//账户余额查询
+ (void)requestAccountMoneyWithCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken]} mutableCopy];//得到parameter
    [BaseWebUtils postRequestWithURL:balanceQuery paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//账户充值－预订单（就是需要微信支付或者支付宝支付的）
+ (void)requestReAddRechargeRecordWithNumber:(NSString *)number andMoney:(NSString *)money andRechargeMethod:(NSString *)method andCallBack:(WebUtilsCallBack1)callBack{
    
    NSMutableDictionary *params = [@{@"session_token":[Utils getSessionToken],@"money":money,@"rechargeMethod":method} mutableCopy];//得到parameter
    if (![number isEqualToString:@"无"]) {
        [params setObject:number forKey:@"number"];
    }
    [BaseWebUtils postRequestWithURL:@"/agency_reAddRechargeRecord" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//卡片管理-------------------------------
//过户信息提交
+ (void)requestTransferInfoWithDic:(NSDictionary *)dic andCallBack:(WebUtilsCallBack1)callBack{
    
    
    /*----------图片上传-------------*/
    NSMutableDictionary *imageParamsDic = [NSMutableDictionary dictionary];//得到parameter
    [imageParamsDic setObject:[Utils getSessionToken] forKey:@"session_token"];
    [imageParamsDic setObject:@"2" forKey:@"type"];
    
    NSString *photoString = [Utils MydictionaryToJSON:imageParamsDic];
    photoString = [photoString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *app_sign_photo = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,photoString,app_pwd]];
    
    NSMutableDictionary *imageLoadParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign_photo} mutableCopy];
    
    NSMutableDictionary *photoDic = [NSMutableDictionary dictionary];
    [photoDic setObject:[dic objectForKey:@"photoOne"] forKey:@"photo1"];
    [photoDic setObject:[dic objectForKey:@"photoTwo"] forKey:@"photo2"];
    [photoDic setObject:[dic objectForKey:@"photoThree"] forKey:@"photo3"];
    [photoDic setObject:[dic objectForKey:@"photoFour"] forKey:@"photo4"];
    
    
    [imageLoadParams setObject:photoDic forKey:@"photo"];
    
    [imageLoadParams setObject:imageParamsDic forKey:@"parameter"];
    
    [BaseWebUtils postImageRequestWithParamters:imageLoadParams finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                
                
                NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
                [params setObject:[dic objectForKey:@"number"] forKey:@"number"];
                [params setObject:[dic objectForKey:@"name"] forKey:@"name"];
                [params setObject:[dic objectForKey:@"cardId"] forKey:@"cardId"];
                [params setObject:[dic objectForKey:@"tel"] forKey:@"tel"];
                [params setObject:[dic objectForKey:@"address"] forKey:@"address"];
                
                [params setObject:obj[@"data"][@"photo1"] forKey:@"photoOne"];
                [params setObject:obj[@"data"][@"photo2"] forKey:@"photoTwo"];
                [params setObject:obj[@"data"][@"photo3"] forKey:@"photoThree"];
                [params setObject:obj[@"data"][@"photo4"] forKey:@"photoFour"];

                [params setObject:[Utils getSessionToken] forKey:@"session_token"];
                [BaseWebUtils postRequestWithURL:transferInfo paramters:params finshedBlock:^(id obj) {
                    callBack(obj);
                }];
                
            }else{
                callBack(obj);
            }
        }
        }else{
            callBack(obj);
        }
    }];
    /*----------图片上传-------------*/
}

//补卡信息提交
+ (void)requestRepairInfoWithDic:(NSDictionary *)dic andCallBack:(WebUtilsCallBack1)callBack{
//    NSMutableDictionary *params = [dic mutableCopy];//得到parameter
    
    
    /*----------图片上传-------------*/
    NSMutableDictionary *imageParamsDic = [NSMutableDictionary dictionary];//得到parameter
    [imageParamsDic setObject:[Utils getSessionToken] forKey:@"session_token"];
    [imageParamsDic setObject:@"3" forKey:@"type"];
    
    NSString *photoString = [Utils MydictionaryToJSON:imageParamsDic];
    photoString = [photoString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *app_sign_photo = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,photoString,app_pwd]];
    
    NSMutableDictionary *imageLoadParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign_photo} mutableCopy];
    
    NSMutableDictionary *photoDic = [NSMutableDictionary dictionary];
    [photoDic setObject:[dic objectForKey:@"photo"] forKey:@"photo1"];
    
    [imageLoadParams setObject:photoDic forKey:@"photo"];
    
    [imageLoadParams setObject:imageParamsDic forKey:@"parameter"];
    
    [BaseWebUtils postImageRequestWithParamters:imageLoadParams finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
        

        if (obj) {
            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
            if ([code isEqualToString:@"10000"]) {
                
                NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
                [params setObject:[dic objectForKey:@"number"] forKey:@"number"];
                [params setObject:[dic objectForKey:@"name"] forKey:@"name"];
                [params setObject:[dic objectForKey:@"cardId"] forKey:@"cardId"];
                [params setObject:[dic objectForKey:@"tel"] forKey:@"tel"];
                [params setObject:[dic objectForKey:@"address"] forKey:@"address"];
                [params setObject:[dic objectForKey:@"receiveName"] forKey:@"receiveName"];
                [params setObject:[dic objectForKey:@"mailingAddress"] forKey:@"mailingAddress"];
                [params setObject:[dic objectForKey:@"mailMethod"] forKey:@"mailMethod"];
                [params setObject:[dic objectForKey:@"numOne"] forKey:@"numOne"];
                [params setObject:[dic objectForKey:@"receiveTel"] forKey:@"receiveTel"];
                [params setObject:obj[@"data"][@"photo1"] forKey:@"photo"];
                [params setObject:[Utils getSessionToken] forKey:@"session_token"];
                [BaseWebUtils postRequestWithURL:repairInfo paramters:params finshedBlock:^(id obj) {
                    callBack(obj);
                }];
            }else{
                callBack(obj);
            }
        }
        }else{
            callBack(obj);
        }
        
    }];
    /*----------图片上传-------------*/
    
}

//渠道商管理
+ (void)requestChannelListWithPage:(int)page andLinage:(int)linage andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
    NSNumber *pageNum = [NSNumber numberWithInt:page];
    NSNumber *linageNum = [NSNumber numberWithInt:linage];
    [params setObject:[Utils getSessionToken] forKey:@"session_token"];
    [params setObject:pageNum forKey:@"page"];
    [params setObject:linageNum forKey:@"linage"];
    [BaseWebUtils postRequestWithURL:@"/agency_channelsList" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }else{
            callBack(obj);
        }
    }];
}

//订单记录
+ (void)requestOrderListWithOrgCode:(NSString *)orgCode andMonthCount:(NSString *)count andPage:(int)page andLinage:(int)linage andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSNumber *pageNum = [NSNumber numberWithInt:page];
    NSNumber *linageNum = [NSNumber numberWithInt:linage];
    [params setObject:[Utils getSessionToken] forKey:@"session_token"];
    [params setObject:pageNum forKey:@"page"];
    [params setObject:linageNum forKey:@"linage"];
    
    if (![orgCode isEqualToString:@"无"]) {
        [params setObject:orgCode forKey:@"orgCode"];
    }
    
    if (![count isEqualToString:@"无"]) {
        [params setObject:count forKey:@"openTime"];
    }
    
    [BaseWebUtils postRequestWithURL:@"/agency_channelsOpenCount" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }else{
            callBack(obj);
        }
    }];
}

//话费余额查询
+ (void)requestPhoneNumberMoneyWithNumber:(NSString *)number andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
    [params setObject:number forKey:@"number"];
    [params setObject:[Utils getSessionToken] forKey:@"session_token"];
    [BaseWebUtils postRequestWithURL:@"/agency_queryBalance" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//接口44  登陆时验证是否是话机世界手机号
+ (void)requestIsHJSJNumberWithNumber:(NSString *)number andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
    [params setObject:number forKey:@"number"];
    [BaseWebUtils postRequestWithURL:@"/agency_numberCheck" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//关于我们
+ (void)requestAboutUsWithCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
    [params setObject:[Utils getSessionToken] forKey:@"session_token"];
    [BaseWebUtils postRequestWithURL:@"/agency_introduction" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//充值优惠
+ (void)requestDiscountInfoWithCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
    [params setObject:[Utils getSessionToken] forKey:@"session_token"];
    [BaseWebUtils postRequestWithURL:@"/agency_rechargeDiscount" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//是否有支付密码
+ (void)requestHasPayPasswordWithCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
    [params setObject:[Utils getSessionToken] forKey:@"session_token"];
    [BaseWebUtils postRequestWithURL:@"/agency_initialPsdCheck" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

//话费充值其他金额优惠信息
+ (void)requestOtherRechargeDiscountWithMoney:(NSString *)money andCallBack:(WebUtilsCallBack1)callBack{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//得到parameter
    [params setObject:[Utils getSessionToken] forKey:@"session_token"];
    [params setObject:money forKey:@"actualAmount"];
    [BaseWebUtils postRequestWithURL:@"/agency_otherRechargeDiscount" paramters:params finshedBlock:^(id obj) {
        if ([Utils logoutAction:obj[@"code"]] == YES) {
            callBack(obj);
        }
    }];
}

@end
