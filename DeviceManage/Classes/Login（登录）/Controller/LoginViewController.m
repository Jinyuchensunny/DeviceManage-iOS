//
//  LoginViewController.m
//  DeviceManage
//
//  Created by sjl on 2019/11/24.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 检查是否已经登录，如果已经登录，则直接进入主界面
    if ([[User shareInstance] checkLogin]  ) {
        // 已登录
        [self showMainViewController];
        return;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 回调函数loginCallback
-(void)loginCallback:(User *)loginUser{
    
}
//执行登陆
- (IBAction)loginValidate:(id)sender {
    //显示转圈圈控件
    [SVProgressHUD show];
    // 初始化参数
    NSDictionary *params=@{@"username":self.usernameTF.text,
                           @"password":self.passwordTF.text};
    //执行网络访问请求
    [[NetworkTool shareInstance]requireMethodType:POSTType URLString:@"DeviceManage/loginValidate" Parameters:params Success:^(NSDictionary *respondDictionary) {
        // 如果respondDictionary中为空,直接说明登陆错误，直接返回
        if([[respondDictionary[@"result"][0] allKeys] count]==0){
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"web接口服务连接失败。1.请确保主机ip地址是否正确，然后打开tomcat服务器。2.确保用户名和密码正确"];
            return;
        }
        // 如果respondDictionary中不为空,说明登陆正确
        
        [SVProgressHUD showInfoWithStatus:@"恭喜你，登陆成功"];
        // 将登陆成功的用户保存到手机上
        [[User shareInstance]setValuesForKeysWithDictionary:respondDictionary[@"result"][0]];
        [SVProgressHUD dismiss];
        //打开主页面控制器
        [self showMainViewController];
    } Failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"web接口服务连接失败。请确保主机ip地址是否正确，然后打开tomcat服务器"];
    }];
}

//显示主界面
-(void)showMainViewController{
    //通过单例UIApplication对象获得app的委托类AppDelegate对象
    AppDelegate *appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    //通过委托类对象设置新的主界面
    appDelegate.window.rootViewController=[[MainViewController alloc]init];
}

//QQ登陆按钮执行
- (IBAction)qqLogin:(id)sender {
    //创建TencentOAuth并初始化其appid，delegate为实现TencentSessionDelegate的对象：
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1110167739" andDelegate:self];
    //特别要注意，登录前需要授权，否则会爆出未授权错误
    _tencentOAuth.authShareType = AuthShareType_QQ;
    //初始化redirectURI（这里需要填写注册APP时填写的域名。默认可以不用填写
    NSArray *permissions = [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
    //登录时，调用TencetnOAuth对象的authorize方法：
    [_tencentOAuth authorize:permissions inSafari:NO];
}

//QQ登陆成功后的回调函数
-(void)tencentDidLogin{
    NSLog(@"登录完成");
    [self showMainViewController];
    //如果登陆成功，则记录登录用户的OpenID、Token以及过期时间
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]){
        NSLog(@"%@", _tencentOAuth.accessToken);
    }
    else{
        NSLog(@"登录不成功，没有获取accesstoken");
    }
}

//非网络错误导致QQ登录失败
-(void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled){
        NSLog(@"用户取消登录");
    }
    else{
        NSLog(@"登录失败");
    }
}

//网络错误导致QQ登录失败
-(void)tencentDidNotNetWork{
    NSLog(@"无网络连接，请设置网络");
}

@end
