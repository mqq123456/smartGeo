//
//  HQGuestDetailViewController.h
//  smartGeo
//
//  Created by HeQin on 2018/5/10.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    GuestDetailAge = 0, // 年龄
    GuestDetailSex, //性别
    GuestDetailTripMode, //出行工具
    GuestDetailAppUse, //app偏好
    GuestDetailWork, //工作地
    GuestDetailLive, //居住地
    GuestDetailConsumerPreference,  //消费偏好
    GuestDetailConsumerCategoryPreference,  //消费品类偏好
    GuestDetailAgeConsumerPreference,  //从年龄角度看消费偏好
    GuestDetailDiningConsumerPreference,  //从餐饮角度看消费偏好
    GuestDetailDressConsumerPreference,  //从餐饮角度看消费偏好
    GuestDetailHotMap  //消费热力图
} GuestDetailType;
@interface HQGuestDetailViewController : UIViewController
@property (nonatomic, assign) GuestDetailType type;
@end
