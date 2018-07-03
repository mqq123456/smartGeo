//
//  HQAroundViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/3/26.
//  Copyright © 2018年 HeQin. All rights reserved.
//  1.周边，2.待租门店，3.商户信息

#import "HQAroundViewController.h"
#import "HQAroundListViewController.h"
#import "HQAroundMapViewController.h"
#import "RestaurantListCell.h"
#import "HQTitileCell.h"
@interface HQAroundViewController ()
@end

@implementation HQAroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}
- (UINavigationController *)navigationController {
    return _navigationController;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *ID = @"Around1Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.textLabel.text = @"位置及周边";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.8)];
            line.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            [cell.contentView addSubview:line];
        }
        return cell;
    }else if (indexPath.row == 1) {
        static NSString *ID = @"Around2Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width *0.39)];
            imageView.image = [UIImage imageNamed:@"xinhuicheng_map.png"];
            [cell.contentView addSubview:imageView];
        }
        return cell;
    }else if (indexPath.row == 2) {
        static NSString *ID = @"Around3Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.textLabel.text = @"地铁、公交、医院、购物、银行...";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else if (indexPath.row == 3) {
        static NSString *ID = @"Around4Cell";
        HQTitileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HQTitileCell" owner:self options:nil]lastObject];
        }
        cell.img.image  = [UIImage imageNamed:@"icon_dianyu"];
        cell.title.text = @"精选店铺";

        return cell;
    }else if (indexPath.row >3 && indexPath.row < 7){
        static NSString *ID = @"Around3-7Cell";
        RestaurantListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantListCell" owner:self options:nil]lastObject];
        }
        cell.distanceLab.hidden = YES;
        if (indexPath.row ==4) {
            cell.iconImg.image = [UIImage imageNamed:@"IMG_1216.JPG"];
            cell.nameLab.text = @"锦尚阁私家烤鱼";
            cell.descLab.text = @"83/人";
            cell.price.text = @"优惠套餐156.0起";
            cell.typeLab.text = @"美食";
            
        }else if (indexPath.row ==5) {
            cell.iconImg.image = [UIImage imageNamed:@"IMG_1215.JPG"];
            cell.nameLab.text = @"果蔬好超市";
            cell.descLab.text = @"209/人";
            cell.price.text = @"256人评论过";
            cell.typeLab.text = @"水果生鲜";
        }else if(indexPath.row == 6){
            cell.iconImg.image = [UIImage imageNamed:@"IMG_1214.JPG"];
            cell.nameLab.text = @"万达影城";
            cell.descLab.text = @"40/人";
            cell.price.text = @"1667人收藏过";
            cell.typeLab.text = @"影院";
        }
        return cell;
    }else if (indexPath.row == 7) {
        static NSString *ID = @"Around7Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.textLabel.text = @"查看更多店铺";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else if (indexPath.row == 8) {
        static NSString *ID = @"Around8Cell";
        HQTitileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HQTitileCell" owner:self options:nil]lastObject];
        }
        cell.img.image = [UIImage imageNamed:@"icon_daizu"];
        cell.title.text = @"待租门店";
        return cell;
    }else if (indexPath.row >8 && indexPath.row < 12){
        static NSString *ID = @"Around12Cell";
        RestaurantListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RestaurantListCell" owner:self options:nil]lastObject];
        }
        if (indexPath.row ==9) {
            cell.iconImg.image = [UIImage imageNamed:@"IMG_1179.JPG"];
            cell.nameLab.text = @"保利公园，临街一层，132平，业态不限，业主直租";
            cell.descLab.text = @"罗斌";
            cell.price.text = @"132平米 | 1至3层 | 商业综合体";
            cell.typeLab.text = @"保利中央公园 [朝阳-望京东 阜安路与宏泰东街交汇处]";
            cell.distanceLab.text = @"6.02万/月";
        }else if (indexPath.row ==10) {
            cell.iconImg.image = [UIImage imageNamed:@"IMG_1170.JPG"];
            cell.nameLab.text = @"望京110平主街超热闹门脸出租 可明火办照";
            cell.descLab.text = @"面议";
            cell.price.text = @"中区（共47展）";
            cell.typeLab.text = @"精装修，节省装修成本，不可分割";
            cell.distanceLab.text = @"10万/月";
        }else if(indexPath.row == 11){
            cell.iconImg.image = [UIImage imageNamed:@"IMG_1160.PNG"];
            cell.nameLab.text = @"望京SOHO底商 正对喷泉 吃饭必经之处 盈利中";
            cell.descLab.text = @"面议";
            cell.price.text = @"面积75平米，使用率高达75%，可容纳16～8个工位";
            cell.typeLab.text = @"位于大厦中区";
            cell.distanceLab.text = @"200万/年";
        }
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        HQAroundMapViewController *list = [[HQAroundMapViewController alloc] init];
        [self.navigationController pushViewController:list animated:YES];
    }
    if (indexPath.row == 2) {
        HQAroundListViewController *list = [[HQAroundListViewController alloc] init];
        [self.navigationController pushViewController:list animated:YES];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return [UIScreen mainScreen].bounds.size.width *0.39;
    }
    if (indexPath.row >3 && indexPath.row <7) {
        return 100;
    }
    if (indexPath.row > 8 && indexPath.row < 12) {
        return 100;
    }
    if (indexPath.row == 3 || indexPath.row == 8) {
       return 30;
    }
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

