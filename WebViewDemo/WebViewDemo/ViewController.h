//
//  ViewController.h
//  WebViewDemo
//
//  Created by Mac_PC on 14-9-24.
//  Copyright (c) 2014年 H0meDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "SDURLCache.h"
@interface ViewController : UIViewController<UIActionSheetDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@property (nonatomic, strong) Reachability *netReach;
@property (nonatomic, strong) NSURL *currentURL;

@property (nonatomic ,weak) UIButton *refreshBar;
@property (nonatomic ,weak) UIButton *backBar;
@property (nonatomic ,weak) UIButton *forwarkBar;
@property (nonatomic ,weak) UIButton *shareBar;

- (IBAction)RefreshClick:(id)sender;
- (IBAction)BackClick:(id)sender;
- (IBAction)ForwordClick:(id)sender;
- (IBAction)ShareClick:(id)sender;

@end
