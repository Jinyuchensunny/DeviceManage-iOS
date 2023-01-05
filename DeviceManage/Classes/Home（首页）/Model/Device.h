//
//  Device.h
//  DeviceManage
//
//  Created by sjl on 2019/11/20.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Device : JSONModel

@property NSString* DeviceID;
@property NSString* DeviceClassId;
@property NSString* DeviceName;
@property NSString* DevicePrice;


@end
