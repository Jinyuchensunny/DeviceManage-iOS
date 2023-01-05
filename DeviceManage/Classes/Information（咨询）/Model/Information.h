//
//  Information.h
//  DeviceManage
//
//  Created by sjl on 2019/11/20.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Information : JSONModel

@property NSString* InformationID;
@property NSString* InformationContent;
@property NSString* InformationImage;
@property NSString* InformationCreateTime;


@end
