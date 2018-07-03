//
//  HQCompeteDetailViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/5/10.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQCompeteDetailViewController.h"

@interface HQCompeteDetailViewController ()

@end

@implementation HQCompeteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.scrollView.scrollEnabled = NO;
    self.view = webView;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jiaotong" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    [webView loadHTMLString:htmlString baseURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
