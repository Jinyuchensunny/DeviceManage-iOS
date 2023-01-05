//
//  DeviceTableViewCell.h
//  DeviceManage
//
//  Created by sjl on 2019/12/1.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Device.h"

@interface DeviceTableViewCell : UITableViewCell

//用于显示设备对象的图片
@property (nonatomic,strong) UIImageView *deviceImg;
//用于显示设备对象的名称
@property (nonatomic,strong) UILabel *deviceNameLab;
//用于显示设备对象的价格
@property (nonatomic,strong) UILabel *devicePriceLab;
//将设备对象model的各个属性值显示在各个控件上
-(void)setUpCell:(Device *)model;

@end
