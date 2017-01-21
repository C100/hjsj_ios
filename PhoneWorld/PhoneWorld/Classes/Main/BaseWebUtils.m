//
//  BaseWebUtils.m
//  LivePlay
//
//  Created by 刘岑颖 on 16/9/16.
//  Copyright © 2016年 刘岑颖. All rights reserved.
//

#import "BaseWebUtils.h"
#import <AFHTTPSessionManager.h>
#import "Utils.h"

#define app_key @"382C6A0C7A19D490"
#define app_pwd @"141997CD28D5547D"
#define app_keyMD5 [Utils md5String:app_key]
#define mainPath @"http://121.46.26.79:8080/newagency/AgencyInterface"

//79测试  224正式

@implementation BaseWebUtils
//专为图片
+ (void)postImageRequestWithParamters:(NSDictionary  *)paramtersDic
                 finshedBlock:(WebUtilsCallBack1)block
{
    NSString *path = [NSString stringWithFormat:@"%@/agency_pictureUpload",mainPath];
    NSURL * url = [NSURL URLWithString:path];
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSMutableString *paramestr = [[NSMutableString alloc]init];
    
    if (paramtersDic != nil) {
        [paramestr appendFormat:@"\"app_key\":\"%@\"",[paramtersDic objectForKey:@"app_key"]];
        [paramestr appendFormat:@",\"app_sign\":\"%@\"",[paramtersDic objectForKey:@"app_sign"]];
        
        NSString *string = [Utils MydictionaryToJSON:[paramtersDic objectForKey:@"parameter"]];
        [paramestr appendFormat:@",\"parameter\":%@",string];
        
        NSString *photoString = [Utils MydictionaryToJSON:[paramtersDic objectForKey:@"photo"]];

        
        [paramestr appendFormat:@",\"photo\":%@",photoString];
        
    }
    NSString * params = [NSString stringWithFormat:@"{%@}",paramestr];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    //6.根据会话对象创建一个Task(发送请求
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            //8.解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            block(dict);
        }
    }];
    //7.执行任务
    [dataTask resume];
}


/**
 * 同步请求数据
 */

+ (void)postSynRequestWithURL:(NSString *)urlStr
                    paramters:(NSDictionary  *)paramtersDic
                 finshedBlock:(WebUtilsCallBack1)block
{
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,urlStr];
    
    NSURL * url = [NSURL URLWithString:path];
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSMutableString *paramestr = [[NSMutableString alloc]init];
    
    if (paramtersDic != nil) {
        [paramestr appendFormat:@"\"app_key\":\"%@\"",[paramtersDic objectForKey:@"app_key"]];
        [paramestr appendFormat:@",\"app_sign\":\"%@\"",[paramtersDic objectForKey:@"app_sign"]];
        
        NSString *string = [Utils MydictionaryToJSON:[paramtersDic objectForKey:@"parameter"]];
        
        [paramestr appendFormat:@",\"parameter\":%@",string];
        
    }
    NSString * params = [NSString stringWithFormat:@"{%@}",paramestr];
        
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    //6.根据会话对象创建一个Task(发送请求
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            //8.解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            block(dict);
        }
    }];
    //7.执行任务
    [dataTask resume];
}

+ (void)postRequestWithURL:(NSString *)urlStr
                    paramters:(NSDictionary  *)paramtersDic
                 finshedBlock:(WebUtilsCallBack1)block
{
    
    NSString *paramsString = [Utils MydictionaryToJSON:paramtersDic];
    
    NSString *app_sign = [Utils md5String:[NSString stringWithFormat:@"%@%@%@",app_pwd,paramsString,app_pwd]];
    
    NSMutableDictionary *sendParams = [@{@"app_key":app_keyMD5,@"app_sign":app_sign,@"parameter":paramtersDic} mutableCopy];
    
    NSString *path = [NSString stringWithFormat:@"%@%@",mainPath,urlStr];
    
    NSURL * url = [NSURL URLWithString:path];
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSMutableString *paramestr = [[NSMutableString alloc]init];
    
    if (sendParams != nil) {        
        
        [paramestr appendFormat:@"\"app_key\":\"%@\"",[sendParams objectForKey:@"app_key"]];
        [paramestr appendFormat:@",\"app_sign\":\"%@\"",[sendParams objectForKey:@"app_sign"]];
        
        NSString *string = [Utils MydictionaryToJSON:[sendParams objectForKey:@"parameter"]];

        [paramestr appendFormat:@",\"parameter\":%@",string];
        
    }
    NSString *params = [NSString stringWithFormat:@"{%@}",paramestr];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    //6.根据会话对象创建一个Task(发送请求
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            //8.解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            block(dict);
        }
    }];
    //7.执行任务
    [dataTask resume];
}

@end
