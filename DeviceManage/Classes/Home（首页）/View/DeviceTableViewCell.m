//
//  DeviceTableViewCell.m
//  DeviceManage
//
//  Created by sjl on 2019/12/1.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "DeviceTableViewCell.h"

//1. 设备图片控件的Rect信息
//图片长和宽都为80
#define DeviceImgWidth 80
#define DeviceImgHeight 80
//图片的左上角x坐标
#define DeviceImgX 10
//图片的左上角y坐标
#define DeviceImgY 10

//2. 设备名称Logo图片控件的Rect信息
//图片长和宽都为20
#define DeviceNameLogoImgWidth 20
#define DeviceNameLogoHeight 20
//图片的左上角x坐标
#define DeviceNameLogoImgX 95
//图片的左上角y坐标
#define DeviceNameLogoImgY 15

//3. 设备名称文本控件的Rect信息
//文本控件的宽度
#define DeviceNameLabWidth ScreenWidth/3
#define DeviceNameLabHeight 30
#define DeviceNameLabX 120
#define DeviceNameLabY 10

//4. 设备价格Logo图片控件的Rect信息
//图片长和宽都为20
#define DevicePriceLogoImgWidth 20
#define DevicePriceLogoImgHeight 20
//图片的左上角x坐标
#define DevicePriceLogoImgX 95
//图片的左上角y坐标
#define DevicePriceLogoImgY 65

//5. 设备价格文本控件的Rect信息
#define DevicePriceLabWidth ScreenWidth/3
#define DevicePriceLabHeight 30
#define DevicePriceLabX 120
#define DevicePriceLabY 60

@implementation DeviceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1. 设置cell视图背景为白色
        self.backgroundColor=UIColor.whiteColor;
        //2. 给deviceImg控件属性创建对象
        _deviceImg=[[UIImageView alloc]initWithFrame:
                    CGRectMake(DeviceImgX, DeviceImgY, DeviceImgWidth, DeviceImgHeight)];
        _deviceImg.image=[UIImage imageNamed:@"printer"];
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:_deviceImg];
        //3. 创建一个设备名称Logo图片，这张图片是不变的，所以不需要建立控件属性
        UIImageView *devicenameLogoImg=[[UIImageView alloc]initWithFrame:CGRectMake(DeviceNameLogoImgX, DeviceNameLogoImgY,DeviceNameLogoImgWidth, DeviceNameLogoHeight)];
        devicenameLogoImg.image=[UIImage imageNamed:@"devicenamelogo"];
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:devicenameLogoImg];
        //4. 给deviceNameLab控件属性创建对象
        _deviceNameLab = [[UILabel alloc] initWithFrame:
                          CGRectMake(DeviceNameLabX, DeviceNameLabY,
                                     DeviceNameLabWidth, DeviceNameLabHeight)];
        _deviceNameLab.font =[UIFont systemFontOfSize:17];
        _deviceNameLab.text=@"打印机";
        _deviceNameLab.textColor = UIColor.orangeColor;
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:_deviceNameLab];
        //5. 创建一个设备价格Logo图片，这张图片是不变的，所以不需要建立控件属性
        UIImageView *devicepriceLogoImg=[[UIImageView alloc]initWithFrame:CGRectMake(DevicePriceLogoImgX, DevicePriceLogoImgY,DevicePriceLogoImgWidth, DevicePriceLogoImgHeight)];
        devicepriceLogoImg.image=[UIImage imageNamed:@"devicepricelogo"];
        [self.contentView addSubview:devicepriceLogoImg];
        //6. 给devicePriceLab控件属性创建对象
        _devicePriceLab = [[UILabel alloc] initWithFrame:CGRectMake(DevicePriceLabX, DevicePriceLabY, DevicePriceLabWidth, DevicePriceLabHeight)];
        _devicePriceLab.font =[UIFont systemFontOfSize:17];
        _devicePriceLab.text=@"¥10000";
        _devicePriceLab.textColor = UIColor.blackColor;
        //加入到self.contentView视图（即cell视图）中，作为子视图
        [self.contentView addSubview:_devicePriceLab];
    }
    return self;
}

-(void)setUpCell:(Device *)model{
//根据model.DeviceName，设置deviceNameLab控件的text属性，显示设备名称
    _deviceNameLab.text=model.DeviceName;
//根据model.DevicePrice，设置devicePriceLab控件的text属性，显示设备价格
    _devicePriceLab.text=model.DevicePrice;
//根据model.DeviceID，设置deviceImg控件的image属性，显示设备图片
    NSInteger deviceId=[model.DeviceID integerValue];
    switch (deviceId) {
        case 1:
            _deviceImg.image=[UIImage imageNamed:@"printer"];
            break;
        case 2:
            _deviceImg.image=[UIImage imageNamed:@"earphone"];
            break;
        case 3:
            _deviceImg.image=[UIImage imageNamed:@"mouse"];
            break;
        case 4:
            _deviceImg.image=[UIImage imageNamed:@"computer"];
            break;
        case 5:
            _deviceImg.image=[UIImage imageNamed:@"udisk"];
            break;
        case 6:
            _deviceImg.image=[UIImage imageNamed:@"helmet"];
            break;
        default:
            break;
    }

}


@end
