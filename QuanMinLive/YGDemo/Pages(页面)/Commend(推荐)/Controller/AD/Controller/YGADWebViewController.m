//
//  YGADWebViewController.m
//  YGDemo
//
//  Created by 阳光 on 2017/2/4.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGADWebViewController.h"

@interface YGADWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation YGADWebViewController

- (instancetype)initWithURL:(NSURL *)webURL
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.webURL = webURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webURL]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.view showHUD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.view hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.view showMessage:error.localizedDescription];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
