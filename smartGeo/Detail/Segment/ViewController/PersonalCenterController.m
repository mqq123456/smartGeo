//
//  PersonalCenterController.m
//  PersonalHomePageDemo
//
//  Created by Kegem Huang on 2017/3/15.
//  Copyright © 2017年 huangkejin. All rights reserved.
//

#import "PersonalCenterController.h"
#import "PersonalCenterTableView.h"
#import "ContentViewCell.h"
#import "HFStretchableTableHeaderView.h"
#import "YUSegment.h"
#import "DLUserPageNavBar.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "DLUserHeaderView.h"
@interface PersonalCenterController ()<UITableViewDelegate, UITableViewDataSource,DLUserPageNavBarDelegate>
//tableView
@property (strong, nonatomic) PersonalCenterTableView *tableView;
//下拉头部放大控件
@property (strong, nonatomic) HFStretchableTableHeaderView* stretchableTableHeaderView;
//分段控制器
@property (strong, nonatomic) YUSegment *segment;
//YES代表能滑动
@property (nonatomic, assign) BOOL canScroll;
//pageViewController
@property (strong, nonatomic) ContentViewCell *contentCell;
//导航栏的背景view
@property (strong, nonatomic) DLUserPageNavBar *userPageNavBar;

@end

//得到屏幕width
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation PersonalCenterController

-(DLUserPageNavBar *)userPageNavBar
{
    if (!_userPageNavBar) {
        _userPageNavBar = [DLUserPageNavBar userPageNavBar];
        _userPageNavBar.delegate = self;
        _userPageNavBar.dl_alpha = 0;
        _userPageNavBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    }
    return _userPageNavBar;
}


-(YUSegment *)segment
{
    if (!_segment) {
        _segment = [[YUSegment alloc] initWithTitles:@[@"详情",@"分析",@"点评"]];
        _segment.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
        _segment.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
        _segment.textColor = [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00];
        _segment.selectedTextColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.00];
        _segment.indicator.backgroundColor = [UIColor colorWithRed:0.08 green:0.77 blue:1.00 alpha:1.00];
        [_segment addTarget:self action:@selector(onSegmentChange) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self dl_uiConfig];
    [self dl_addNotification];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 滚动到指定位置
    if (self.tableView.contentOffset.y <_stretchableTableHeaderView.view.frame.size.height) {
        NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:NO];
        self.navigationController.navigationBarHidden = NO;
    }
    
}

-(void)dl_uiConfig
{
    
    self.tableView = [[PersonalCenterTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.canScroll = YES;
    
    self.title = @"";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.userPageNavBar];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    [ContentViewCell regisCellForTableView:self.tableView];
    
    DLUserHeaderView *headerView = [DLUserHeaderView userHeaderView];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH  / 1.34 );
    _stretchableTableHeaderView = [HFStretchableTableHeaderView new];
    [_stretchableTableHeaderView stretchHeaderForTableView:self.tableView withView:headerView];
}

-(void)dl_addNotification
{
    //通知的处理，本来也不需要这么多通知，只是写一个简单的demo，所以...根据项目实际情况进行优化吧
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPageViewCtrlChange:) name:@"CenterPageViewScroll" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOtherScrollToTop:) name:@"kLeaveTopNtf" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScrollBottomView:) name:@"PageViewGestureState" object:nil];
}


///通知的处理
//pageViewController页面变动时的通知
- (void)onPageViewCtrlChange:(NSNotification *)ntf {
    //更改YUSegment选中目标
    self.segment.selectedIndex = [ntf.object integerValue];
}

//子控制器到顶部了 主控制器可以滑动
- (void)onOtherScrollToTop:(NSNotification *)ntf {
    self.canScroll = YES;
    self.contentCell.canScroll = NO;
}

//当滑动下面的PageView时，当前要禁止滑动
- (void)onScrollBottomView:(NSNotification *)ntf {
//    if ([ntf.object isEqualToString:@"ended"]) {
//        //bottomView停止滑动了  当前页可以滑动
//        self.tableView.scrollEnabled = YES;
//    } else {
//        //bottomView滑动了 当前页就禁止滑动
//        self.tableView.scrollEnabled = NO;
//    }
}

//监听segment的变化
- (void)onSegmentChange {
    //改变pageView的页码
    self.contentCell.selectIndex = self.segment.selectedIndex;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //要减去导航栏 状态栏 以及 sectionheader的高度
    return self.view.frame.size.height-44-64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //sectionheader的高度，这是要放分段控件的
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.segment;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.contentCell) {
        self.contentCell = [ContentViewCell dequeueCellForTableView:tableView];
        self.contentCell.navi = self.navigationController;
        self.contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentCell setPageView];
    }
    return self.contentCell;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //下拉放大 必须实现
    [_stretchableTableHeaderView scrollViewDidScroll:scrollView];
    
    //计算导航栏的透明度
    CGFloat minAlphaOffset = 0;
    CGFloat maxAlphaOffset = SCREEN_WIDTH  / 1.34 - 64;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    self.userPageNavBar.dl_alpha = alpha;

    //根据导航栏透明度设置title
    if (alpha > 0.5) {
        self.title = @"新荟城";
    } else {
        self.title = @"";
    }

    //子控制器和主控制器之间的滑动状态切换
    CGFloat tabOffsetY = [_tableView rectForSection:0].origin.y-64;
    if (scrollView.contentOffset.y >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        if (_canScroll) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kScrollToTopNtf" object:@1];
            _canScroll = NO;
            self.contentCell.canScroll = YES;
        }
    } else {
        if (!_canScroll) {
            scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        }
    }
}

#pragma mark - DLUserPageNavBarDelegate
-(void)userPagNavBar:(DLUserPageNavBar *)navBar didClickButton:(DLUserPageButtonType)buttonType
{
    [self.navigationController popViewControllerAnimated:YES];
}

//下拉放大必须实现
- (void)viewDidLayoutSubviews {
    [_stretchableTableHeaderView resizeView];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
