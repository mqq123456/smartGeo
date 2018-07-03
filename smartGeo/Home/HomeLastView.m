//
//  HomeLastView.m
//  smartGeo
//
//  Created by HeQin on 2018/4/1.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HomeLastView.h"

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

@interface HomeLastView ()<SDTimeLineCellDelegate, UITextFieldDelegate>
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

@implementation HomeLastView
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
    
    NSArray *namesArray = @[@"紫色的美食",
                            @"罐头里的鱼",
                            @"温暖的夏天的主场",
                            @"办公选址-赵远",
                            @"中装协设计网"];
    
    NSArray *textArray = @[@"【沸炉鲜货火锅•小龙虾】是一家地道的重庆九宫格火锅店，有别于传统重庆火锅的吃法，火锅上部可以放上小龙虾，涮锅、剥虾一起来，吃的就是这么爽！牛油锅底色泽红润，油脂清亮，回味鲜而不燥。小龙虾鲜香肉嫩，蒜蓉口味我更爱。涮品喜欢金牌毛肚、澳洲雪花肥牛、飘香肥肠和现炸酥肉。最后再来一份红糖锅盔，这顿饭吃的完美啦！#北京探店##微博吃货秀##不可辜负的美食##北京美食攻略# @北京城探店#吃在北京#@北京美食君 @北京旅游频道  @美食总监@鲜城北京",
                           @"#北京美食##不可辜负的美食##鱼儿觅食记##微博吃货秀#🍮店名：思特堡丨霄云路旗舰店（西直门&太阳宫&建国门&天津伊势丹也有普通门店）思特堡——一家来自横滨的甜品店，据说它家的巴姆和年轮蛋糕在日本火了20多年，只不过既然来着霄云路这家店，自然首选蛋糕类的冬季新品喽。【富士山下】大概是因为外形，我俩不约而同看向它，最外面一层白色奶霜提升了颜值而且有些神秘，非常好奇里面是什么了。小心地挖开，后面是淡奶油，还藏着一块香蕉，口感细腻偏甜，口味上以香蕉味很重。最下面用酥软的黄油法式塔做底，神似芝士巴姆的外壳。整体吃起来有一点小不方便，需要朋友配合压住它的另一边。【三盆栗子蒙布朗】最外面是栗子泥挤成的条状造型，丝丝缕缕的很精致。再往里挖是卡仕达奶油，比上一款柔软很多，打底的是日式黑砂糖做成的三盆卷，如此优秀的蛋糕甘心做了配角，更衬托了栗子泥的特别。@鲜城北京 @B不了 @确实是个好BOSS @吃蛋糕和面包 @吃货大咖团 @一起去探店 @北京美食君 @京城美食团 @全国探店 @一切向吃看",
                           @"#北京美食##不可辜负的美食##鱼儿觅食记# ✨店名：水前一树-Meat&Meet🎈坐标：后海南沿小翔凤胡同甲7号“后海有树的院子”是冯唐先生笔下人生四大可遇不可求的事之一。吃过昨天的晚餐后我想说，能邂逅这家面朝后海，门前有树的餐厅也是一件偶然的幸福。私厨美食共享平台EatWithChina创始人的店，从环境上就透露着一种分享的氛围，轻松热情，莫名给我家的感觉。菜单很有心，有的菜品后面会标注量（比如：有几根香肠，几只虾）。老板很nice，吉他弹唱，钢琴弹奏样样精通，看起来就是个热爱生活，美食，和分享的人。因为人多，有种刷遍它家招牌菜的感觉。【德式香肠配德式酸菜】我和朋友一致为它爆灯的一道，香肠一口下去会爆汁，唇齿留香，打底的酸菜很爽口，配在一起吃不会觉得腻。【香烤猪颈肉】之前吃过的以片状为主，这里的肉切成了肉条，吃起来更饱满，而且烤制均匀，从内而外透着一个嫩字，而且肉量很实在！【奶油培根意面】老板推荐必属精品，顶部的蛋黄属于点睛之笔，是很多店都没有的，搅拌之后浓郁的奶油紧紧包围着蘑菇和培根片，入味儿不腻，面的软硬度也刚好。【炸鱼薯条】目前在北京吃过的合我心意的炸鱼薯条，比Barblu闲和hmv都要棒，炸鱼皮薄酥脆，内里鱼肉滑嫩，整体层次分明，不会像其他店一样用薯条凑量，实实在在的鱼！【香烤五花肉】五花肉烤熟后整齐的排列在盘中， 涂抹上烧烤酱色泽金黄，入口肥而不腻。【牛油果沙拉】摆盘真的很精致了，让我怀疑主厨是处女座欧巴，各种蔬菜打底，佐以小番茄，橄榄，小洋葱，玉米片，最上面一层牛油果封层，很健康！【土豆泥】老板说比肯德基好吃，也太谦虚了吧，资深土豆控表示，这道小吃必点。【炸鸡翅】这种基本款小吃都做的很用心，外皮有一点点焦香，咔嚓一口特别松脆，外皮入味儿，微微辣，第一次不蘸番茄酱吃完一只鸡翅。【樱花酸奶芝士蛋糕】店里的最后两个被我们吃完，冷淡清新的外形不输精致的法国甜品，有冰激凌的口感，入口冰凉，绝对是夏日甜品的不二选择。底层还加入了红豆，层次分明。【炸虾片】不是传统的那种小片，几张松饼一般大的虾片脆脆的，太适合和朋友一起分享。【海鲜饭】最后一个上，都已经吃饱的情况下大家依旧光盘，芝士量足，佐以鱿鱼圈和大虾，趁热搅拌口味更佳。@鲜城北京 @B不了 @确实是个好BOSS @元元超甜的 @你们的薯干小公举 @大白兔奶糖好好ci @小愛Miko @Gemini_鑫软软 @一起去探店 @带你玩转北京城 @京城美食团 @一切向吃看 @全国探店"
                           ];
    
    NSArray *commentsArray = @[];
    
    NSArray *picImageNamesArray = @[@[@"IMG_1188.JPG",
                                      @"IMG_1189.JPG",
                                      @"IMG_1191.JPG",
                                      @"IMG_1187.JPG",
                                      @"IMG_1190.JPG",
                                      @"IMG_1192.JPG",
                                      @"IMG_1193.JPG",
                                      @"IMG_1194.JPG",
                                      @"IMG_1195.JPG"],
                                    @[@"IMG_1196.JPG",
                                      @"IMG_1197.JPG",
                                      @"IMG_1198.JPG",
                                      @"IMG_1199.JPG",
                                      @"IMG_1201.JPG",
                                      @"IMG_1202.JPG",
                                      @"IMG_1203.JPG",
                                      @"IMG_1204.JPG",
                                      @"IMG_1200.JPG"],
                                    @[@"IMG_1205.JPG",
                                      @"IMG_1207.JPG",
                                      @"IMG_1206.JPG",
                                      @"IMG_1208.JPG",
                                      @"IMG_1210.JPG",
                                      @"IMG_1209.JPG",
                                      @"IMG_1203.JPG",
                                      @"IMG_1211.JPG",
                                      @"IMG_1212.JPG"],
                                    @[@"IMG_1214.JPG",
                                      @"IMG_1223.JPG",
                                      @"IMG_1221.JPG",
                                      @"IMG_1223.JPG",
                                      @"IMG_1215.JPG",
                                      @"IMG_1217.JPG",
                                      @"IMG_1216.JPG",
                                      @"IMG_1218.JPG",
                                      @"IMG_1219.JPG"],
                                    @[@"IMG_1164.JPG"],
                                    @[@"IMG_1165.JPG",
                                      @"IMG_1167.JPG",
                                      @"IMG_1166.JPG",
                                      @"IMG_1169.JPG"]
                                    ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(3);
        
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

