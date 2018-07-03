//
//  HQAnalyseViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/3/26.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQAnalyseViewController.h"
#import "HQConsumerViewController.h"
#import "HQFlowViewController.h"
#import "HQGuestViewController.h"
#import "HQCompeteViewController.h"
#import "HQConsumerOrientationVC.h"

@interface HQAnalyseViewController ()
{
    NSArray *_dataArray;
    NSArray *_detailArray;
}
@end

@implementation HQAnalyseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _dataArray = @[@"区域人流量分析",@"客群属性分析",@"消费品类分析",@"竞争商户分析",@"消费定位分析",@"店铺最新活动",@"综合评分"];
    _detailArray = @[@"jiaotong",@"yonghu",@"xiaofei",@"jingzheng",@"dingwei",@"huodong",@"pingfen"];
   
}
- (UINavigationController *)navigationController {
    return _navigationController;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Around1Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    UIImage *icon = [UIImage imageNamed:_detailArray[indexPath.section]];
    CGSize itemSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO ,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
    cell.textLabel.text = _dataArray[indexPath.section];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIWebView *view = [[UIWebView alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:_detailArray[section] ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [[NSURL alloc] initWithString:filePath];
    [view loadHTMLString:htmlString baseURL:url];
    view.scrollView.scrollEnabled = NO;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [UIScreen mainScreen].bounds.size.width *0.85;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *controller;
    if (indexPath.section == 0) {
        controller = [[HQFlowViewController alloc] init];
    }else if (indexPath.section == 1) {
        controller = [[HQGuestViewController alloc] init];
    }else if (indexPath.section == 2) {
        controller = [[HQConsumerViewController alloc] init];
    }else if (indexPath.section == 3) {
        controller = [[HQCompeteViewController alloc] init];
    }else if (indexPath.section ==4) {
        controller = [[HQConsumerOrientationVC alloc] init];
    }
    if (controller) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
