//
//  HQConsumerOrientationDetailVC.m
//  smartGeo
//
//  Created by HeQin on 2018/5/10.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQConsumerOrientationDetailVC.h"

@interface HQConsumerOrientationDetailVC ()

@end

@implementation HQConsumerOrientationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
}


@end
