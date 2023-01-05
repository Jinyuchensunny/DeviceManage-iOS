//
//  HomeViewController.h
//  DeviceManage
//
//  Created by sjl on 2019/11/25.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDCycleScrollView.h"
#import "DeviceClassCollectionViewCell.h"
#import "DeviceTableViewCell.h"
#import "DeviceClass.h"
#import "Device.h"

@interface HomeViewController : UIViewController <SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

//添加3个视图控件变量
@property (nonatomic,strong) SDCycleScrollView *bannerScrollView;
@property (nonatomic,strong) UICollectionView *deviceClassCollectionView;
@property (nonatomic,strong) UITableView *deviceTableView;
//添加2个数据源数组
@property (nonatomic,strong) NSMutableArray *deviceClassArray;
@property (nonatomic,strong) NSMutableArray *deviceArray;


@end
