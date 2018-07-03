//
//  HQAroundListViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/3/28.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQAroundListViewController.h"

@interface HQAroundListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_aroundTitles;
    NSArray *_subways;
    NSArray *_traffics;
    NSArray *_hospatals;
    NSArray *_banks;
    NSArray *_foods;
    NSArray *_markets;
    NSArray *_alldata;
}
@end

@implementation HQAroundListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.view = _tableView;
    self.title = @"新荟城周边";
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
    _aroundTitles = @[@"地铁",@"公交",@"医院",@"银行",@"美食",@"购物"];
    _subways = @[@{@"name":@"望京东",@"detail":@"地铁15号线",@"distance":@"682米"},
                 @{@"name":@"望京",@"detail":@"地铁14号线东段;地铁15号线",@"distance":@"1199米"},
                 @{@"name":@"阜通",@"detail":@"地铁14号线",@"distance":@"965米"}
                 ];
    _traffics = @[@{@"name":@"融科橄榄城",@"detail":@"536路；538路；快速直达专8线",@"distance":@"66米"},
                 @{@"name":@"阜安西路",@"detail":@"476路；快速直达专8线",@"distance":@"853米"},
                 @{@"name":@"国风北京",@"detail":@"536路；538路；快速直达专8线",@"distance":@"446米"}
                 ];
    _hospatals = @[@{@"name":@"北京嫣然天使儿童医院",@"detail":@"",@"distance":@"175米"},
                   @{@"name":@"北京善尔医院",@"detail":@"",@"distance":@"853米"},
                   @{@"name":@"北京天使望京妇儿医院",@"detail":@"",@"distance":@"912米"}
                   ];
    _banks = @[@{@"name":@"招商银行（望京融科支行）",@"detail":@"",@"distance":@"16米"},
                  @{@"name":@"招商银行24小时自助服务",@"detail":@"",@"distance":@"16米"},
                  @{@"name":@"华夏银行ATM",@"detail":@"",@"distance":@"86米"}
                  ];
    _foods = @[@{@"name":@"十六味醉面",@"detail":@"",@"distance":@"47米"},
               @{@"name":@"渝乡人家新荟城店",@"detail":@"",@"distance":@"56米"},
               @{@"name":@"顶高高山西美食（望京）",@"detail":@"",@"distance":@"86米"}
               ];
    _markets = @[@{@"name":@"新荟城",@"detail":@"",@"distance":@"47米"},
                @{@"name":@"新荟城",@"detail":@"",@"distance":@"56米"},
                @{@"name":@"宝星生活文化广场",@"detail":@"",@"distance":@"89米"}
                ];
    _alldata = @[_subways,_traffics,_hospatals,_banks,_foods,_markets];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Around1Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        UILabel *distance = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, [UIScreen mainScreen].bounds.size.width - 110, 30)];
        distance.tag = 1025;
        cell.detailTextLabel.textColor = [UIColor grayColor];
        distance.font = [UIFont systemFontOfSize:12];
        distance.textColor = [UIColor grayColor];
        distance.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:distance];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *distance = [cell viewWithTag:1025];
    distance.text = [_alldata[indexPath.section][indexPath.row] objectForKey:@"distance"];
    cell.textLabel.text = [_alldata[indexPath.section][indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text = [_alldata[indexPath.section][indexPath.row] objectForKey:@"detail"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = _alldata[section];
    return arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _aroundTitles.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _aroundTitles[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
