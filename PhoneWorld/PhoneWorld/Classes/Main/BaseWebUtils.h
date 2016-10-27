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

+ (void)GET:(NSString *)path andParams:(NSDictionary *)params andCallBack:(BaseWebUtilsCallBack)callBack;

+ (void)POST:(NSString *)path andParams:(NSDictionary *)params andCallBack:(BaseWebUtilsCallBack)callBack;

@end
