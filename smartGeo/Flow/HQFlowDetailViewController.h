//
//  HQFlowDetailViewController.h
//  smartGeo
//
//  Created by HeQin on 2018/5/10.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    FlowDetailMinute = 0, // 特定时段
    FlowDetailHour, //小时为单位
    FlowDetailHighHour, //高峰小时
    FlowDetailYear, //年最大小时流量
    FlowDetailDay, //平均日交通流量
    FlowDetailMonth, //平均月交通流量
    FlowDetailPedestrian,  //行人交通流量
    FlowDetailWorkDay,  //工作日
    FlowDetailWeekDay,  //休息日
    FlowDetailSpecial  //特殊日期
} FlowDetailType;
@interface HQFlowDetailViewController : UIViewController
@property (nonatomic ,assign) FlowDetailType type;
@end
