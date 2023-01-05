//
//  InformationTableViewCell.h
//  DeviceManage
//
//  Created by sjl on 2019/12/5.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Information.h"

@interface InformationTableViewCell : UITableViewCell
//用于显示咨询对象的标题图片
@property (nonatomic,strong) UIImageView *informationTitleImg;
//用于显示咨询对象的标题
@property (nonatomic,strong) UILabel *informationTitleLab;
//用于显示咨询对象的创建时间
@property (nonatomic,strong) UILabel *informationCreateTimeLab;
//将咨询对象model的各个属性值显示在各个控件上
-(void)setUpCell:(Information *)model;
@end
