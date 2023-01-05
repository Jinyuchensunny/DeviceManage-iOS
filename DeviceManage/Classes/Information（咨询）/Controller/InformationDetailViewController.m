//
//  InformationDetailViewController.m
//  DeviceManage
//
//  Created by sjl on 2019/12/7.
//  Copyright © 2019年 sjl. All rights reserved.
//

#import "InformationDetailViewController.h"

@interface InformationDetailViewController ()

@end

@implementation InformationDetailViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//懒加载WKWebView控件属性informationTableView
- (WKWebView *)informationWV{
    // 初始化WKWebViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    if(!_informationWV){
        _informationWV = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
        _informationWV.UIDelegate = self;
        _informationWV.navigationDelegate = self;
    }
    return _informationWV;
}

-(void)setUpView{
    //字符串替换url
    NSString *strUrl = [self.model.InformationContent stringByReplacingOccurrencesOfString:
                        @"localhost"  withString:REAL_IPADDRESS];
    [self.informationWV loadHTMLString:strUrl baseURL:nil];
    [self.view addSubview:self.informationWV];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setUpView];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"开始加载");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"内容开始返回");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"加载完成");
}

- (void)webView:(WKWebView *)webView didFailLoadWithError:(nonnull NSError *)error {
    NSLog(@"加载失败 error : %@",error.description);
}


@end
