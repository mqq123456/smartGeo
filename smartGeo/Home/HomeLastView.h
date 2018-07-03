//
//  HomeLastView.h
//  smartGeo
//
//  Created by HeQin on 2018/4/1.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HQHomeScrollViewDelegate.h"

@interface HomeLastView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, weak) id<HQHomeScrollViewDelegate> delegate;
@end

