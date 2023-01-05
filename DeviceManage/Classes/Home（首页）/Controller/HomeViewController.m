//
//  HomeViewController.m
//  DeviceManage
//
//  Created by sjl on 2019/11/25.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "HomeViewController.h"

//定义视图控件尺寸
//1.轮播图控件的高度SDCycleScrollViewHeight为屏幕高度的1/3
//2.设备分类集合控件的高度为屏幕高度的1/4
//3.设备表格控件的高度为屏幕高度-导航条和状态条高度-轮播图控件高度-设备分类集合控件高度
//4.设备表格控件中单元格的高度为屏幕高度的1/7
//5.每一个设备分类项的高度为80
#define SDCycleScrollViewHeight ScreenHeight/3
#define UICollectionViewHeight ScreenHeight/4
#define UITableViewViewHeight ScreenHeight-getRectNavAndStatusHight-SDCycleScrollViewHeight-UICollectionViewHeight
#define UITableViewViewCellHeight ScreenHeight/7
#define CollectionCellHeight 80



@interface HomeViewController ()

@end

@implementation HomeViewController{
    NSString *deviceClassId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)init{
    if (self = [super init]) {
        self.title=@"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"home_tabBar"];
        self.hidesBottomBarWhenPushed = false;
    }
    return self;
}

//懒加载轮播图控件属性bannerScrollView
-(SDCycleScrollView *)bannerScrollView{
    if (!_bannerScrollView) {
        NSArray* bannerList=@[@"bannerimg1",@"bannerimg2",@"bannerimg3",
                                 @"bannerimg4",@"bannerimg5"];
        _bannerScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, getRectNavAndStatusHight, ScreenWidth, SDCycleScrollViewHeight) imageNamesGroup:bannerList];
        _bannerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        // 自定义分页控件小圆标颜色
        _bannerScrollView.currentPageDotColor = UIColor.whiteColor;
        _bannerScrollView.layer.masksToBounds=YES;
        _bannerScrollView.bannerImageViewContentMode =
        UIViewContentModeScaleAspectFill;
    }
    return _bannerScrollView;
}

//懒加载轮播图控件属性collectionView
-(UICollectionView *)deviceClassCollectionView{
    if(nil == _deviceClassCollectionView){
        //创建一个layout布局类
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //创建collectionView 通过一个布局策略layout来创建
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        //执行带2个参数的initWithFrame方法
        _deviceClassCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, getRectNavAndStatusHight+SDCycleScrollViewHeight, ScreenWidth, UICollectionViewHeight) collectionViewLayout:layout];
        _deviceClassCollectionView.backgroundColor = UIColor.whiteColor;
        _deviceClassCollectionView.scrollEnabled = NO;
        //代理设置
        _deviceClassCollectionView.delegate = self;
        _deviceClassCollectionView.dataSource = self;
    }
    return _deviceClassCollectionView;
}

//懒加载轮播图控件属性collectionView
-(UITableView *)deviceTableView{
    if(!_deviceTableView){
        _deviceTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,getRectNavAndStatusHight+SDCycleScrollViewHeight+UICollectionViewHeight, ScreenWidth,UITableViewViewHeight) style:UITableViewStyleGrouped];
        _deviceTableView.backgroundColor =UIColor.whiteColor;
        //代理设置
        _deviceTableView.delegate = self;
        _deviceTableView.dataSource = self;
    }
    return _deviceTableView;
}

