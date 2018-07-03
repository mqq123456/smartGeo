//
//  HQConsumerOrientationVC.m
//  smartGeo
//
//  Created by HeQin on 2018/4/12.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQConsumerOrientationVC.h"
#import "HQConsumerOrientationDetailVC.h"

@interface HQConsumerOrientationVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
    NSArray *_detailAttay;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HQConsumerOrientationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStyleGrouped];
    self.title = @"消费定位分析";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataArray = @[@"年龄",@"性别",@"消费等级",@"职业",@"消费动机"];
    _detailAttay = @[@"寻找空当",@"创建新的产品类别",@"把自己定位为第二品牌",@"聚焦成为专家",@"创建渠道品牌",@"创建性别品牌"];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Around1Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section ==0) {
        cell.textLabel.text = _dataArray[indexPath.row];
    }else{
        cell.textLabel.text = _detailAttay[indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _dataArray.count;
    }
    return _detailAttay.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"消费定位";
    }
    return @"消费定位方法";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HQConsumerOrientationDetailVC *detail = [[HQConsumerOrientationDetailVC alloc] init];
    if (indexPath.section == 0) {
        detail.type = (int)indexPath.row;
        detail.title = _dataArray[indexPath.row];
    }else{
        detail.type = (int)(_dataArray.count +indexPath.row -1);
        detail.title = _detailAttay[indexPath.row];
    }
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
