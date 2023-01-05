//
//  InformationDetailViewController.h
//  DeviceManage
//
//  Created by sjl on 2019/12/7.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Information.h"

NS_ASSUME_NONNULL_BEGIN
@interface InformationDetailViewController : UIViewController <WKUIDelegate,WKNavigationDelegate>
//添加1个WKWebView控件变量
@property (nonatomic,strong) WKWebView *informationWV;
//添加1个数据模型
@property (nonatomic,strong) Information *model;

@end
NS_ASSUME_NONNULL_END
