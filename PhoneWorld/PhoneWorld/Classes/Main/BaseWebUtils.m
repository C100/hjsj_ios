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

@implementation BaseWebUtils

+ (void)POST:(NSString *)path andParams:(NSString *)params andCallBack:(BaseWebUtilsCallBack)callBack{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"~~~~~~~~~~~%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        callBack(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [Utils toastview:@"数据上传失败，请重新上传！"];
    }];
}

+ (void)POSTWithPath:(NSString *)path andParams:(NSString *)params andCallBack:(BaseWebUtilsCallBack)callBack{
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"又出错了！！！！sbsbsbs！！！！！");
        }else{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            callBack(dic);
        }
    }];
    [task resume];
}

/**
 * 同步请求数据
 */

+ (void)postSynRequestWithURL:(NSString *)urlStr
                    paramters:(NSDictionary  *)paramtersDic
                 finshedBlock:(WebUtilsCallBack1)block
{
    NSURL * url = [NSURL URLWithString:urlStr];
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSMutableString *paramestr = [[NSMutableString alloc]init];
    
    if (paramtersDic != nil) {
        NSArray*keyArr= [paramtersDic allKeys];
        for (int i = 0; i <keyArr.count; i++) {
            if (i==0) {
                [paramestr appendFormat:@"\"%@\":\"%@\"",keyArr[i],[paramtersDic objectForKey:keyArr[i]]];
            }else if(i != keyArr.count - 1){
                [paramestr appendFormat:@",\"%@\":\"%@\"",keyArr[i],[paramtersDic objectForKey:keyArr[i]]];
            }else if(i == keyArr.count - 1){
                NSString *string = [Utils MydictionaryToJSON:[paramtersDic objectForKey:keyArr[i]]];
                [paramestr appendFormat:@",\"%@\":%@",keyArr[i],string];
            }
        }
    }
    NSString * params = [NSString stringWithFormat:@"{%@}",paramestr];
    
    NSLog(@"=========params  %@===========",params);
    
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
