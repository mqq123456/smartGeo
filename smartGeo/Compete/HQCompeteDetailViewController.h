//
//  HQCompeteDetailViewController.h
//  smartGeo
//
//  Created by HeQin on 2018/5/10.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    CompeteDetailSuppliersBargain = 0, // 供应商的议价
    CompeteDetailPurchaserBargain, //购买者的议价
    CompeteDetailNewEntrants, //新近入者
    CompeteDetailSubstitute, //替代品
    CompeteDetailPeer //同行
} CompeteDetailType;
@interface HQCompeteDetailViewController : UIViewController
@property (nonatomic, assign) CompeteDetailType type;
@end
