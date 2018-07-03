//
//  HQHomeViewController.m
//  smartGeo
//
//  Created by HeQin on 2018/3/21.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQHomeViewController.h"
#import "UIView_extra.h"
#import "MainView.h"
#import "MCCustomBar.h"
#import "DynamicView.h"
#import "ArticleView.h"
#import "MoreView.h"
#import "HomeLastView.h"
#import "HQSearchViewController.h"
#import "HQHomeScrollViewDelegate.h"
#import "HQSearchBar.h"

#define ItemTintColor [UIColor colorWithRed:227.0/255.0 green:116.0/255.0 blue:98.0/255.0 alpha:1]
#define ItemNorTintColor [UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1]

const CGFloat headW = 70;
const CGFloat navH = 64;
const CGFloat sectionBarH = 46;

@interface HQHomeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITextFieldDelegate,HQHomeScrollViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UIImageView *userHead;
@property (nonatomic, weak)UIScrollView *tableScrollView; //tableView滑动

@property (nonatomic, strong) DynamicView *dynamicView;
@property (nonatomic, strong) ArticleView *articleView;
@property (nonatomic, strong) MoreView *moreView;
@property (nonatomic, strong) HomeLastView *moreView1;
@property (nonatomic, strong) HQSearchBar *searchBar;
@end

@implementation HQHomeViewController
{
    MCCustomBar *_dynamicBar;    //动态
    MCCustomBar *_articleBar; //文章
    MCCustomBar *_moreBar;     //更多
    MCCustomBar *_moreBar1;     //更多
    
    UIView *_bottomLine;
    UIView *_movingLine;
    NSInteger _index;
    CGFloat _tableViewH;
    CGFloat _lastOffset;
    CGFloat _yOffset;
    CGFloat _changW;
    CGFloat _changY;
    UIImage *_headImage;
    BOOL _isUp;
}

-(void)viewDidLoad{
    self.navigationController.navigationBar.translucent = NO;
    [self createTableScrollView];
    
    [self createHeaderView];
    
    [self createUserHead];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_userHead];
    CGFloat headY = _headerView.y;
    if (headY >-200) {
        _searchBar.alpha = 0;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_userHead removeFromSuperview];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGFloat headY = _headerView.y;
    if (headY >-200) {
        _searchBar.alpha = 0;
    }
}
#pragma mark 创建上方头视图
-(void)createHeaderView{
    CGFloat margin = 80;
    CGFloat labelW = [UIScreen mainScreen].bounds.size.width - 2*margin;
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 246)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _yOffset = _headerView.centerY;
    //昵称
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 50, labelW, 30)];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.font = [UIFont systemFontOfSize:13];
    userNameLabel.text = @"慧经营";
    [_headerView addSubview:userNameLabel];
    
    //简介描述
    UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(userNameLabel.frame)+2, labelW, 24)];
    describeLabel.textAlignment = NSTextAlignmentCenter;
    describeLabel.font = [UIFont systemFontOfSize:13];
    [describeLabel setTextColor:[UIColor lightGrayColor]];
    describeLabel.text = @"搜索商铺";
    [_headerView addSubview:describeLabel];
    
    //详细
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(describeLabel.frame)+2, labelW, 24)];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.font = [UIFont systemFontOfSize:13];
    [detailLabel setTextColor:[UIColor lightGrayColor]];
    detailLabel.text = @"搜索位置、优选址";
    [_headerView addSubview:detailLabel];
    
    HQSearchBar *editBtn = [[HQSearchBar alloc] init];
    editBtn.frame = CGRectMake(13, 13, [UIScreen mainScreen].bounds.size.width - 26, 40);
    editBtn.placeholder = @"搜一搜";
    editBtn.delegate = self;
    [editBtn endEditing:YES];
    editBtn.center = CGPointMake(self.view.center.x, CGRectGetMaxY(detailLabel.frame)+30);
    [_headerView addSubview:editBtn];
    
    self.searchBar = [[HQSearchBar alloc] init];
    self.searchBar.frame = CGRectMake(13, 13, [UIScreen mainScreen].bounds.size.width - 26, 40);
    self.searchBar.delegate = self;
    [self.searchBar endEditing:YES];
    self.searchBar.placeholder = @"搜一搜";
    self.navigationItem.titleView = self.searchBar;
    _searchBar.alpha = 0.0;
    [self createSectionView];
    
    [self.view addSubview:_headerView];
    
}

