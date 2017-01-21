//
//  CheckAndTopViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/12.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CheckAndTopViewController.h"
#import "CheckAndTopView.h"
#import "TopResultViewController.h"
#import "FailedView.h"


#import "payRequsestHandler.h"
#import "WXApiRequestHandler.h"
#import "WXApi.h"


#import "AppDelegate.h"

//支付宝支付
#define appScheme @"a2016111602862870"

@interface CheckAndTopViewController ()<WXApiManagerDelegate>{
    enum WXScene _scene;
    NSString *Token;
    long token_time;
}
@property (nonatomic) CheckAndTopView *checkAndTopView;

@property (nonatomic) FailedView *processView;

@property (nonatomic) NSMutableArray *resultArray;

@end

@implementation CheckAndTopViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户查询与充值";
    self.resultArray = [NSMutableArray array];
    self.checkAndTopView = [[CheckAndTopView alloc] init];
    [self.view addSubview:self.checkAndTopView];
    [self.checkAndTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    __block __weak CheckAndTopViewController *weakself = self;
    
    [WXApiManager sharedManager].delegate = self;

    
    [self.checkAndTopView setCheckAndTopCallBack:^(NSString *money, payWay payway) {
        CGFloat moneyInt = money.floatValue;
        if (moneyInt == 0.00) {
            [Utils toastview:@"请输入充值金额"];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.processView = [[FailedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andTitle:@"正在支付" andDetail:@"请稍候..." andImageName:@"icon_smile" andTextColorHex:@"#eb000c"];
                [[UIApplication sharedApplication].keyWindow addSubview:weakself.processView];
            });
            
            if (payway == weixinPay || payway == aliPay) {
                
                
                
//                NSLog(@"-------------充值金额%@   充值方式%lu",money,(unsigned long)payway);
                NSString *payWayString = @"1";
                if (payway == weixinPay) {
                    payWayString = @"0";
                    //微信支付
                    
                    
                    
//                    NSString *res = [WXApiRequestHandler jumpToBizPay];
//                    NSLog(@"-------res : %@--------",res);
                    
                    [weakself wxpay];
                    
                    
                    
                }else{
                    //支付宝支付
                    
                    
                    weakself.resultArray = [NSMutableArray array];
                    
                    [WebUtils requestReAddRechargeRecordWithNumber:@"无" andMoney:money andRechargeMethod:payWayString andCallBack:^(id obj) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakself.resultArray addObject:obj[@"data"][@"orderNo"]];
                            
                            NSDate *currentDate = [NSDate date];
                            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                            [dateformatter setDateFormat:@"YYYY-MM-dd"];
                            
                            NSString *locationString=[dateformatter stringFromDate:currentDate];
                            
                            [weakself.resultArray addObject:locationString];
                            
                            [weakself.resultArray addObject:@"余额充值"];
                            
                            [weakself.resultArray addObject:money];
                            
                            [weakself.resultArray addObject:@"当前账户"];
                            
                            [weakself.processView removeFromSuperview];
                        });
                        
                        if (obj) {
                            NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
                            if ([code isEqualToString:@"10000"]) {
                                NSString *orderString = [NSString stringWithFormat:@"%@",obj[@"data"][@"request"]];
                                
//                                 NOTE: 调用支付结果开始支付
                                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                                    
//                                    NSLog(@"reslut = %@",resultDic);
                                    
                                }];
                                
                                
                                AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                [app setAppCallBack:^(BOOL result) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        TopResultViewController *vc = [[TopResultViewController alloc] init];
                                        
                                        if (result == YES) {
//                                            [weakself.resultArray addObject:@"支付成功！"];
                                            vc.isSucceed = YES;
                                        }else{
                                            [weakself.resultArray addObject:@"支付失败！请重新尝试！"];
                                            vc.isSucceed = NO;
                                        }
                                        
                                        vc.allResults = weakself.resultArray;
                                        [weakself.navigationController pushViewController:vc animated:YES];
                                    });
                                }];
                                
                                
                            }else{
                                NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [Utils toastview:mes];
                                });
                            }
                        }
                    }];
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                /*
                 
                 
                 
                 支付操作
                 
                 
                 
                 */
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
//                [WebUtils requestReAddRechargeRecordWithNumber:@"无" andMoney:money andRechargeMethod:payWayString andCallBack:^(id obj) {
//                    if (obj) {
//                        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
//                        if ([code isEqualToString:@"10000"]) {
//                    
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                /*--------跳转到充值结果页面--------*/
//                                TopResultViewController *vc = [TopResultViewController new];
//                                vc.isSucceed = YES;
//                                [weakself.navigationController pushViewController:vc animated:YES];
//                            });
//                            
//                        }else{
//                            NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [Utils toastview:mes];
//                            });
//                        }
//                    }
//                }];

                
                
                
                
                
                
                
                
                
                
                
                
                
            }else{
                [Utils toastview:@"请选择充值方式"];
            }
        }
    }];
    
    [self requestAccountMoney];
    
}

- (void)requestAccountMoney{
    __block __weak CheckAndTopViewController *weakself = self;
    [WebUtils requestAccountMoneyWithCallBack:^(id obj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat money = [[NSString stringWithFormat:@"%@",obj[@"data"][@"balance"]] floatValue];
            weakself.checkAndTopView.accountMoneyInputView.textField.text = [NSString stringWithFormat:@"%.2f元",money];
        });
    }];
}



