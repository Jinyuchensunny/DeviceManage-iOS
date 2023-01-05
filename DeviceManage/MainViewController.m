//
//  MainViewController.m
//  DeviceManage
//
//  Created by sjl on 2019/11/25.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 将黑色背景改成白色背景
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupViewControllers{
    // 1.设置首页导航控制器
    HomeViewController *homeViewController=[[HomeViewController alloc]init];
    UINavigationController *homeNavi=[[UINavigationController alloc]initWithRootViewController:homeViewController];
    [self addChildViewController:homeNavi];
    
    // 2.设置咨询导航控制器
    InformationViewController *infoViewController=[[InformationViewController alloc]init];
    UINavigationController *infoNavi=[[UINavigationController alloc]initWithRootViewController:infoViewController];
    [self addChildViewController:infoNavi];
    
    // 3.设置购物车导航控制器
    ShopingcartViewController *shopingCartViewController = [[ShopingcartViewController alloc] init];
    UINavigationController *shopNavi = [[UINavigationController alloc] initWithRootViewController:shopingCartViewController];
    [self addChildViewController:shopNavi];
    
    // 4.设置我的导航控制器
    MineViewController *mineViewController = [[MineViewController alloc] init];
    UINavigationController *mineNavi = [[UINavigationController alloc] initWithRootViewController:mineViewController];
    [self addChildViewController:mineNavi];
}

-(instancetype)init{
    if (self=[super init]) {
        // 设置TabBar的4个视图控制器
        [self setupViewControllers];
    }
    return self;
}

@end
