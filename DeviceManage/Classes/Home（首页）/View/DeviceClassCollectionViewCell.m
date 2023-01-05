//
//  DeviceClassCollectionViewCell.m
//  DeviceManage
//
//  Created by sjl on 2019/12/1.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "DeviceClassCollectionViewCell.h"

//1.设备分类图片控件的Rect信息
//图片控件的窗口宽度WindowWidth：屏幕宽度范围内放3个设备分类图片控件
#define WindowWidth ScreenWidth/3
//图片长和宽都为50
#define DeviceClassImgWidth 50
#define DeviceClassImgHeight 50
//图片的左上角x坐标
#define DeviceClassImgX (WindowWidth-DeviceClassImgWidth)/2
//图片的左上角y坐标
#define DeviceClassImgY 5

//2.设备分类文本控件的Rect信息
//文本控件的窗口宽度WindowWidth：屏幕宽度范围内放3个设备分类图片控件
#define WindowWidth ScreenWidth/3
#define DeviceClassLabWidth WindowWidth
#define DeviceClassLabHeight 20
#define DeviceClassLabX 0
#define DeviceClassLabY 60



@implementation DeviceClassCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //1. 设置cell视图背景为白色
        self.backgroundColor=[UIColor whiteColor];
        //2. 给deviceClassImg控件属性创建对象
        _deviceClassImg=[[UIImageView alloc]initWithFrame:CGRectMake(DeviceClassImgX,DeviceClassImgY,DeviceClassImgWidth,DeviceClassImgHeight)];
        _deviceClassImg.image=[UIImage imageNamed:@"office"];
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:_deviceClassImg];
        //3. 给deviceClassNameLab控件属性创建对象
        _deviceClassNameLab = [[UILabel alloc] initWithFrame:CGRectMake(DeviceClassLabX,DeviceClassLabY,DeviceClassLabWidth, DeviceClassLabHeight)];
        _deviceClassNameLab.font =[UIFont systemFontOfSize:15];
        _deviceClassNameLab.text=@"办公设备";
        _deviceClassNameLab.textColor = UIColor.blackColor;
        _deviceClassNameLab.textAlignment=NSTextAlignmentCenter;
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:_deviceClassNameLab];
    }
    return self;
}

-(void)setUpCell:(DeviceClass *)model{
    //根据model.DeviceClassID，设置deviceClassImg控件的image属性，显示设备分类图片
    NSInteger deviceClassId=[model.DeviceClassID integerValue];
    switch (deviceClassId) {
        case 1:
            _deviceClassImg.image=[UIImage imageNamed:@"office"];
            break;
        case 2:
            _deviceClassImg.image=[UIImage imageNamed:@"live"];
            break;
        case 3:
            _deviceClassImg.image=[UIImage imageNamed:@"study"];
            break;
        case 4:
            _deviceClassImg.image=[UIImage imageNamed:@"outdoor"];
            break;
        case 5:
            _deviceClassImg.image=[UIImage imageNamed:@"elecdevice"];
            break;
        case 6:
            _deviceClassImg.image=[UIImage imageNamed:@"other"];
            break;
        default:
            break;
    }
    //根据model.DeviceClassName，设置deviceClassNameLab控件的text属性，显示设备分类名称
    _deviceClassNameLab.text=model.DeviceClassName;
}



@end
