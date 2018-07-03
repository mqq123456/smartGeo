//
//  DynamicView.m
//  简书userCenter
//
//  Created by 周陆洲 on 16/4/19.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "DynamicView.h"
#import "SDRefresh.h"

#import "SDTimeLineTableHeaderView.h"
#import "SDTimeLineRefreshHeader.h"
#import "SDTimeLineRefreshFooter.h"
#import "SDTimeLineCell.h"
#import "SDTimeLineCellModel.h"

#import "UITableView+SDAutoTableViewCellHeight.h"

#import "UIView+SDAutoLayout.h"
#import "LEETheme.h"
#import "GlobalDefines.h"

#define kTimeLineTableViewCellId @"SDTimeLineCell"
static CGFloat textFieldH = 40;

@interface DynamicView ()<SDTimeLineCellDelegate, UITextFieldDelegate>
{
    SDTimeLineRefreshFooter *_refreshFooter;
    SDTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, copy) NSString *commentToUser;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DynamicView
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, frame.size.height);
        [self addSubview:self.tableView];
        //为self.view 添加背景颜色设置
        
        self.lee_theme
        .LeeAddBackgroundColor(DAY , [UIColor whiteColor])
        .LeeAddBackgroundColor(NIGHT , [UIColor blackColor]);
        [self.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
        [LEETheme startTheme:DAY];
        __weak typeof(self) weakSelf = self;
        
        // 上拉加载
        _refreshFooter = [SDTimeLineRefreshFooter refreshFooterWithRefreshingText:@"正在加载数据..."];
        __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
        [_refreshFooter addToScrollView:self.tableView refreshOpration:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.dataArray addObjectsFromArray:[weakSelf creatModelsWithCount:10]];
                
                /**
                 [weakSelf.tableView reloadDataWithExistedHeightCache]
                 作用等同于
                 [weakSelf.tableView reloadData]
                 只是“reloadDataWithExistedHeightCache”刷新tableView但不清空之前已经计算好的高度缓存，用于直接将新数据拼接在旧数据之后的tableView刷新
                 */
                [weakSelf.tableView reloadDataWithExistedHeightCache];
                
                [weakRefreshFooter endRefreshing];
            });
        }];
        
        //添加分隔线颜色设置
        
        self.tableView.lee_theme
        .LeeAddSeparatorColor(DAY , [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f])
        .LeeAddSeparatorColor(NIGHT , [[UIColor grayColor] colorWithAlphaComponent:0.5f]);
        
        [self.tableView registerClass:[SDTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
        
        
    
    }
    return self;
}

