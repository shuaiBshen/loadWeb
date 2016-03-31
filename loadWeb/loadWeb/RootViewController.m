//
//  RootViewController.m
//  loadWeb
//
//  Created by 申帅 on 16/3/23.
//  Copyright © 2016年 申帅. All rights reserved.
//

#import "RootViewController.h"
#import <WebKit/WebKit.h>
@interface RootViewController ()<WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UIView *toolsView;
@property (weak, nonatomic) IBOutlet UILabel *LineCount;
@property (weak, nonatomic) IBOutlet UIButton *goFaward;
@property (weak, nonatomic) IBOutlet UIButton *goBack;
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation RootViewController{
    NSString *title;
}
- (WKWebView *)webView{
    if (!_webView) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 44)];
        _webView.navigationDelegate = self;
    }
    return _webView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_webUrl) {
        _webUrl = @"http://wap.baidu.com";
    }
    [self.view addSubview:self.webView];
    _webView.allowsBackForwardNavigationGestures = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]]];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[HistoryModel manager] findAllWebCount] == 0) {
        _LineCount.text = @"1";
    }else{
     _LineCount.text = [NSString stringWithFormat:@"%ld",(long)[[HistoryModel manager] findAllWebCount]];
    }
}



- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"~~~~~~~~%@", cookie);
    }
    title = webView.title;//获取当前页面的title
    _webUrl = [NSString stringWithFormat:@"%@",webView.URL];
    if (!title) {
        title = @"获取标题失败";
    }
    if ([_webView canGoForward]) {
        _goFaward.enabled = YES;
    }else{
        _goFaward.enabled = NO;
    }
    if ([_webView canGoBack]) {
        _goBack.enabled = YES;
    }else{
        _goBack.enabled = NO;
    }

}



- (IBAction)addNewBrawors:(id)sender {
    
    [[HistoryModel manager] saveWebController:self webURl:_webUrl webTitle:title];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)faward:(id)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}
- (IBAction)back:(id)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}




- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
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
