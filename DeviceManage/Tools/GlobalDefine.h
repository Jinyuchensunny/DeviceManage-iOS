//
//  GlobalDefine.h
//  DeviceManage
//
//  Created by sjl on 2019/11/20.
//  Copyright © 2019年 sjl. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

#define REAL_IPADDRESS @"192.168.1.104"
#define BASE_URL @"http://192.168.1.104:8080/DeviceManage/"

#import "NetworkTool.h"
#import "SVProgressHUD.h"
#import "Masonry.h"

// 获取屏幕高度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
// 获取屏幕宽度
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
// 获取导航栏+状态栏的高度
#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height
// 获取底部标签条控件Tabbar的高度
#define TABBAR_HEIGHT ((IS_IPHONE_X ||IS_IPHONE_XR || IS_IPHONE_XS_MAX) ? 83.0f : 49.0f)

// 苹果常用设备的尺寸
#define IS_IPHONE_4 (( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480) < DBL_EPSILON ))
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
#define IS_IPHONE_X ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )812 ) < DBL_EPSILON )
#define IS_IPHONE_XR ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )896 ) < DBL_EPSILON )
#define IS_IPHONE_XS_MAX ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )896 ) < DBL_EPSILON )
#endif
/* GlobalDefine_h */
