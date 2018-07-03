//
//  HQConsumerDetailViewController.h
//  smartGeo
//
//  Created by HeQin on 2018/5/10.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ConsumerDetailCategory = 0, // 种类
    ConsumerDetailDining, //餐饮
    ConsumerDetailChildren, //儿童
    ConsumerDetailLeisure //休闲
} ConsumerDetailType;
@interface HQConsumerDetailViewController : UIViewController
@property (nonatomic, assign) ConsumerDetailType type;
@end
