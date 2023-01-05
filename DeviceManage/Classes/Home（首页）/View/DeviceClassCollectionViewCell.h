//
//  DeviceClassCollectionViewCell.h
//  DeviceManage
//
//  Created by sjl on 2019/12/1.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceClass.h"

@interface DeviceClassCollectionViewCell : UICollectionViewCell
//用于显示设备分类对象的图片
@property (nonatomic,strong) UIImageView *deviceClassImg;
//用于显示设备分类对象的名称
@property (nonatomic,strong) UILabel *deviceClassNameLab;
//将设备分类对象model的各个属性值显示在各个控件上
-(void)setUpCell:(DeviceClass *)model;

@end
