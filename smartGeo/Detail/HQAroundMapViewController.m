//
//  HQAroundMapViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/3/28.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQAroundMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>


@interface HQAroundMapViewController ()<BMKMapViewDelegate,UITabBarDelegate>
{
    BMKMapView* _mapView;
    NSArray *_data;
    NSInteger _selectedIndex;
    NSMutableArray *_selectedArray;
}
@end

@implementation HQAroundMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"周边信息";
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _mapView = mapView;
    _mapView.delegate = self;
    self.view = mapView;
    _selectedArray = [NSMutableArray array];
    _selectedIndex = -1;
    
    
    
    BMKPointAnnotation* animation = [[BMKPointAnnotation alloc]init];
    animation.coordinate = CLLocationCoordinate2DMake(40.004068,116.488659);
    [_mapView addAnnotation:animation];
    
    // 创建一个工具条，并设置它的大小和位置
    [[UITabBarItem appearance] setTitleTextAttributes:  [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    
    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 64-46, [UIScreen mainScreen].bounds.size.width, 46)];
    
    UITabBarItem *item0 = [[UITabBarItem alloc] init];
    item0.image = [[UIImage imageNamed:@"icon_ditie_normel"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.selectedImage = [[UIImage imageNamed:@"icon_ditie_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.title = @"地铁";
    
    UITabBarItem *item1 = [[UITabBarItem alloc] init];
    item1.image = [[UIImage imageNamed:@"icon_gongjiao_normel"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"icon_gongjiao_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.title = @"公交";
    
    UITabBarItem *item2 = [[UITabBarItem alloc] init];
    item2.image = [[UIImage imageNamed:@"icon_yiyuan_normel"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"icon_yiyuan_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.title = @"医院";
    UITabBarItem *item3 = [[UITabBarItem alloc] init];
    item3.image = [[UIImage imageNamed:@"icon_yinhang_normel"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"icon_yinhang_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.title = @"银行";
    UITabBarItem *item4 = [[UITabBarItem alloc] init];
    item4.image = [[UIImage imageNamed:@"icon_canyin_normel"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = [[UIImage imageNamed:@"icon_canyin_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.title = @"美食";
    UITabBarItem *item5 = [[UITabBarItem alloc] init];
    item5.image = [[UIImage imageNamed:@"icon_shaoshi_normel"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item5.selectedImage = [[UIImage imageNamed:@"icon_shaoshi_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item5.title = @"购物";
    [tabBar setItems:@[item0,item1,item2,item3,item4,item5]];
    item0.tag = 100;
    item1.tag = 101;
    item2.tag = 102;
    item3.tag = 103;
    item4.tag = 104;
    item5.tag = 105;
    [self.view addSubview:tabBar];
    tabBar.delegate = self;
    _data = @[@[@"116.49344,40.009392",@"116.475977,40.004197",@"116.477774,39.998007",@"116.488482,39.990545",@"116.457364,40.001821",@"116.473821,40.016134"],
  @[@"116.488545,40.003624",@"116.485535,40.003465",@"116.484969,40.002442",@"116.490188,39.999983",@"116.485392,40.006739",@"116.483793,40.004211"],
              @[@"116.490449,40.002691",@"116.498606,39.995098",@"116.479593,39.988489",@"116.467178,40.002246"],
              @[@"116.491082,40.005182",@"116.492789,40.006536",@"116.489232,40.0038",@"116.489789,39.995979",@"116.485495,39.995564",@"116.480482,39.999931",@"116.481955,40.00391",@"116.482764,40.007144",@"116.479207,40.0017"],
              @[@"116.488594,40.004",@"116.487067,40.00237",@"116.484246,40.004622",@"116.490858,40.001928",@"116.494307,40.001955",@"116.480204,40.002204",@"116.496589,40.004387",@"116.491199,39.996787",@"116.489079,39.995461"],
              @[@"116.488612,39.996566",@"116.487911,39.99325",@"116.483276,39.995226",@"116.48872,40.004263",@"116.485612,39.99155",@"116.475658,39.998653"]];
   
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSArray *arr = _data[item.tag - 100];
    [_mapView removeAnnotations:_selectedArray];
    
    [_selectedArray removeAllObjects];
    _selectedIndex = item.tag - 100;
    for (int i = 0; i <arr.count; i++) {
        BMKPointAnnotation* animation = [[BMKPointAnnotation alloc]init];
        NSArray *latlon = [arr[i] componentsSeparatedByString:@","];
        double lat = [latlon[1] doubleValue];
        double lon = [latlon[0] doubleValue];
        animation.coordinate = CLLocationCoordinate2DMake(lat, lon);
        [_mapView addAnnotation:animation];
        [_selectedArray addObject:animation];
    }
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(40.003655,116.48942)];
    [_mapView setZoomLevel:16];
}

#pragma mark - BMKMapViewDelegate
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(40.003655,116.48942)];
    [_mapView setZoomLevel:16];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        if (_selectedIndex == 0) {
            newAnnotationView.image = [UIImage imageNamed:@"icon_ditie_selected"];
        }else if (_selectedIndex == 1) {
            newAnnotationView.image = [UIImage imageNamed:@"icon_gongjiao_selected"];
        }else if (_selectedIndex == 2) {
            newAnnotationView.image = [UIImage imageNamed:@"icon_yiyuan_selected"];
        }else if (_selectedIndex == 3) {
            newAnnotationView.image = [UIImage imageNamed:@"icon_yinhang_selected"];
        }else if (_selectedIndex == 4) {
            newAnnotationView.image = [UIImage imageNamed:@"icon_canyin_selected"];
        }else if(_selectedIndex == 5){
            newAnnotationView.image = [UIImage imageNamed:@"icon_shaoshi_selected"];
        }else{
            
        }
        return newAnnotationView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