#pragma mark 创建下方tableview
-(void)createTableScrollView{
    CGFloat tableScrollX = 0;
    CGFloat tableScrollY = 0;
    CGFloat tableScrollWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat tableScrollHeight = [UIScreen mainScreen].bounds.size.height - navH;
    
    UIScrollView *tableScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(tableScrollX, tableScrollY, tableScrollWidth, tableScrollHeight)];
    tableScrollView.delegate = self;
    tableScrollView.contentSize = CGSizeMake(4*[UIScreen mainScreen].bounds.size.width, tableScrollHeight);
    tableScrollView.pagingEnabled = YES;
    tableScrollView.alwaysBounceVertical = NO;
    tableScrollView.showsHorizontalScrollIndicator = NO;
    tableScrollView.showsVerticalScrollIndicator = NO;
    tableScrollView.bounces = NO;
    _tableScrollView = tableScrollView;
    
    //动态
    _dynamicView = [[DynamicView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, tableScrollHeight)];
    _dynamicView.tableView.tag = 100;
    _dynamicView.delegate = self;
    [self createTableHeadView:_dynamicView.tableView];
    [_tableScrollView addSubview:_dynamicView];
    
    //文章tableView
    _articleView = [[ArticleView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width,tableScrollHeight)];
    _articleView.tableView.tag = 101;
    _articleView.delegate = self;
    [self createTableHeadView:_articleView.tableView];
    [_tableScrollView addSubview:_articleView];
    
    //更多tableView
    _moreView = [[MoreView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*2, 0, [UIScreen mainScreen].bounds.size.width, tableScrollHeight)];
    _moreView.tableView.tag = 102;
    _moreView.delegate = self;
    [self createTableHeadView:_moreView.tableView];
    [_tableScrollView addSubview:_moreView];
    
    //更多tableView
    _moreView1 = [[HomeLastView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*3, 0, [UIScreen mainScreen].bounds.size.width, tableScrollHeight)];
    _moreView1.tableView.tag = 103;
    _moreView1.delegate = self;
    [self createTableHeadView:_moreView1.tableView];
    [_tableScrollView addSubview:_moreView1];
    
    [self.view addSubview:_tableScrollView];
    
}

-(void)createTableHeadView:(UITableView *)tableView{
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 246)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableHeaderView = tableHeaderView;
    tableView.backgroundColor = [UIColor whiteColor];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self editBtnClick];
    return NO;
}

