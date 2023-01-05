//
//  NetworkTool.m
//  DeviceManage
//
//  Created by sjl on 2019/11/20.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool

static NetworkTool* tool;
+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[NetworkTool alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html",
                                                          @"application/json",@"text/json", @"text/plain", @"text/javascript", nil];
    });
    return tool;
}

-(NSString *)getFullRequestURL:(NSString *)urlString {
    return [NSString stringWithFormat:@"%@%@", self.baseURL, urlString];
}

-(void)printNetworkLog:(MethodType)type URLString:(NSString *)urlString
            Parameters:(NSDictionary *)parameters {
    //请求类型字符串
    NSString *typeString = [[NSString alloc] init];
    typeString = type == GETType ? @"GET" : @"POST";
    //获得完整的URL请求地址
    NSString *fullURLString = [self getFullRequestURL:urlString];
    // 请求参数
    NSMutableString *parametersString = [[NSMutableString alloc] init];
    // 检查是否存在参数
    if (parameters){
        // 生成请求参数string
        for (NSString *key in [parameters allKeys]) {
            [parametersString appendFormat:@"%@=%@, ",key,parameters[key]];
        }
        // 删除最后的 ", " 两个字符
        [parametersString deleteCharactersInRange:NSMakeRange(
                                                              [parametersString length]-2, 2)];
    }
    NSString *requestStr = [NSString stringWithFormat:@"[%@] %@ {%@}",
                            typeString,fullURLString,parametersString];
    NSLog(@"%@",requestStr);
}

- (void)requireMethodType:(MethodType)type URLString:(NSString *)urlString
               Parameters:(NSDictionary *)myparameters Success:(SuccessBlock)mysuccess     Failure:(FailureBlock)myfailure{
    // 打印请求
    [self printNetworkLog:type URLString:urlString Parameters:myparameters];
    NSString *fullURL = [self getFullRequestURL:urlString];
    if(type==GETType){
        [self GET:urlString parameters:myparameters progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              //打印URL网址请求的内容responseObject
              NSLog(@"[URL:%@] response:%@",fullURL,responseObject);
              // 执行回调函数mysuccess，该函数将由调用者传入
              mysuccess(responseObject);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              //打印URL网址请求失败，显示失败原因
              NSLog(@"[URL:%@] error:%@",fullURL,error);
              // 执行回调函数myfailure，该函数将由调用者传入
              myfailure(error);
          }
         ];
    }else{
        [self POST:urlString parameters:myparameters progress:nil
           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               //打印URL网址请求的内容responseObject
               NSLog(@"[URL:%@] response:%@",fullURL,responseObject);
               // 执行回调函数mysuccess，该函数将由调用者传入
               mysuccess(responseObject);
           }
           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               //打印URL网址请求失败，显示失败原因
               NSLog(@"[URL:%@] error:%@",fullURL,error);
               // 执行回调函数myfailure，该函数将由调用者传入
               myfailure(error);
           }
         ];
    }
}




@end
