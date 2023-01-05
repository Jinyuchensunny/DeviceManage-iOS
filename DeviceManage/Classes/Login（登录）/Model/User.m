//
//  User.m
//  DeviceManage
//
//  Created by sjl on 2019/11/20.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "User.h"

@implementation User

// 写文件：User类的self对象应该需要存哪些属性
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.UserID forKey:@"UserID"];
    [aCoder encodeObject:self.UserName forKey:@"UserName"];
    [aCoder encodeObject:self.UserPassword forKey:@"UserPassword"];
}
// 读文件：需要读哪些属性到User类的self对象
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    //生成空白内容的self对象
    self=[super init];
    if(self){
        self.UserID=[aDecoder decodeObjectForKey:@"UserID"];
        self.UserName=[aDecoder decodeObjectForKey:@"UserName"];
        self.UserPassword=[aDecoder decodeObjectForKey:@"UserPassword"];
    }
    return self;
}

//用于返回待存储文件UserInfo.plist在手机存储器中的绝对路径
+(NSString *)savePath{
    // 获得app沙盒中的Document目录的绝对路径字符串
    NSString* path= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
    // 将文件名UserInfo.plist拼接在绝对路径字符串后面
    return [path stringByAppendingPathComponent:@"UserInfo.plist"];
}

//用于根据initWithCoder协议方法，读取文件UserInfo.plist，返回User类型的对象
+(instancetype)readFromFile{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[User savePath]];
}

// 定义一个User类的单例对象变量
static User* singletonUser;
// 生成单例对象变量singletonUser
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonUser=[User readFromFile];
        //第一次登陆时，singletonUser是nil的
        //如果取不到文件,就新创建一个User对象
        if(singletonUser == nil){
            singletonUser=[[User alloc]init];
        }
    });
   
    return singletonUser;
}

//用于判断self对象的UserName是否有值，有值则说明已经登陆成功过了
-(BOOL)checkLogin{
    if(self.UserName == nil && [self.UserName length]==0){
        return false;
    }else{
        return true;
    }
}

//用于将登陆信息打印输出到控制台
- (void)showLog{
    NSLog(@"-------------------------------------------------");
    NSLog(@"-------------------登录服务器信息-------------------");
    NSLog(@"-------------------------------------------------");
    NSLog(@"UserID: %@",self.UserID);
    NSLog(@"UserName: %@",self.UserName);
    NSLog(@"UserPassword: %@",self.UserPassword);
    NSLog(@"登陆信息文件的在沙盒中的保存路径: %@",[User savePath]);
    NSLog(@"-------------------------------------------------");
    NSLog(@"-------------------------------------------------");
}

// 第一次登陆成功后，将登陆信息保存到UserInfo.plist中
-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    // 1.根据encodeWithCoder协议方法，将字典对象读入，生成self对象
    // 即将字典中的各个属性填充给self对象的各个属性
    [super setValuesForKeysWithDictionary:keyedValues];
    // 2.将self对象写入文件UserInfo.plist中
    [NSKeyedArchiver archiveRootObject:self toFile:[User savePath]];
    //2.登陆信息在控制台上显示
    [self showLog];
}

- (void)logout {
    NSFileManager *manager = [NSFileManager defaultManager];
    // 1. UserInfo.plist文件是否存在
    if (![manager fileExistsAtPath:[User savePath]]) {
        NSLog(@"没有找到已登陆用户信息文件");
        return ;
    }
    // 2.删除UserInfo.plist文件
    if([manager removeItemAtPath:[User savePath] error:nil]) {
        NSLog(@"成功登出");
    }
    // 3.释放模型
    singletonUser = [[User alloc] init];
}



@end
