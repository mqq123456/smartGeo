//
//  ArticleView.m
//  简书userCenter
//
//  Created by 周陆洲 on 16/4/19.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "ArticleView.h"



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

@interface ArticleView ()<SDTimeLineCellDelegate, UITextFieldDelegate>
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

@implementation ArticleView
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
                                     @"22.jpg",
                                     ];
    
    NSArray *namesArray = @[@"段传敏",
                            @"蔡鸿岩",
                            @"景玮峰",
                            @"LESMillsjojo",
                            @"名人经典",
                            @"静雅"];
    
    NSArray *textArray = @[@"上世纪90年代中，迈克尔·波特用自己的一篇文章《什么是战略》奠定了他在管理史上的影响力和战略大师的地位。文中，他清晰地指出，战略就是创造一种独特、有利的定位，涉及各种不同的经营活动。在此之前，定位这个概念是广告界的杰夫·特劳特和艾·里斯提出来的传播概念，定位是让企业在顾客心智中拥有一个字眼，用持续简单的信息在顾客心智中立足。因此，显然，波特眼中的概念是在二人基础上的进一步提升。他进而指出，战略是创造差异性，是一种取舍，并在此基础上建立配称。",
                           @"相比运营主管的称呼，我更喜欢营销主管的称呼，营销相对于运营更需要创新和解决问题的能力，运营字面的理解是运作经营，是有经验可循的，缺乏创新和挑战的意念，但是所有行业要做到TOP20%，都是要在一定程度上高于平均水平，那就不仅要善用已有的有效经验，还需要另辟新点新技法新方法，如此才能长居TOP20%。不进则退涵盖了这个道理。",
                           @"段永平：老实讲，我不知道什么人适合做投资。但我知道统计上大概80-90% 进入股市的人都是赔钱的。如果算上利息的话，赔钱的比例还要高些。许多人很想做投资的原因可能是认为投资的钱比较好赚，或来的比较快。作为既有经营企业又有投资经验的人来讲，我个人认为经营企业还是要比投资容易些。\n虽然这两者其实没有什么本质差别，但经营企业总是会在自己熟悉的领域，犯错的机会小，而投资却总是需要面临很多新的东西和不确定性，而且投资人会非常容易变成投机者，从而去冒不该冒的风险，而投机者要转化为真正的投资者则可能要长得多的时间。 ",
                           @"心境简单了\n就有心思经营生活\n生活简单了\n就有时间享受人生💐​ ",
                           @"【股神巴菲特教给我们7件事】1.会赚钱，还要会经营人生。2.停下来审视内心，也是一种投资。3.做你真正喜欢的事。 4.每次错误都是学习的机会。 5.从心出发，思考什么才是自己真正想要的。6.成功三要素：能力、热情和坚持。7.我们无法选择人生从哪开始，但可以选择成为什么样的人。#名人经典# ​",
                           @"今天一企业老总到我们工作室对俩女生进行面试，面试前聊天，聊起女生面临的就业问题，鲜明感受到企业招聘的两难和女生就业问题的尖锐性。放开二胎，意味着未婚未育女性一旦结婚，从怀孕到养育，除了保胎病假和产假之外，还有几年不那么在状态，这对众多以维持经营为常态的企业来说，是巨大风险。由此，导致女生的就业优势急剧下降。 ​"
                           ];
    
    NSArray *commentsArray = @[];
    
    NSArray *picImageNamesArray = @[ @[@"IMG_1179.JPG"],
                                     @[@"IMG_1180.JPG",
                                       @"IMG_1181.JPG"],
                                     @[@"IMG_1182.JPG",
                                       @"IMG_1183.JPG"],
                                     @[@"IMG_1184.JPG"],
                                     @[@"IMG_1185.JPG"],
                                     @[@"IMG_1186.JPG"]
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(6);
        
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


