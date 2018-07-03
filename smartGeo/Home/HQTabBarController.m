//
//  HQTabBarController.m
//  smartGeo
//
//  Created by HeQin on 2018/3/21.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQTabBarController.h"
#import "HQHomeViewController.h"
#import "HQBlogViewController.h"

@interface HQTabBarController ()

@end

@implementation HQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建子控制器
    HQHomeViewController *homeVC=[[HQHomeViewController alloc] init];
    UINavigationController *homeNC = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    HQBlogViewController *blogVC=[[HQBlogViewController alloc] init];
    blogVC.navigationItem.title = @"论坛";
    blogVC.tabBarItem.title = @"论坛";
    UINavigationController *blogNC = [[UINavigationController alloc]initWithRootViewController:blogVC];

    // 把子控制器添加到UITabBarController
    self.viewControllers = @[homeNC, blogNC];
    
    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
    item0.image = [[UIImage imageNamed:@"icon_hone_normel"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.selectedImage = [[UIImage imageNamed:@"icon_hone_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.title = @"首页";
    
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:1];
    item1.image = [[UIImage imageNamed:@"icon_blong_normel"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"icon_blong_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.title = @"论坛";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
