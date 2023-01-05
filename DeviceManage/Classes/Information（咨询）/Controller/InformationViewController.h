//
//  InformationViewController.h
//  DeviceManage
//
//  Created by sjl on 2019/11/25.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationViewController.h"
#import "InformationTableViewCell.h"
#import "Information.h"
#import "InformationDetailViewController.h"


@interface InformationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
//添加1个视图控件变量
@property (nonatomic,strong) UITableView *informationTableView;
//添加1个数据源数组
@property (nonatomic,strong) NSMutableArray *informationArray;
@end
