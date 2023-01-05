//
//  User.h
//  DeviceManage
//
//  Created by sjl on 2019/11/20.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface User : JSONModel <NSCoding>

@property NSString* UserID;
@property NSString* UserName;
@property NSString* UserPassword;

+(instancetype)shareInstance;
// 检查是否已经登录过
- (BOOL) checkLogin;
// 退出登录
- (void) logout;


@end

