//
//  Shopingcart.h
//  DeviceManage
//
//  Created by sjl on 2019/11/20.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Device.h"

@interface Shopingcart : JSONModel

@property NSString* ShopingcartID;
@property Device* Device;
@property NSString* BuyNum;
@property NSString* UserID;
//optional:防止由于服务器数据返回空导致JSONModel异常(程序崩溃)
@property NSString<Optional>* ChooseStatus;

@end
