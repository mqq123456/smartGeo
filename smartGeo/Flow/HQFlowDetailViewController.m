//
//  HQFlowDetailViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/5/10.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQFlowDetailViewController.h"

@interface HQFlowDetailViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSArray *htmlArray;
@end

@implementation HQFlowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _htmlArray = @[@"minute",@"hour",@"highhour",@"year",@"day",@"month",@"pedestrian",@"workday",@"weekday",@"special"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:webView];
    self.webView = webView;
    NSString *fileName = [NSString stringWithFormat:@"%@%d",_htmlArray[self.type],1];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    [webView loadHTMLString:htmlString baseURL:url];
    NSArray *array = [NSArray arrayWithObjects:@"阜通西大街",@"阜安路",@"宝星华庭",@"宝星园二期", nil];
    UISegmentedControl *segment =[[UISegmentedControl alloc] initWithItems:array];
    segment.frame = CGRectMake(0, CGRectGetMaxY(webView.frame) + 10, [UIScreen mainScreen].bounds.size.width, 44);
    [self.view addSubview:segment];
    segment.selectedSegmentIndex = 0;
    //添加事件
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
}
-(void)change:(UISegmentedControl *)sender{
    NSString *fileName = @"";
    if (sender.selectedSegmentIndex == 0) {
        fileName = [NSString stringWithFormat:@"%@%d",_htmlArray[self.type],1];
    }else if (sender.selectedSegmentIndex == 1){
        fileName = [NSString stringWithFormat:@"%@%d",_htmlArray[self.type],2];;
    }else if (sender.selectedSegmentIndex == 2){
       fileName = [NSString stringWithFormat:@"%@%d",_htmlArray[self.type],3];
    }else if (sender.selectedSegmentIndex == 3){
        fileName = [NSString stringWithFormat:@"%@%d",_htmlArray[self.type],4];
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    [self.webView loadHTMLString:htmlString baseURL:url];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
