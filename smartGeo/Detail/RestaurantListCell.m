//
//  RestaurantListCell.m
//  siteselection
//
//  Created by HeQin on 2017/10/26.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import "RestaurantListCell.h"

@implementation RestaurantListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
@implementation RestaurantModel
+ (NSArray *)getListDataWithType:(int)type {
    if (type == 0) {
        return [RestaurantModel getAll];
    }else if (type == 1) {
        return [RestaurantModel getRestaurant];
    }else if (type == 2) {
        return [RestaurantModel getCherd];
    }else{
        return [RestaurantModel getbefult];
    }
    
}
+ (NSArray *)getAll {
    NSMutableArray *dataArray = [NSMutableArray array];
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
        [dataArray addObject:model];
    }
    return dataArray;
}
+ (NSArray *)getRestaurant {
    NSMutableArray *dataArray = [NSMutableArray array];
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
        [dataArray addObject:model];
    }
    return dataArray;
}
+ (NSArray *)getCherd {
    NSMutableArray *dataArray = [NSMutableArray array];
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
        [dataArray addObject:model];
    }
    return dataArray;
}
+ (NSArray *)getbefult {
    NSMutableArray *dataArray = [NSMutableArray array];
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
        [dataArray addObject:model];
    }
    return dataArray;
}
@end
