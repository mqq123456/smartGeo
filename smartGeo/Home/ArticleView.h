//
//  ArticleView.h
//  简书userCenter
//
//  Created by 周陆洲 on 16/4/19.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQHomeScrollViewDelegate.h"

@interface ArticleView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, weak) id<HQHomeScrollViewDelegate> delegate;
@end