//获取所有设备分类列表
-(void)getAllDeviceClass{
    [SVProgressHUD show];
    [[NetworkTool shareInstance] requireMethodType:POSTType URLString:@"findAllDeviceClass" Parameters:nil Success:^(NSDictionary *respondDictionary) {
        //1.给属性变量进行对象分配
        _deviceClassArray = [[NSMutableArray alloc] init];
        //2.利用JSONModel工具，提取服务器返回的result这个JSON字符串（它是字典数组变量），并将其转换为DeviceClass数组，即将JSON数组变量转换成DeviceClass数组变量_deviceClassArray
        for (NSDictionary *dic in respondDictionary[@"result"]) {
            //3.将每个字典对象转换成DeviceClass类对象model
            DeviceClass *model = [[DeviceClass alloc]initWithDictionary:dic error:nil];
            //4.将model加入到数组变量_deviceClassArray中
            [_deviceClassArray addObject:model];
        }
        //5.强制刷新集合视图控件，显示最新的设备分类列表
        [_deviceClassCollectionView reloadData];
        //6.关闭进度条
        [SVProgressHUD dismiss];
    } Failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取失败"];
    }];
}

//获取指定设备分类编号的设备列表
-(void)getAllDeviceByDeviceClassId{
    [SVProgressHUD show];
    // 初始化参数
    NSDictionary *params=@{@"deviceClassId":deviceClassId};
    //执行网络访问请求
    [[NetworkTool shareInstance]requireMethodType:POSTType
         URLString:@"findDeviceByDeviceClassId"
         Parameters:params
         Success:^(NSDictionary *respondDictionary) {
            //1.必须删除设备数组中现有的所有设备对象，否则当点击新的设备分类时，原有设备分类下的设备还存在
            [self.deviceArray removeAllObjects];
            //2.利用JSONModel工具，提取服务器返回的result这个JSON字符串（它是字典数组变量），并将其转换为Device数组，即将JSON数组变量转换成Device数组变量_deviceArray
            for (NSDictionary *dic in respondDictionary[@"result"]) {
                //3.将每个字典对象转换成Device类对象model
                Device *model = [[Device alloc]initWithDictionary:dic error:nil];
                //4.将model加入到数组变量_deviceArray中
                [_deviceArray addObject:model];
             }
             //5.强制刷新表格视图控件，显示最新的设备列表
             [_deviceTableView reloadData];
             //6.关闭进度条
             [SVProgressHUD dismiss];
          }
          Failure:^(NSError *error) {
             [SVProgressHUD dismiss];
             [SVProgressHUD showErrorWithStatus:@"获取失败"];
          }];
}

//将3个视图控件都加入到self.view中，显示这3个控件
-(void)setUpView{
    //将轮播图控件变量bannerScrollView加入到self.view中进行显示
    [self.view addSubview:self.bannerScrollView];
    //将集合视图控件变量collectionView加入到self.view中进行显示
    [self.view addSubview:self.deviceClassCollectionView];
    //集合视图控件变量collectionView注册单元类DeviceClassCollectionViewCell
    [self.deviceClassCollectionView registerClass:[DeviceClassCollectionViewCell class] forCellWithReuseIdentifier:@"DeviceClassCollectionViewCell"];
    //将表格视图控件变量deviceTableView加入到self.view中进行显示
    [self.view addSubview:self.deviceTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    deviceClassId=@"1";
    _deviceArray=[NSMutableArray array];
    [self getAllDeviceClass];
    [self getAllDeviceByDeviceClassId];
    [self setUpView];
}

#pragma mark --实现UICollectionViewDataSource协议
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_deviceClassArray count];
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DeviceClassCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DeviceClassCollectionViewCell" forIndexPath:indexPath];
    DeviceClass *model = _deviceClassArray[indexPath.row];
    [cell setUpCell:model];
    return cell;
}

#pragma mark --实现UICollectionViewDelegate协议
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DeviceClass *model=_deviceClassArray[indexPath.row];
    deviceClassId=model.DeviceClassID;
    [self getAllDeviceByDeviceClassId];
}

#pragma mark --实现UICollectionViewDelegateFlowLayout协议
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = ScreenWidth /3;
    return CGSizeMake(cellWidth, CollectionCellHeight);
}

#pragma mark --实现UITableDataSource协议
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//定义展示的行个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_deviceArray count];
}

//每行展示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[DeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Device *model = _deviceArray[indexPath.row];
    [cell setUpCell:model];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewViewCellHeight;
}

    


@end
