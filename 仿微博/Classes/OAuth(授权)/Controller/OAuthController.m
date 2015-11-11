//
//  OAuthController.m
//  仿微博
//
//  Created by Yzc on 15/11/5.
//  Copyright © 2015年 Yzc. All rights reserved.
//

#import "OAuthController.h"
#import "AFNetworking.h"
#import "UIWindow+Extension.h"
#import "AccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface OAuthController ()<UIWebViewDelegate>

@end

@implementation OAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame =self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3445043596&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}



#pragma mark - webView代理方法

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
     [MBProgressHUD hideHUD];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}



-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //获得url
    NSString *urlString = request.URL.absoluteString;
    //判断是否为回调地址
    NSRange range = [urlString rangeOfString:@"code="];
    if(range.length != 0)
    {
        //截取code= 后面的参数值
        int fromIndex = range.location + range.length;
        NSString *code = [urlString substringFromIndex:fromIndex];
        [self accessTokenWithCode:code];
        
        //禁止回调
        return NO;
    }
  return YES;
}

-(void)accessTokenWithCode:(NSString *)code
{
    //"access_token" = "2.00PvHFOCSNDJlD20984eaed5ghDv3C";
    /*
     URL：https://api.weibo.com/oauth2/access_token
     
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
     // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型
    
    NSMutableDictionary *paramgs = [NSMutableDictionary dictionary];
    paramgs[@"client_id"] =@"3445043596" ;
    paramgs[@"client_secret"] = @"2c60ea697d9f2a36acbf9ba2fa25a968";
    paramgs[@"grant_type"] = @"authorization_code";
    paramgs[@"redirect_uri"] = @"http://www.baidu.com";
    paramgs[@"code"] = code;
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:paramgs success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD hideHUD];
        Account *account = [Account accountWithDict:responseObject];
        [AccountTool saveAccount:account];
        
        //切换根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
   
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
       [MBProgressHUD hideHUD];
        NSLog(@"请求失败---%@",error);
    }];
}


@end
