//
//  HQGuestDetailViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/5/10.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQGuestDetailViewController.h"

@interface HQGuestDetailViewController ()

@end

@implementation HQGuestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *array = @[@"guest_age",@"guest_sex",@"guest_tool",@"guest_app",@"guest_work",@"guest_live",@"guest_ConsumerPreference",@"guest_ConsumerCategoryPreference",@"guest_AgeConsumerPreference",@"guest_DiningConsumerPreference",@"guest_DressConsumerPreference",@"guest_HotMap"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:webView];
    NSString *fileName = array[self.type];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    [webView loadHTMLString:htmlString baseURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