- (NSArray *)creatModelsWithCount:(NSInteger)count
{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"梦溪影谈",
                            @"蔡鸿岩",
                            @"温暖的夏天的主场",
                            @"办公选址-赵远",
                            @"中装协设计网"];
    
    NSArray *textArray = @[@"北京望京SOHO 潘石屹地产，都是风光，建筑摄影，摄影，汇图网www.huitu.com",
                           @"2017年12月6日,以促进智慧社区、智能家居、物联网产品的市场发展为宗旨的“综合地产与物联网的实践应用沙龙”在北京望京悠乐汇纳什空间成功举办。",
                           @"蕴实地产，本店  已 北京市  朝阳区   望京  酒仙桥 来广营  东湖渠  大山子 出租房屋为主  欢迎新老客户 常进来看看  ",
                           @"十月总结大会圆满落幕\n人均业绩持续领跑商业地产公司\n一群人、一条心、干一件事！\n打造最懂你的商业地产平台！国贸、CBD、望京、金融街、中关村、三元桥、东二环、亦庄…………辐射你能想到的所有区域！\n欢迎有志之士加盟！我们等你  ​",
                           @"东方美学设计，雅奢时尚范儿(1)  http://t.cn/RODDCvV\n望京湖光壹号\n项目名称：昆泰地产 望京湖光壹号\n项目名称：\n项目地址：中国北京\n项目面积：260平方米\n空间设计：李玮珉建筑师事务所\n陈设设计：纳沃设计\n创意总监：岳晓瑞\n主案设计师：陈晓雷\n设计师：李嫣然 ​"
                           ];
    
    NSArray *commentsArray = @[];
    
    NSArray *picImageNamesArray = @[ @[@"IMG_1160.PNG"],
                                     @[@"IMG_1161.PNG",
                                       @"IMG_1162.PNG",
                                       @"IMG_1163.JPG"],
                                     @[@"IMG_1164.JPG"],
                                     @[@"IMG_1165.JPG",
                                     @"IMG_1167.JPG",
                                     @"IMG_1166.JPG",
                                     @"IMG_1169.JPG"],
                                     @[@"IMG_1171.JPG",
                                     @"IMG_1172.JPG",
                                     @"IMG_1170.JPG",
                                     @"IMG_1173.JPG",
                                     @"IMG_1174.JPG",
                                     @"IMG_1175.JPG",
                                     @"IMG_1176.JPG",
                                     @"IMG_1177.JPG",
                                     @"IMG_1178.JPG"]
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        
        SDTimeLineCellModel *model = [SDTimeLineCellModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[iconRandomIndex];
        model.msgContent = textArray[iconRandomIndex];
        model.picNamesArray = picImageNamesArray[iconRandomIndex];
        model.commentItemsArray = [NSArray array];
        
        model.likeItemsArray = [NSArray array];
        
        
        [resArr addObject:model];
    }
    return [resArr copy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            SDTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        [cell setDidClickCommentLabelBlock:^(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath) {
            weakSelf.textField.placeholder = [NSString stringWithFormat:@"  回复：%@", commentId];
            weakSelf.currentEditingIndexthPath = indexPath;
            [weakSelf.textField becomeFirstResponder];
            weakSelf.isReplayingComment = YES;
            weakSelf.commentToUser = commentId;
            [weakSelf adjustTableViewToFitKeyboardWithRect:rectInWindow];
        }];
        
        cell.delegate = self;
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SDTimeLineCell class] contentViewWidth:[self cellContentViewWith]];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_textField resignFirstResponder];
    _textField.placeholder = nil;
}



- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


#pragma mark - SDTimeLineCellDelegate

- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell
{
    [_textField becomeFirstResponder];
    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    
    [self adjustTableViewToFitKeyboard];
    
}

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    SDTimeLineCellModel *model = self.dataArray[index.row];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.likeItemsArray];
    
    if (!model.isLiked) {
        SDTimeLineCellLikeItemModel *likeModel = [SDTimeLineCellLikeItemModel new];
        likeModel.userName = @"GSD_iOS";
        likeModel.userId = @"gsdios";
        [temp addObject:likeModel];
        model.liked = YES;
    } else {
        SDTimeLineCellLikeItemModel *tempLikeModel = nil;
        for (SDTimeLineCellLikeItemModel *likeModel in model.likeItemsArray) {
            if ([likeModel.userId isEqualToString:@"gsdios"]) {
                tempLikeModel = likeModel;
                break;
            }
        }
        [temp removeObject:tempLikeModel];
        model.liked = NO;
    }
    model.likeItemsArray = [temp copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    });
}


- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}

- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [self.tableView setContentOffset:offset animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [_textField resignFirstResponder];
        
        SDTimeLineCellModel *model = self.dataArray[_currentEditingIndexthPath.row];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentItemsArray];
        SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
        
        if (self.isReplayingComment) {
            commentItemModel.firstUserName = @"GSD_iOS";
            commentItemModel.firstUserId = @"GSD_iOS";
            commentItemModel.secondUserName = self.commentToUser;
            commentItemModel.secondUserId = self.commentToUser;
            commentItemModel.commentString = textField.text;
            
            self.isReplayingComment = NO;
        } else {
            commentItemModel.firstUserName = @"GSD_iOS";
            commentItemModel.commentString = textField.text;
            commentItemModel.firstUserId = @"GSD_iOS";
        }
        [temp addObject:commentItemModel];
        model.commentItemsArray = [temp copy];
        [self.tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
        
        _textField.text = @"";
        _textField.placeholder = nil;
        
        return YES;
    }
    return NO;
}



- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _textField.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + textFieldH;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
}
#pragma mark scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.delegate scrollViewDidScroll:scrollView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.delegate scrollViewDidEndDecelerating:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

@end
