//
//  RestaurantListCell.h
//  siteselection
//
//  Created by HeQin on 2017/10/26.
//  Copyright © 2017年 HeQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;

@end

@interface RestaurantModel : NSObject
@property (copy, nonatomic) UIImage *iconImg;
@property (copy, nonatomic) NSString *nameLab;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *typeLab;
@property (copy, nonatomic) NSString *descLab;
@property (copy, nonatomic) NSString *distanceLab;
+ (NSArray *)getListDataWithType:(int)type;
@end
