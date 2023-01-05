//
//  LoginViewController.h
//  DeviceManage
//
//  Created by sjl on 2019/11/24.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkTool.h"
#import "User.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@interface LoginViewController : UIViewController <TencentSessionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)loginValidate:(id)sender;
- (IBAction)qqLogin:(id)sender;

@property (nonatomic,strong)TencentOAuth* tencentOAuth;


@end
