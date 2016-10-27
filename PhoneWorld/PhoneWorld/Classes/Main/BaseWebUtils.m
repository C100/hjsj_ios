//
//  BaseWebUtils.m
//  LivePlay
//
//  Created by 刘岑颖 on 16/9/16.
//  Copyright © 2016年 刘岑颖. All rights reserved.
//

#import "BaseWebUtils.h"
#import <AFHTTPSessionManager.h>

@implementation BaseWebUtils
+ (void)GET:(NSString *)path andParams:(NSDictionary *)params andCallBack:(BaseWebUtilsCallBack)callBack{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        callBack(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [Utils toastview:@"请求数据失败，请刷新重试！"];
    }];
}

+ (void)POST:(NSString *)path andParams:(NSDictionary *)params andCallBack:(BaseWebUtilsCallBack)callBack{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBack(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [Utils toastview:@"数据上传失败，请重新上传！"];
    }];
}

@end
