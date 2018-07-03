//
//  HQGuestViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/4/12.
//  Copyright © 2018年 HeQin. All rights reserved.
//  客人分析

#import "HQGuestViewController.h"
#import "HQGuestDetailViewController.h"

@interface HQGuestViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_detailArray;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HQGuestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStyleGrouped];
    self.title = @"客群分析";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _detailArray = @[@"主流客群年龄结构分析",@"主力客群性别分析",@"出行方式分析",@"移动端APP偏好分析",@"客群来源-办公地分析",@"客群来源-居住地分析",@"客群线下消费偏好分析",@"客群日常消费品类偏好分析",@"从年龄段角度看消费偏好",@"以餐饮消费偏好角度",@"服装类消费角度"];
    //,@"购物中心客群吸引力热图"
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Around1Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _detailArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{return 44;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return _detailArray.count;}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {return 30;}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {return @"客群分析";}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HQGuestDetailViewController *detail = [[HQGuestDetailViewController alloc] init];
    detail.type = (int)indexPath.row;
    detail.title = _detailArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


