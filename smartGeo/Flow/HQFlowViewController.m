//
//  HQFlowViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/4/6.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQFlowViewController.h"
#import "HQFlowDetailViewController.h"

@interface HQFlowViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
    NSArray *_detailArray;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HQFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStyleGrouped];
    self.title = @"交通流量";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataArray = @[@"特定时段交通流量",@"小时交通流量",@"高峰小时交通流量",@"年最大小时交通流量",@"平均日交通流量",@"平均月交通流量",@"行人交通流量",@"工作日交通流量",@"休息日交通流量",@"特殊情况交通流量"];
    _detailArray = @[@"特定时段以5 min，15 min，30 min、一个信号周期、1h、白天12 h（7时至19时）、白天16 h（6时至22时）、日、周、月、年等为单位",@"以小时为单位观测交通流量所得值",@"一天24 h或一定时段（如上午、下午）内所出现的最大的小时交通流量",@"一年内最大的小时交通流量",@"某一时段交通流量累计数除以该时段总天数所得值",@"一年交通流量累计数除以12所得值",@"平行于路沿方向行走的行人流量。如特指人行横道上的行人流量应予注明",@"国家规定的工作日的交通流量",@"国家规定的休息日的交通流量",@"大型集会、文艺、体育活动、重要外事活动、异常天气、临时交通控制措施等情况的交通流量"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Around1Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.detailTextLabel.text = _detailArray[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HQFlowDetailViewController *detail = [[HQFlowDetailViewController alloc] init];
    detail.type = (int)indexPath.row;
    detail.title = _dataArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
