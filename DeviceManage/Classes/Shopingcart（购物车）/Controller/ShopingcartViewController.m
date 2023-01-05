//
//  ShopingcartViewController.m
//  DeviceManage
//
//  Created by sjl on 2019/11/25.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "ShopingcartViewController.h"

//定义视图控件尺寸
//1.底部控件视图的高度
#define FootViewHeight 50

@interface ShopingcartViewController ()

@end

@implementation ShopingcartViewController{
    //内部全局变量
    Boolean IsAllSelect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //全选按钮未选中
    IsAllSelect=false;
    //给购物车表格内容数组分配内存
    _dataArray=[NSMutableArray array];
    //界面部署
    [self setupView];
    //获取购物车列表
    [self getAllShopingcart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)init{
    if (self = [super init]) {
        self.title=@"购物车";
        self.tabBarItem.image = [UIImage imageNamed:@"shopingcart_tabBar"];
        self.hidesBottomBarWhenPushed = false;
    }
    return self;
}

-(UITableView *)shopingCartTableView{
    //懒加载即getter函数，如果对象shopingCartTableView不空则直接返回
    if(!_shopingCartTableView){
        //1.分配内存，设置无框、普通样式风格，且背景色为白色
        _shopingCartTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _shopingCartTableView.backgroundColor =UIColor.whiteColor;
        //2.协议代理设置
        _shopingCartTableView.delegate = self;
        _shopingCartTableView.dataSource = self;
        //3. 表格视图的单元格注册，第一个@"ShopingCartTableViewCell"是xib文件名，第二个@"ShopingCartTableViewCell"是可重用标识符名称
        [self.shopingCartTableView registerNib:
         [UINib nibWithNibName:@"ShopingCartTableViewCell" bundle:nil]
                        forCellReuseIdentifier:@"ShopingCartTableViewCell"
         ];
    }
    return _shopingCartTableView;
}

#pragma mark --实现UITableDataSource协议
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//定义展示的行个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

//每行展示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //复用单元格
    ShopingCartTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier: @"ShopingCartTableViewCell" forIndexPath:indexPath];
    //取消单元格选中后变灰的效果
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //设置单元格的自定义delegate协议对象值为self
    cell.delegate=self;
    //从表格视图控件的dataArray中得到当前行的model，并将其传递给当前行的cell
    Shopingcart *model = _dataArray[indexPath.row];
    [cell setModel:model];
    //返回设置好的cell对象
    return cell;
}

#pragma mark --实现UITableViewDelegate协议
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark --实现ShopingCartTableViewCellDelegate协议
//计算总价格，改变总价格标签控件值
-(void)totalprice{
    NSInteger allMoney=0;
    // 遍历数组将每个设备的价格，数量取出计算总价格
    for(Shopingcart *model in _dataArray){
        NSString *money=model.Device.DevicePrice;
        NSInteger num=[model.BuyNum intValue];
        if([model.ChooseStatus isEqualToString:@"1"]){
            allMoney+=[money intValue]*num;
        }
    }
    _moneylabel.text=[NSString stringWithFormat:@"¥ %ld",allMoney];
}

//计算选中个数，改变全选按钮状态
-(void)totalchoiced{
    NSInteger selectnum=0;
    // 遍历数组将选中的设备个数进行累计
    for(Shopingcart *model in _dataArray){
        if([model.ChooseStatus isEqualToString:@"1"]){
            selectnum++;
        }
    }
    //如果选中设备的个数等于设备总数，即全部选中
    if (selectnum==_dataArray.count){
        [_allSelectBtn setImage:[UIImage imageNamed:@"choiced"]
                       forState:UIControlStateNormal];
        IsAllSelect=true;
    }else{
        [_allSelectBtn setImage:[UIImage imageNamed:@"choose"]
                       forState:UIControlStateNormal];
        IsAllSelect=false;
    }
}
//实现协议方法
-(void)howtochange{
    //调用totalprice函数，改变总价格标签控件值
    [self totalprice];
}
//实现协议方法
-(void)howtochoose{
    //调用totalprice函数，改变总价格标签控件值
    [self totalprice];
    //调用totalchoiced函数，改变全选按钮状态
    [self totalchoiced];
}

