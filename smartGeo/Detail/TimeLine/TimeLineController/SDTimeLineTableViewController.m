//
//  SDTimeLineTableViewController.m
//  GSD_WeiXin(wechat)
//
//  Created by gsd on SDRefresh.h16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//



#import "SDTimeLineTableViewController.h"

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

@interface SDTimeLineTableViewController () <SDTimeLineCellDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, copy) NSString *commentToUser;

@end

@implementation SDTimeLineTableViewController

{
    SDTimeLineRefreshFooter *_refreshFooter;
    SDTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}
- (UINavigationController *)navigationController {
    return _navigationController;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //为self.view 添加背景颜色设置
    
    self.view.lee_theme
    .LeeAddBackgroundColor(DAY , [UIColor whiteColor])
    .LeeAddBackgroundColor(NIGHT , [UIColor blackColor]);
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    [LEETheme startTheme:DAY];
//    __weak typeof(self) weakSelf = self;
//
//
//    // 上拉加载
//    _refreshFooter = [SDTimeLineRefreshFooter refreshFooterWithRefreshingText:@"正在加载数据..."];
//    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
//    [_refreshFooter addToScrollView:self.tableView refreshOpration:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.dataArray addObjectsFromArray:[weakSelf creatModelsWithCount:10]];
//
//            /**
//             [weakSelf.tableView reloadDataWithExistedHeightCache]
//             作用等同于
//             [weakSelf.tableView reloadData]
//             只是“reloadDataWithExistedHeightCache”刷新tableView但不清空之前已经计算好的高度缓存，用于直接将新数据拼接在旧数据之后的tableView刷新
//             */
//            [weakSelf.tableView reloadDataWithExistedHeightCache];
//
//            [weakRefreshFooter endRefreshing];
//        });
//    }];

    //添加分隔线颜色设置
    
    self.tableView.lee_theme
    .LeeAddSeparatorColor(DAY , [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f])
    .LeeAddSeparatorColor(NIGHT , [[UIColor grayColor] colorWithAlphaComponent:0.5f]);
    
    [self.tableView registerClass:[SDTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    
//    [self setupTextField];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if (!_refreshHeader.superview) {
//
//        _refreshHeader = [SDTimeLineRefreshHeader refreshHeaderWithCenter:CGPointMake(40, 45)];
//        _refreshHeader.scrollView = self.tableView;
//        __weak typeof(_refreshHeader) weakHeader = _refreshHeader;
//        __weak typeof(self) weakSelf = self;
//        [_refreshHeader setRefreshingBlock:^{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                weakSelf.dataArray = [[weakSelf creatModelsWithCount:10] mutableCopy];
//                [weakHeader endRefreshing];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakSelf.tableView reloadData];
//                });
//            });
//        }];
//        [self.tableView.superview addSubview:_refreshHeader];
//    } else {
//        [self.tableView.superview bringSubviewToFront:_refreshHeader];
//    }
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [_textField resignFirstResponder];
//}

- (void)dealloc
{
//    [_refreshHeader removeFromSuperview];
//    [_refreshFooter removeFromSuperview];
//
//    [_textField removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    
    //为textfield添加背景颜色 字体颜色的设置 还有block设置 , 在block中改变它的键盘样式 (当然背景颜色和字体颜色也可以直接在block中写)
    
    _textField.lee_theme
    .LeeAddBackgroundColor(DAY , [UIColor whiteColor])
    .LeeAddBackgroundColor(NIGHT , [UIColor blackColor])
    .LeeAddTextColor(DAY , [UIColor blackColor])
    .LeeAddTextColor(NIGHT , [UIColor grayColor])
    .LeeAddCustomConfig(DAY , ^(UITextField *item){
        
        item.keyboardAppearance = UIKeyboardAppearanceDefault;
        if ([item isFirstResponder]) {
            [item resignFirstResponder];
            [item becomeFirstResponder];
        }
    }).LeeAddCustomConfig(NIGHT , ^(UITextField *item){
        
        item.keyboardAppearance = UIKeyboardAppearanceDark;
        if ([item isFirstResponder]) {
            [item resignFirstResponder];
            [item becomeFirstResponder];
        }
    });
    
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width_sd, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}

// 右栏目按钮点击事件

- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender{
    
    if ([[LEETheme currentThemeTag] isEqualToString:DAY]) {
        
        [LEETheme startTheme:NIGHT];
        
    } else {
        [LEETheme startTheme:DAY];
    }
}

- (NSArray *)creatModelsWithCount:(NSInteger)count
{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"小蜜果果",
                            @"格拉瓦的小猴子",
                            @"XINFEI呀",
                            @"张小爱0078",
                            @"小不点-TZ"];
    
    NSArray *textArray = @[@"位置❤️望京soho附近的一个合适白领吃中餐的商场.\n环境❤️义工5层左右高，4层和5层都是吃饭的地方。工作日中午过来每一家都是爆满，小店很多，比如酸菜鱼，串串香，小炒菜等等各类的快餐。3层是儿童服装用品，2层是服装，1层是果蔬超市，还有一些电子产品。相当于一个集美食、超市、服装为一体的休闲商圈，地段相当的好，也给上班族提供方便。\n服务❤️服务人员太忙，人也少，完全不够。\n总体❤️不能算是一个很棒的商场，但是方便民众，不错的中午休闲场所。",
                           @"之前在望京soho上班，以为这里还行，真进去逛逛才发现，太小了，和爱琴海和凯德mall那些根本不能比，东西种类不少，但是挑不出来什么，餐饮那层挤得像小商品市场，唯独电影院还有vip厅，可惜陈旧，沙发都掉皮了......总体来说一般，交通不是很方便。",
                           @"望京这边的一个综合市场，有服装店，电影院，餐饮，超市，儿童乐园等等，比较齐全。非周末来人很少，显得特别的冷清。吃饭的餐厅不少，看着每家都很好吃的样子。总体来说商场还是比较小，没有什么好逛的，可以随便逛一两个小时打发一下时间。",
                           @"就是在望京SOHO附近，具体位置无法详细说清楚，实在是我对望京这里不了解啊～\n反正就是位置一般，人气也挺少的，不过里面的果蔬真的聚满人气。",
                           @"在望京soho对面，地铁15号线D口出，走800米左右路程，属于综合商场，里面电影院，餐饮，各种口味的店铺很多，日料，湘菜，火锅，等等各种菜式都有，价格不等，适合各种人群，周围都是写字楼，中午来这里吃饭的人还是挺多的，喜欢逛街的可以来溜溜"
                           ];
    
    NSArray *commentsArray = @[@"就是指望超市攒人气，还有电影院，其他的真没啥",
                               @"哈哈哈，还有电影院呢😊",
                               @"上次在楼上吃的冰淇淋🍦喝的奶茶",
                               @"见过最烂的商场，服务不好，物业管理太烂，二层商场中间像是集市一样乱，而且冷。吃饭的地方到还可以。",
                               @"咖啡真的很烫的。",
                               @"就是上班族吃饭的地方。",
                               @"为黄轩的电影跑过来看的，吃的挺多，其他一般，商场不大",
                               @"餐饮店很丰富，环境不错，还有电影院。",
                               @"人不是很多",
                               @"以前快倒闭的地方，soho建好了又活起来了",
                               @"一般般，东西贵，不咋地，经常去咖啡厅",
                               @"上班族吃饭挺方便",
                               @"商场外面很好看，高大上"];
    
    NSArray *picImageNamesArray = @[ @"pic0.PNG",
                                     @"pic1.PNG",
                                     @"pic2.PNG",
                                     @"pic3.PNG",
                                     @"pic4.PNG",
                                     @"pic5.PNG",
                                     @"pic6.PNG",
                                     @"pic7.PNG",
                                     @"pic8.PNG",
                                     @"pic9.PNG",
                                     @"pic10.PNG",
                                     @"pic11.PNG"
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        SDTimeLineCellModel *model = [SDTimeLineCellModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(6);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
        // 模拟随机评论数据
        int commentRandom = arc4random_uniform(3);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            commentItemModel.firstUserName = namesArray[index];
            commentItemModel.firstUserId = @"666";
            if (arc4random_uniform(10) < 5) {
                commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                commentItemModel.secondUserId = @"888";
            }
            commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentItemModel];
        }
        model.commentItemsArray = [tempComments copy];
        
        // 模拟随机点赞数据
        int likeRandom = arc4random_uniform(3);
        NSMutableArray *tempLikes = [NSMutableArray new];
        for (int i = 0; i < likeRandom; i++) {
            SDTimeLineCellLikeItemModel *model = [SDTimeLineCellLikeItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            model.userName = namesArray[index];
            model.userId = namesArray[index];
            [tempLikes addObject:model];
        }
        
        model.likeItemsArray = [tempLikes copy];
        
        
        
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

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [_textField resignFirstResponder];
//    _textField.placeholder = nil;
//}



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

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if (textField.text.length) {
//        [_textField resignFirstResponder];
//
//        SDTimeLineCellModel *model = self.dataArray[_currentEditingIndexthPath.row];
//        NSMutableArray *temp = [NSMutableArray new];
//        [temp addObjectsFromArray:model.commentItemsArray];
//        SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
//
//        if (self.isReplayingComment) {
//            commentItemModel.firstUserName = @"GSD_iOS";
//            commentItemModel.firstUserId = @"GSD_iOS";
//            commentItemModel.secondUserName = self.commentToUser;
//            commentItemModel.secondUserId = self.commentToUser;
//            commentItemModel.commentString = textField.text;
//
//            self.isReplayingComment = NO;
//        } else {
//            commentItemModel.firstUserName = @"GSD_iOS";
//            commentItemModel.commentString = textField.text;
//            commentItemModel.firstUserId = @"GSD_iOS";
//        }
//        [temp addObject:commentItemModel];
//        model.commentItemsArray = [temp copy];
//        [self.tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
//
//        _textField.text = @"";
//        _textField.placeholder = nil;
//
//        return YES;
//    }
//    return NO;
//}



//- (void)keyboardNotification:(NSNotification *)notification
//{
//    NSDictionary *dict = notification.userInfo;
//    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
//
//
//
//    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
//    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
//        textFieldRect = rect;
//    }
//
//    [UIView animateWithDuration:0.25 animations:^{
//        _textField.frame = textFieldRect;
//    }];
//
//    CGFloat h = rect.size.height + textFieldH;
//    if (_totalKeybordHeight != h) {
//        _totalKeybordHeight = h;
//        [self adjustTableViewToFitKeyboard];
//    }
//}

@end