//微信支付
- (void)wxpay
{
    //商户号
    NSString *PARTNER_ID    = @"1347660601";//
    //商户密钥
    NSString *PARTNER_KEY   = @"20e4c993640d97f141c7e2b8e0b530c4";//
    //APPID
    NSString *APPI_ID       = @"wxf52ad75c5c060b9e";//
    //appsecret
    NSString *APP_SECRET	= @"b921b9e82de85cc1a6f523b7b4018375";//
    //支付密钥
    NSString *APP_KEY       = @"20e4c993640d97f141c7e2b8e0b530c4";
    
    //支付结果回调页面
    NSString *NOTIFY_URL    = @"http://www.baidu.com";
    //订单标题
    NSString *ORDER_NAME    = @"Ios客户端签名支付 测试";
    //订单金额,单位（分）
    NSString *ORDER_PRICE   = @"1";
    
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:APPI_ID app_secret:APP_SECRET partner_key:PARTNER_KEY app_key:APP_KEY];
    
    //判断Token过期时间，10分钟内不重复获取,测试帐号多个使用，可能造成其他地方获取后不能用，需要即时获取
    time_t  now;
    time(&now);
    //if ( (now - token_time) > 0 )//非测试帐号调试请启用该条件判断
    {
        //获取Token
        Token                   = [req GetToken];
        //设置Token有效期为10分钟
        token_time              = now + 600;
        //日志输出
        NSLog(@"获取Token： %@\n",[req getDebugifo]);
    }
    if ( Token != nil){
        //================================
        //预付单参数订单设置
        //================================
        NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
        [packageParams setObject: @"WX"                                             forKey:@"bank_type"];
        [packageParams setObject: ORDER_NAME                                        forKey:@"body"];
        [packageParams setObject: @"1"                                              forKey:@"fee_type"];
        [packageParams setObject: @"UTF-8"                                          forKey:@"input_charset"];
        [packageParams setObject: NOTIFY_URL                                        forKey:@"notify_url"];
        [packageParams setObject: [NSString stringWithFormat:@"%ld",time(0)]        forKey:@"out_trade_no"];
        [packageParams setObject: PARTNER_ID                                        forKey:@"partner"];
        [packageParams setObject: @"196.168.1.1"                                    forKey:@"spbill_create_ip"];
        [packageParams setObject: ORDER_PRICE                                       forKey:@"total_fee"];
        
        NSString    *package, *time_stamp, *nonce_str, *traceid;
        //获取package包
        package		= [req genPackage:packageParams];
        
        //输出debug info
        NSString *debug     = [req getDebugifo];
        NSLog(@"gen package: %@\n",package);
        NSLog(@"生成package: %@\n",debug);
        
        //设置支付参数
        time_stamp  = [NSString stringWithFormat:@"%ld", now];
        nonce_str	= [TenpayUtil md5:time_stamp];
        traceid		= @"mytestid_001";
        NSMutableDictionary *prePayParams = [NSMutableDictionary dictionary];
        [prePayParams setObject: APPI_ID                                            forKey:@"appid"];
        [prePayParams setObject: APP_KEY                                            forKey:@"appkey"];
        [prePayParams setObject: nonce_str                                          forKey:@"noncestr"];
        [prePayParams setObject: package                                            forKey:@"package"];
        [prePayParams setObject: time_stamp                                         forKey:@"timestamp"];
        [prePayParams setObject: traceid                                            forKey:@"traceid"];
        
        //生成支付签名
        NSString    *sign;
        sign		= [req createSHA1Sign:prePayParams];
        //增加非参与签名的额外参数
        [prePayParams setObject: @"sha1"                                            forKey:@"sign_method"];
        [prePayParams setObject: sign                                               forKey:@"app_signature"];
        
        //获取prepayId
        NSString *prePayid;
        prePayid            = [req sendPrepay:prePayParams];
        //输出debug info
        debug               = [req getDebugifo];
        NSLog(@"提交预付单： %@\n",debug);
        
        if ( prePayid != nil) {
            //重新按提交格式组包，微信客户端5.0.3以前版本只支持package=Sign=***格式，须考虑升级后支持携带package具体参数的情况
            //package       = [NSString stringWithFormat:@"Sign=%@",package];
            package         = @"Sign=WXPay";
            //签名参数列表
            NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
            [signParams setObject: APPI_ID                                          forKey:@"appid"];
            [signParams setObject: APP_KEY                                          forKey:@"appkey"];
            [signParams setObject: nonce_str                                        forKey:@"noncestr"];
            [signParams setObject: package                                          forKey:@"package"];
            [signParams setObject: PARTNER_ID                                       forKey:@"partnerid"];
            [signParams setObject: time_stamp                                       forKey:@"timestamp"];
            [signParams setObject: prePayid                                         forKey:@"prepayid"];
            
            //生成签名
            sign		= [req createSHA1Sign:signParams];
            
            //输出debug info
            debug     = [req getDebugifo];
            NSLog(@"调起支付签名： %@\n",debug);
            
            //调起微信支付
            PayReq* req = [[PayReq alloc] init];
            req.openID      = APPI_ID;
            req.partnerId   = PARTNER_ID;
            req.prepayId    = prePayid;
            req.nonceStr    = nonce_str;
            req.timeStamp   = now;
            req.package     = package;
            req.sign        = sign;
            [WXApi sendReq:req];
        }else{
            /*long errcode = [req getLasterrCode];
             if ( errcode == 40001 )
             {//Token实效，重新获取
             Token                   = [req GetToken];
             token_time              = now + 600;
             NSLog(@"获取Token： %@\n",[req getDebugifo]);
             };*/
            NSLog(@"获取prepayid失败\n");
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:debug preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [ac addAction:action1];
            [ac addAction:action2];
            [self presentViewController:ac animated:YES completion:nil];
        }
    }else{
        NSLog(@"获取Token失败\n");
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取token失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [ac addAction:action1];
        [ac addAction:action2];
        [self presentViewController:ac animated:YES completion:nil];
        
    }
    
}


@end
