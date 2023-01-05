//
//  NetworkTool.h
//  DeviceManage
//
//  Created by sjl on 2019/11/20.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

// 定义访问请求类型
typedef enum {
    GETType = 1,
    POSTType = 2
}MethodType;
// 定义访问请求成功和失败时的回调函数类型，即函数的类型
typedef void (^SuccessBlock)(NSDictionary *respondDictionary);
typedef void (^FailureBlock)(NSError *error);

@interface NetworkTool : AFHTTPSessionManager
// 返回单例对象
+(instancetype)shareInstance;
// 请求HTTP方法
-(void)requireMethodType:(MethodType)type
               URLString:(NSString *)urlString
              Parameters:(NSDictionary *)myparameters
                 Success:(SuccessBlock)mysuccess
                 Failure:(FailureBlock)myfailure;
@end

