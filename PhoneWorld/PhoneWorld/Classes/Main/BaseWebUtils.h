//
//  BaseWebUtils.h
//  LivePlay
//
//  Created by 刘岑颖 on 16/9/16.
//  Copyright © 2016年 刘岑颖. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BaseWebUtilsCallBack)(id obj);

@interface BaseWebUtils : NSObject

+ (void)POST:(NSString *)path andParams:(NSString *)params andCallBack:(BaseWebUtilsCallBack)callBack;

+ (void)POSTWithPath:(NSString *)path andParams:(NSString *)params andCallBack:(BaseWebUtilsCallBack)callBack;

+ (void)postSynRequestWithURL:(NSString *)urlStr
                    paramters:(NSDictionary  *)paramtersDic
                 finshedBlock:(WebUtilsCallBack1)block;

@end
