//
//  HQConsumerDetailViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/5/10.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQConsumerDetailViewController.h"
#import "RestaurantListCell.h"

@interface HQConsumerDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HQConsumerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    NSArray *array = @[@"Consumer_cagetory",@"Consumer_children",@"Consumer_dining",@"Consumer_leisure"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        RestaurantModel *model = [[RestaurantModel alloc] init];
        if (i ==0) {
            model.iconImg = [UIImage imageNamed:@"IMG_1216.JPG"];
            model.nameLab = @"鲜果时间";
            model.descLab = @"人均：¥12";
            model.price = @"5F 4.7分";
            model.typeLab = @"甜品饮品";
        }else if (i ==1) {
            model.iconImg = [UIImage imageNamed:@"IMG_1215.JPG"];
            model.nameLab = @"甘茶度";
            model.descLab = @"人均：¥14";
            model.price = @"5F 4.6";
            model.typeLab = @"甜品饮品";
        }else if(i == 2){
            model.iconImg = [UIImage imageNamed:@"IMG_1214.JPG"];
            model.nameLab = @"吉祥馄炖";
            model.descLab = @"人均：¥20";
            model.price = @"5F 4.0";
            model.typeLab = @"馄炖";
        }
        if (i ==3) {
            model.iconImg = [UIImage imageNamed:@"IMG_1179.JPG"];
            model.nameLab = @"可C可D";
            model.descLab = @"人均：¥21";
            model.price = @"3F 4.2";
            model.typeLab = @"甜品饮品";
        }else if (i ==4) {
            model.iconImg = [UIImage imageNamed:@"IMG_1170.JPG"];
            model.nameLab = @"东御皇茶";
            model.descLab = @"人均：¥22";
            model.price = @"4F 4.3";
            model.typeLab = @"甜品饮品";
        }else if(i == 5){
            model.iconImg = [UIImage imageNamed:@"IMG_1160.PNG"];
            model.nameLab = @"江南老粥铺";
            model.descLab = @"人均：¥26";
            model.price = @"2F 3.9";
            model.typeLab = @"粥店";
        }
        [self.dataArray addObject:model];
    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"Around3-7Cell";
    RestaurantListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantListCell" owner:self options:nil]lastObject];
    }
    RestaurantModel *model = self.dataArray[indexPath.row];
    cell.distanceLab.hidden = YES;
    cell.iconImg.image = model.iconImg;
    cell.nameLab.text = model.nameLab;
    cell.descLab.text = model.descLab;
    cell.price.text = model.price;
    cell.typeLab.text = model.typeLab;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
