//
//  HQConsumerOrientationDetailVC.h
//  smartGeo
//
//  Created by HeQin on 2018/5/10.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ConsumerOrientationDetailAge = 0, // 年龄
    ConsumerOrientationDetailSex, //性别
    ConsumerOrientationDetailGrade, //消费等级
    ConsumerOrientationDetailOccupation, //职业
    ConsumerOrientationDetailMotivation, //消费动机
    ConsumerOrientationDetailOpenSpace, //寻找空当
    ConsumerOrientationDetailProductCategory,  //创建新的产品类别
    ConsumerOrientationDetailSecondBrand,  //把自己定位为第二品牌
    ConsumerOrientationDetailSpecialist,  //聚焦成为专家
    ConsumerOrientationDetailChannelBrand,  //创建渠道品牌
    ConsumerOrientationDetailSexBrand  //创建行性别品牌
} ConsumerOrientationDetailType;
@interface HQConsumerOrientationDetailVC : UIViewController
@property (nonatomic, assign) ConsumerOrientationDetailType type;
@end
