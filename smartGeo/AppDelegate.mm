//
//  AppDelegate.m
//  smartGeo
//
//  Created by HeQin on 2018/3/21.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "AppDelegate.h"
#import "HQTabBarController.h"
#import "HQHomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"bKaTlDVX1t81NNOtS8ZOgyS8DSZnKTtI"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *navi =[[UINavigationController alloc] initWithRootViewController:[[HQHomeViewController alloc] init]];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