//footView懒加载函数
- (UIView *)footView{
    //懒加载即getter函数，如果对象footView不空则直接返回
    if(!_footView){
        //1.创建footView控件
        _footView=[[UIView alloc]init];
        //使用红绿蓝分量生成背景色
        _footView.backgroundColor= [UIColor colorWithRed:150/255.0
                           green:210/255.0 blue:238/255.0 alpha:1];
        //2. 创建allSelectBtn控件
        _allSelectBtn=[[UIButton alloc]init];
        [_footView addSubview:_allSelectBtn];
        [_allSelectBtn setImage:[UIImage imageNamed:@"choose"]
                       forState:UIControlStateNormal];
        [_allSelectBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        //_allSelectBtn按钮的触发事件为selectAllDevice
        [_allSelectBtn addTarget:self action:@selector(selectAllDevice)
                forControlEvents:UIControlEventTouchUpInside];
        //利用Masonry，设置全选按钮_allSelectBtn在父窗口_footView的相对位置：
        //top值为15，left值为15，以及size为20，20，即长和宽都是20
        [_allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_footView).mas_offset(15);
            make.left.mas_equalTo(_footView).mas_offset(15);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        //3.创建selectlabel控件
        UILabel *selectlabel=[UILabel new];
        [self.footView addSubview: selectlabel];
        selectlabel.text=@"全选";
        //利用Masonry，设置全选标签selectlabel在全选按钮控件_allSelectBtn的相对位置：
        // left值为allSelectBtn的right值再右偏移5，centerY和allSelectBtn相同
        [selectlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_allSelectBtn.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(_allSelectBtn);
        }];
        //4.创建moneylabel控件
        _moneylabel=[UILabel new];
        [self.footView addSubview: _moneylabel];
        _moneylabel.text=@"¥ 0";
        [_moneylabel setFont:[UIFont systemFontOfSize:17]];
        _moneylabel.textColor=UIColor.redColor;
        //利用Masonry，设置总价格标签_moneylabel在selectlabel控件的相对位置：
        // left值为selectlabel的right值再右偏移100，centerY和allSelectBtn相同
        [_moneylabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(selectlabel.mas_right).mas_offset(100);
            make.centerY.mas_equalTo(_allSelectBtn);
        }];
        //5.创建_payBtn控件
        _payBtn=[[UIButton alloc]init];
        [_footView addSubview:_payBtn];
        [_payBtn setTitle:@"结账" forState:UIControlStateNormal];
        [_payBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        //_payBtn按钮的触发事件为jiesuan
        [_payBtn addTarget:self action:@selector(jiezhang)
          forControlEvents:UIControlEventTouchUpInside];
        //利用Masonry，设置结帐按钮_ payBtn在父窗口_footView的相对位置：
        //top值为15，right值为-15，以及size为50，20，即长是50，宽是20
        [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_footView).mas_offset(-15);
            make.top.mas_equalTo(_footView).mas_offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
    }
    return _footView;
}

//全选按钮的绑定事件处理函数
-(void)selectAllDevice{
    //根据IsAllSelect进行置反操作
    if(!IsAllSelect){
        [_allSelectBtn setImage:[UIImage imageNamed:@"choiced"]
                       forState:UIControlStateNormal];
        IsAllSelect=!IsAllSelect;
    }else{
        [_allSelectBtn setImage:[UIImage imageNamed:@"choose"]
                       forState:UIControlStateNormal];
        IsAllSelect=!IsAllSelect;
    }
    for(Shopingcart *model in _dataArray){
        if(IsAllSelect){
            model.ChooseStatus=@"1";
        }else{
            model.ChooseStatus=@"0";
        }
    }
    //计算总价格
    [self totalprice];
    //强制刷新表格视图控件
    [self.shopingCartTableView reloadData];
}

//结帐按钮的绑定事件处理函数
-(void)jiezhang{
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"总金额%@，即将支付",_moneylabel.text]];
    //2s后关闭提示
    [SVProgressHUD dismissWithDelay:2];
}

//界面部署函数
-(void)setupView{
    //添加shopCartTableView到父窗口self.view中
    [self.view addSubview:self.shopingCartTableView];
    //利用Masonry，设置表格视图控件shopCartTableView在父窗口self.view的相对位置
    //top、left和right值都和self.view的top、left和right值相同
    //bottom值在self.view的bottom基础上，向上偏移
    [self.shopingCartTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-(FootViewHeight+TABBAR_HEIGHT));
    }];
    //添加footView到父窗口self.view中
    [self.view addSubview:self.footView];
    //利用Masonry，设置底部视图控件footView在父窗口self.view的相对位置
    //left和right值都和self.view的left和right值相同
    //top值在self.view的bottom基础上，向下偏移
    //height值为FootViewHeight
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(ScreenHeight-TABBAR_HEIGHT-FootViewHeight);
        make.height.mas_equalTo(FootViewHeight);
    }];
}

//获取所有购物车列表
-(void)getAllShopingcart{
    //显示转圈圈控件
    [SVProgressHUD show];
    // 初始化参数
    //执行网络访问请求
    [[NetworkTool shareInstance]requireMethodType:POSTType URLString:@"findAllShopingcartByUserId" Parameters:@{@"userId":[[User shareInstance] UserID]} Success:^(NSDictionary *respondDictionary) {
        for (NSDictionary *dic in respondDictionary[@"result"]) {
            Shopingcart *model = [[Shopingcart alloc]initWithDictionary:dic error:nil];
            model.ChooseStatus=@"0";
            [_dataArray addObject:model];
        }
        [_shopingCartTableView reloadData];
        [SVProgressHUD dismiss];
        
    } Failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取失败"];
    }];
}


@end
