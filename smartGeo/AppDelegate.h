//
//  AppDelegate.h
//  smartGeo
//
//  Created by HeQin on 2018/3/21.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

