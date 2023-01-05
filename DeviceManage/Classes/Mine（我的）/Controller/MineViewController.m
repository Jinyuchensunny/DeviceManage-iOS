//
//  MineViewController.m
//  DeviceManage
//
//  Created by sjl on 2019/11/25.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)init{
    if (self = [super init]) {
        self.title=@"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"mine_tabBar"];
        self.hidesBottomBarWhenPushed = false;
    }
    return self;
}
@end
