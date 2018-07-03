//
//  HQResultMainViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/3/26.
//  Copyright © 2018年 HeQin. All rights reserved.
//  搜索结果的主要View 大概展示了主要情况

#import "HQResultMainViewController.h"
#import "LSLSegmentScrollView.h"

@interface HQResultMainViewController ()

@property(nonatomic, weak) UITableView * tableView;
@property(nonatomic, weak) UIView * contentView;
@property(nonatomic, strong) UIView * headerView;

@property(nonatomic, weak) LSLSegmentScrollView * scrollView;

@end

@implementation HQResultMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新荟城";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUserInterface];
}

//设置界面
- (void)setUpUserInterface {
    
    UIImageView * headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    headerView.image = [UIImage imageNamed:@"xinhuicheng_img.jpeg"];
    
    LSLSegmentScrollView * scrollView = [[LSLSegmentScrollView alloc] initWithFrame:self.view.bounds headerView:headerView currentVC:self];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    NSArray * array = @[@{@"HQAroundViewController":@"详情"},
                        @{@"HQAnalyseViewController":@"分析"},
                        @{@"SDTimeLineTableViewController":@"点评"}];
    
    scrollView.titleArrays = array;
}


@end
