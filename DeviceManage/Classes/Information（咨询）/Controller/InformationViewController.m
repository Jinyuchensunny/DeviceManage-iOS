//
//  InformationViewController.m
//  DeviceManage
//
//  Created by sjl on 2019/11/25.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "InformationViewController.h"

//定义视图控件尺寸
//1. 咨询表格控件的高度为屏幕高度-导航条和状态条高度
//2. 设备表格控件中单元格的高度为屏幕高度的1/7
#define UITableViewViewHeight ScreenHeight-getRectNavAndStatusHight
#define UITableViewViewCellHeight ScreenHeight/7

@interface InformationViewController ()

@end

@implementation InformationViewController{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(instancetype)init{
    if (self = [super init]) {
        self.title=@"咨询";
        self.tabBarItem.image = [UIImage imageNamed:@"information_tabBar"];
        self.hidesBottomBarWhenPushed = false;
    }
    return self;
}

//懒加载表格视图控件属性informationTableView
-(UITableView *)informationTableView{
    if (!_informationTableView) {
        _informationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth,UITableViewViewHeight) style:UITableViewStyleGrouped];
        _informationTableView.backgroundColor =UIColor.whiteColor;
        //代理设置
        _informationTableView.delegate = self;
        _informationTableView.dataSource = self;
    }
    return _informationTableView;
}

//获取所有咨询
-(void)findAllInformation{
    //显示转圈圈控件
    [SVProgressHUD show];
    // 初始化参数
    //执行网络访问请求
    [[NetworkTool shareInstance]requireMethodType:POSTType URLString:@"findAllInformation" Parameters:nil Success:^(NSDictionary *respondDictionary) {
        _informationArray = [[NSMutableArray alloc] init];
        // 1.JSON转换为模型
        for (NSDictionary *dic in respondDictionary[@"result"]) {
            Information *model = [[Information alloc]initWithDictionary:dic error:nil];
            [_informationArray addObject:model];
        }
        [_informationTableView reloadData];
        [SVProgressHUD dismiss];
        
    } Failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取失败"];
    }];
}

//将1个视图控件都加入到self.view中，显示这个控件
-(void)setUpView{
    //将表格视图控件变量informationTableView加入到self.view中进行显示
    [self.view addSubview:self.informationTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _informationArray=[NSMutableArray array];
    [self findAllInformation];
    [self setUpView];
}

#pragma mark --实现UITableDataSource协议

//定义表格视图中Section的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//定义表格视图中每节中的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_informationArray count];
}

//定义每个单元格（即某节某行）展示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InformationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[InformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Information *model = _informationArray[indexPath.row];
    [cell setUpCell:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewViewCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //新建咨询详情的视图控制器对象
    InformationDetailViewController *informationVC=[[InformationDetailViewController alloc]init];
    //取出当前选中的咨询对象，将其赋值给控制器的model属性
    informationVC.model=_informationArray[indexPath.row];
    //通过导航控制器，从当前界面跳转到咨询详情视图控制器界面
    [self.navigationController pushViewController:informationVC animated:YES];
}



@end