-(void)editBtnClick{
    self.hidesBottomBarWhenPushed=YES;
    HQSearchViewController *search = [[HQSearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//绘制线
- (UIView *)createLineWithWidth:(CGFloat)width andHeight:(CGFloat)height andColor:(UIColor *)color{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    line.backgroundColor = color;
    
    return line;
}
#pragma mark 创建段头
-(void)createSectionView{
    _sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, sectionBarH)];
    _sectionView.backgroundColor = [UIColor whiteColor];
    
    //划线
    UIView *topLine = [self createLineWithWidth:[UIScreen mainScreen].bounds.size.width andHeight:1 andColor:[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1]];
    [topLine setOrigin:CGPointMake(0,0)];
    [_sectionView addSubview:topLine];
    
    CGFloat ControlBarWidth = [UIScreen mainScreen].bounds.size.width/4;
    CGFloat ControlBarheight = 30;
    CGFloat ControlBarY =  CGRectGetMaxY(topLine.frame) + 7;
    CGSize barSize = CGSizeMake(ControlBarWidth, ControlBarheight);
    
    //动态bar
    _dynamicBar = [[MCCustomBar alloc]initWithCount:@"0" andName:@"地产新闻" size:barSize];
    [_dynamicBar addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    _dynamicBar.tag = 0;
    _dynamicBar.nameLabel.textColor = ItemTintColor;
    [_dynamicBar setOrigin:CGPointMake(0, ControlBarY)];
    [_sectionView addSubview:_dynamicBar];
    //文章bar
    _articleBar = [[MCCustomBar alloc]initWithCount:@"0" andName:@"经营秘笈" size:barSize];
    [_articleBar addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    _articleBar.tag = 1;
    [_articleBar setOrigin:CGPointMake(ControlBarWidth, ControlBarY)];
    [_sectionView addSubview:_articleBar];
    //更多bar
    _moreBar = [[MCCustomBar alloc]initWithCount:@"0" andName:@"行业爆品" size:barSize];
    [_moreBar addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    _moreBar.tag = 2;
    [_moreBar setOrigin:CGPointMake(2*ControlBarWidth, ControlBarY)];
    [_sectionView addSubview:_moreBar];
    //更多bar
    _moreBar1 = [[MCCustomBar alloc]initWithCount:@"0" andName:@"消费升级" size:barSize];
    [_moreBar1 addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    _moreBar1.tag = 3;
    [_moreBar1 setOrigin:CGPointMake(3*ControlBarWidth, ControlBarY)];
    [_sectionView addSubview:_moreBar1];
    
    //划线
    
    _bottomLine = [self createLineWithWidth:[UIScreen mainScreen].bounds.size.width andHeight:1 andColor:[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1]];
    [_bottomLine setOrigin:CGPointMake(0, CGRectGetMaxY(_dynamicBar.frame) + 8)];
    [_sectionView addSubview:_bottomLine];
    
    //创建移动下划线
    _movingLine = [self createLineWithWidth:35 andHeight:2 andColor:ItemTintColor];
    _movingLine.center = CGPointMake(_dynamicBar.centerX, 0);
    [_bottomLine addSubview:_movingLine];
    
    [_headerView addSubview:_sectionView];
}

- (void)changeView :(MCCustomBar *)sender{
    
    _index = sender.tag;
    [self moveLine:_index];
    
    if ([_dynamicBar isEqual:sender]) {
        
        [self changeItemTintColor:(MCCustomBar *)sender];
        [_tableScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        _dynamicBar.nameLabel.textColor = ItemTintColor;
        _articleBar.selected = NO;
        _moreBar.selected = NO;
        _moreBar1.selected = NO;
    }else if ([_articleBar isEqual:sender]){
        
        [self changeItemTintColor:(MCCustomBar *)sender];
        [_tableScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:NO];
        _articleBar.nameLabel.textColor = ItemTintColor;
        _dynamicBar.selected = NO;
        _moreBar.selected = NO;
        _moreBar1.selected = NO;
    }else if ([_moreBar isEqual:sender]){
        
        [self changeItemTintColor:(MCCustomBar *)sender];
        [_tableScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width*2, 0) animated:NO];
        _moreBar.nameLabel.textColor = ItemTintColor;
        _dynamicBar.selected = NO;
        _articleBar.selected = NO;
        _moreBar1.selected = NO;
    }else {
        [self changeItemTintColor:(MCCustomBar *)sender];
        [_tableScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width*3, 0) animated:NO];
        _moreBar1.nameLabel.textColor = ItemTintColor;
        _dynamicBar.selected = NO;
        _articleBar.selected = NO;
        _moreBar.selected = NO;
    }
}

#pragma mark 创建头像，
#warning 头像的center设置不了，设置的center坐标，最终却成了origin的坐标，很郁闷。
-(void)createUserHead{
    CGFloat centerX = self.view.centerX;
    _userHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_logo"]];
    _userHead.layer.cornerRadius = 35;
    _userHead.layer.masksToBounds = YES;
    _userHead.size = CGSizeMake(headW, headW);
    _userHead.origin = CGPointMake(centerX - 35, 9);
    [self.navigationController.navigationBar addSubview:_userHead];
//    CGFloat centerX = self.view.centerX;
//    _userHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hone_logo"]];
//    _userHead.size = CGSizeMake(headW, 60);
//    _userHead.origin = CGPointMake(centerX - 100, 10);
}

-(void)moveLine:(NSInteger)sender
{
    CGFloat lineX;
    if (sender == 0) {
        lineX = _dynamicBar.centerX;
    }else if (sender == 1){
        lineX = _articleBar.centerX;
    }else if(sender == 2){
        lineX = _moreBar.centerX;
    }else{
        lineX = _moreBar1.centerX;
    }
    [UIView animateWithDuration:0.2 animations:^{
        _movingLine.center = CGPointMake(lineX, 0);
    }];
}

-(void)changeItemTintColor:(MCCustomBar *)sender
{
    if (![_dynamicBar isEqual:sender]) {
        
        _dynamicBar.nameLabel.textColor = ItemNorTintColor;
        
    }
    if (![_articleBar isEqual:sender]){
        
        _articleBar.nameLabel.textColor = ItemNorTintColor;
    }
    if (![_moreBar isEqual:sender]){
        
        _moreBar.nameLabel.textColor = ItemNorTintColor;
    }
    if (![_moreBar1 isEqual:sender]){
        
        _moreBar1.nameLabel.textColor = ItemNorTintColor;
    }
}

#pragma mark scrollView
#warning 不知道为什么滑动的时候，慢的时候头像缩放还OK，但快的时候，就出现问题。。。
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_tableScrollView]) {
        _index = _tableScrollView.bounds.origin.x/_tableScrollView.bounds.size.width;
        [self moveLine:_index];
        return;
    }
    
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat scale = 1.0;
    // 放大
    if (offsetY < 0) {
        _searchBar.alpha = 0.0;
        _userHead.alpha = 1;
    } else if (offsetY >= 0) { // 缩小
        // 允许向上超过导航条缩小的最大距离为200
        // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
        // 头像最小是31.5像素
        scale = MAX(0.45, 1 - offsetY / 200 *0.5);
        
        _userHead.transform = CGAffineTransformMakeScale(scale, scale);
        
        // 保证缩放后y坐标不变
        CGRect frame = _userHead.frame;
        frame.origin.y = 5;
        _userHead.frame = frame;
        if (offsetY >200) {
            CGFloat alpha = MIN(1, (offsetY-200)/ 60);
            _searchBar.alpha = alpha;
            _userHead.alpha = 1-alpha;
        }else{
            _searchBar.alpha = 0.0;
            _userHead.alpha = 1;
        }
    }
    
    
    if (scrollView.contentOffset.y > 200) {
        _headerView.center = CGPointMake(_headerView.center.x, _yOffset - 200);
        return;
    }
    CGFloat h = _yOffset - offsetY;
    _headerView.center = CGPointMake(_headerView.center.x, h);
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if ([scrollView isEqual:_tableScrollView]) {
        
        if (_index == 0) {
            [self changeView:_dynamicBar];
        }else if (_index == 1){
            [self changeView:_articleBar];
        }else if (_index == 2){
            [self changeView:_moreBar];
        }else{
             [self changeView:_moreBar1];
        }
        
        return;
    }
    
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:_tableScrollView]) {
        return;
    }
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}

//设置tableView的偏移量
-(void)setTableViewContentOffsetWithTag:(NSInteger)tag contentOffset:(CGFloat)offset{
    
    CGFloat tableViewOffset = offset;
    if(offset > 200){
        
        tableViewOffset = 200;
    }
    if (tag == 100) {
        [_articleView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_moreView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_moreView1.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }else if(tag == 101){
        
        [_dynamicView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_moreView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_moreView1.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }else if (tag == 102){
        
        [_dynamicView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_articleView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_moreView1.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }else {
        [_dynamicView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_articleView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_moreView.tableView setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }
}


@end
