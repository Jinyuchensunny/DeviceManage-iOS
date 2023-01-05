//
//  ShopingcartViewController.h
//  DeviceManage
//
//  Created by sjl on 2019/11/25.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopingCartTableViewCell.h"
#import "User.h"

@interface ShopingcartViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,ShopingCartTableViewCellDelegate>

@property (nonatomic,strong) UITableView *shopingCartTableView;   //购物车表格视图
@property (nonatomic,strong) NSMutableArray *dataArray;           //购物车表格内容数组
@property (nonatomic,strong) UIView *footView;        //底部视图
@property (nonatomic,strong) UIButton *allSelectBtn;    //全选按钮
@property (nonatomic,strong) UILabel *moneylabel;        //总价格标签
@property (nonatomic,strong) UIButton *payBtn;        //结账按钮


@end
















