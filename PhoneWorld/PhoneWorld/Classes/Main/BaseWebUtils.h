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
//专为图片
+ (void)postImageRequestWithParamters:(NSDictionary  *)paramtersDic
                         finshedBlock:(WebUtilsCallBack1)block;

+ (void)postSynRequestWithURL:(NSString *)urlStr
                    paramters:(NSDictionary  *)paramtersDic
                 finshedBlock:(WebUtilsCallBack1)block;

+ (void)postRequestWithURL:(NSString *)urlStr
                 paramters:(NSDictionary  *)paramtersDic
              finshedBlock:(WebUtilsCallBack1)block;

@end
