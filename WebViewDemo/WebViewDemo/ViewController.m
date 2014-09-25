//
//  ViewController.m
//  WebViewDemo
//
//  Created by Mac_PC on 14-9-24.
//  Copyright (c) 2014年 H0meDev. All rights reserved.
//

#import "ViewController.h"

#define URLSTRING @"http://www.baidu.com"
#define RGB(r,g,b,a)                                    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#define FONTCOLOR_BLUE                                  RGB(85,165,214,1.0)
#define FONTCOLOR_BLACKSIX                              RGB(204,204,204,1.0)

#define BUTTONWITHED                                     [UIScreen mainScreen].applicationFrame.size.width/4
#define BUTTONHEIGHT                                     40

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = [UIScreen mainScreen].applicationFrame;
    self.refreshBar = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.refreshBar setBackgroundColor:[UIColor whiteColor]];
    [self.refreshBar setTitle:@"R" forState:UIControlStateNormal];
    [self.refreshBar setTitleColor:FONTCOLOR_BLUE forState:UIControlStateNormal];
    [self.refreshBar setTitleColor:FONTCOLOR_BLACKSIX forState:UIControlStateDisabled];
     NSLog(@" %f, %f", rect.size.height, rect.size.width);
    self.refreshBar.frame = CGRectMake(0, rect.size.height- BUTTONHEIGHT, BUTTONWITHED, BUTTONHEIGHT);
    [self.refreshBar addTarget:self action:@selector(RefreshClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.refreshBar];

    self.backBar = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBar setBackgroundColor:[UIColor whiteColor]];
    [self.backBar setTitle:@"B" forState:UIControlStateNormal];
    [self.backBar setTitleColor:FONTCOLOR_BLUE forState:UIControlStateNormal];
    [self.backBar setTitleColor:FONTCOLOR_BLACKSIX forState:UIControlStateDisabled];
    self.backBar.frame = CGRectMake(BUTTONWITHED * 1, rect.size.height- BUTTONHEIGHT, BUTTONWITHED, BUTTONHEIGHT);
    [self.backBar addTarget:self action:@selector(BackClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBar];

    self.forwarkBar = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forwarkBar  setBackgroundColor:[UIColor whiteColor]];
    [self.forwarkBar setTitle:@"F" forState:UIControlStateNormal];
    [self.forwarkBar setTitleColor:FONTCOLOR_BLUE forState:UIControlStateNormal];
    [self.forwarkBar setTitleColor:FONTCOLOR_BLACKSIX forState:UIControlStateDisabled];
    self.forwarkBar.frame = CGRectMake(BUTTONWITHED * 2, rect.size.height- BUTTONHEIGHT, BUTTONWITHED, BUTTONHEIGHT);
    [self.forwarkBar addTarget:self action:@selector(ForwordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forwarkBar];
    
    self.shareBar = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBar setBackgroundColor:[UIColor whiteColor]];
    [self.shareBar setTitle:@"S" forState:UIControlStateNormal];
    [self.shareBar setTitleColor:FONTCOLOR_BLUE forState:UIControlStateNormal];
    [self.shareBar setTitleColor:FONTCOLOR_BLACKSIX forState:UIControlStateDisabled];
    self.shareBar.frame = CGRectMake(BUTTONWITHED * 3, rect.size.height- BUTTONHEIGHT, BUTTONWITHED, BUTTONHEIGHT);
    [self.shareBar addTarget:self action:@selector(ShareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareBar];
    [self applyConstraints];
    self.backBar.enabled = NO;
    self.forwarkBar.enabled = NO;
	self.currentURL = [NSURL URLWithString:URLSTRING];
    
    self.netReach = [Reachability reachabilityForInternetConnection];
    [self.netReach startNotifier];
    
    SDURLCache *cache = [[SDURLCache alloc]initWithMemoryCapacity:1024*1024 diskCapacity:1024*1024*5 diskPath:[SDURLCache defaultCachePath]];
    [NSURLCache setSharedURLCache:cache];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.currentURL]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applyConstraints{
    self.backBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.refreshBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.shareBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.forwarkBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view removeConstraints:self.view.constraints];
     NSDictionary *viewDicts;
     NSArray *constraints;
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:@"40",@"btnHeight",@"80",@"btnWidth", nil];
    viewDicts = NSDictionaryOfVariableBindings(_webView,_refreshBar,_backBar,_forwarkBar,_shareBar);
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_webView]-0-|" options:0 metrics:metrics views:viewDicts];
    [self.view addConstraints:constraints];
    viewDicts = NSDictionaryOfVariableBindings(_webView,_refreshBar,_backBar,_forwarkBar,_shareBar);
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_refreshBar(btnWidth)]-0-[_backBar(80)]-0-[_forwarkBar(80)]-0-[_shareBar(80)]|" options:0 metrics:metrics views:viewDicts];
    [self.view addConstraints:constraints];
    viewDicts = NSDictionaryOfVariableBindings(_webView,_refreshBar,_backBar,_forwarkBar,_shareBar);
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]-0-[_refreshBar(btnHeight)]|" options:0 metrics:metrics views:viewDicts];
    [self.view addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]-0-[_backBar(btnHeight)]|" options:0 metrics:metrics views:viewDicts];
    [self.view addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]-0-[_forwarkBar(btnHeight)]|" options:0 metrics:metrics views:viewDicts];
    [self.view addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]-0-[_shareBar(btnHeight)]|" options:0 metrics:metrics views:viewDicts];
    [self.view addConstraints:constraints];

}

#pragma -mark UIWebviewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.refreshBar.enabled = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finished");
    self.forwarkBar.enabled = [webView canGoForward];
    self.backBar.enabled = [webView canGoBack];
    NSLog(@" forwark%i", self.forwarkBar.enabled);
    self.refreshBar.enabled = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self webViewDidFinishLoad:webView];
}


#pragma -mark ToolBar click 事件
- (IBAction)RefreshClick:(id)sender {
    NSLog(@"%@",self.webView.request.URL.absoluteString);
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webView.request.URL]];
}

- (IBAction)BackClick:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    self.forwarkBar.enabled = YES;
   // self.backBar.enabled = [self.webView canGoBack];
}

- (IBAction)ForwordClick:(id)sender {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
    self.forwarkBar.enabled = [self.webView canGoForward];
    self.backBar.enabled = YES;

}

- (IBAction)ShareClick:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微博",@"分享到Linkendin", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *url = self.webView.request.URL.absoluteString;
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    switch (buttonIndex) {
        case 0:
            [self showAlert:[NSString stringWithFormat:@"分享到微博  %@ %@",title,url]];
            break;
        case 1:
            [self showAlert:[NSString stringWithFormat:@"分享到Linkendin  %@ %@",title,url]];
            break;
        case 2:
            [self showAlert:@"取消"];
        default:
            break;
    }
}

- (void) showAlert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Action Sheet"
                          message:msg
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: nil];
    [alert show];
}
@end
