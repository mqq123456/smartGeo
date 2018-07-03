//
//  HQSearchViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/3/25.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQSearchViewController.h"
#import "HQSearchBar.h"
#import "HQResultMainViewController.h"
#import "PersonalCenterController.h"

@interface HQSearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_result;
    UITableView *_tableView;
}
@end

@implementation HQSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加搜索框
    HQSearchBar *searchBar = [[HQSearchBar alloc] init];
    searchBar.frame = CGRectMake(-60, 0, 300, 40);
    searchBar.delegate = self;
    [searchBar becomeFirstResponder];
    searchBar.placeholder = @"搜商铺、门店、商圈";
    self.navigationItem.titleView = searchBar;
    _result = [NSArray array];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    _result = @[@"新荟城"];
    [_tableView reloadData];
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"SearchViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.textLabel.text = @"新荟城";
        cell.detailTextLabel.text = @"北京市朝阳区望京东园一区120号";
        cell.backgroundColor = [UIColor colorWithRed:252.0/255.0 green:252.0/255.0 blue:252.0/255.0 alpha:1];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _result.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_result.count != 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 30)];
        label.text = @"您是不是要找";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
        return view;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PersonalCenterController *result = [[PersonalCenterController alloc] init];
    [self.navigationController pushViewController:result animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
