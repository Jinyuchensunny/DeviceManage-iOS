//
//  ShopingCartTableViewCell.m
//  DeviceManage
//
//  Created by sjl on 2020/1/25.
//  Copyright © 2020年 sjl. All rights reserved.
//

#import "ShopingCartTableViewCell.h"

@implementation ShopingCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//属性model的setter函数
-(void)setModel:(Shopingcart *)model{
    _model=model;
    //根据model.ChooseStatus，设置chooseBtn控件的image属性，显示是否购买设备
    if([_model.ChooseStatus isEqualToString:@"0"]){
        [_chooseBtn setImage:[UIImage imageNamed:@"choice"] forState:UIControlStateNormal];
        
    }else{
        [_chooseBtn setImage:[UIImage imageNamed:@"choiced"] forState:UIControlStateNormal];
    }
    //根据model.BuyNum，设置shoppingNumLab控件的text属性，显示购买数量
    _shoppingNumLab.text=model.BuyNum;
    //根据model.Device.DeviceName，设置deviceNameLab控件的text属性，显示设备名称
    _deviceNameLab.text=model.Device.DeviceName;
    //根据model.Device.DevicePrice，设置devicePriceLab控件的text属性，显示设备价格
    _devicePriceLab.text=model.Device.DevicePrice;
    //根据model.Device.DeviceID，设置deviceImg控件的image属性，显示设备图片
    NSInteger deviceId=[model.Device.DeviceID integerValue];
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

- (IBAction)chooseDevice:(id)sender {
    //点击按钮后，切换选中和未被选中的属性值
    if([_model.ChooseStatus isEqualToString:@"0"]){
        _model.ChooseStatus = @"1";
    }else{
        _model.ChooseStatus = @"0";
    }
    //通过Model刷新View中的控件值
    [self setModel:_model];
    //判断协议实现对象是否实现了howtochoose方法
    if([_delegate respondsToSelector:@selector(howtochange)]){
        [_delegate howtochoose];
    }
}

- (IBAction)subDevice:(id)sender {
    if([_model.BuyNum isEqualToString:@"0"]){
        [SVProgressHUD showInfoWithStatus:@"总数量不可少于0"];
        //2s后关闭提示
        [SVProgressHUD dismissWithDelay:2];
    }else{
        NSInteger buynum=[_model.BuyNum intValue];
        buynum--;
        _model.BuyNum=[NSString stringWithFormat:@"%ld",buynum];
    }
    //通过Model刷新View中的控件值
    [self setModel:_model];
    //判断协议实现对象是否实现了howtochange方法
    if([_delegate respondsToSelector:@selector(howtochange)]){
        [_delegate howtochange];
    }
}

- (IBAction)addDevice:(id)sender {
    NSInteger buynum=[_model.BuyNum intValue];
    buynum++;
    _model.BuyNum=[NSString stringWithFormat:@"%ld",buynum];
    //通过Model刷新View中的控件值
    [self setModel:_model];
    //判断协议实现对象是否实现了howtochange方法
    if([_delegate respondsToSelector:@selector(howtochange)]){
        [_delegate howtochange];
    }    
}
@end
