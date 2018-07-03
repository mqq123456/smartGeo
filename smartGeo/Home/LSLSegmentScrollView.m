//
//  LSLSegmentScrollView.m
//  TestDemo
//
//  Created by lisonglin on 2018/2/11.
//  Copyright © 2018年 lisonglin. All rights reserved.
//

#import "LSLSegmentScrollView.h"
#import "UIView_extra.h"
#define NavH  0
#define SectionH 44
#define MaxNums 5
#define BottomLineH 1.5

@interface LSLSegmentScrollView ()<UIScrollViewDelegate> {
    BOOL viewAlloc[MaxNums];    //记录contentOffset里哪些有子视图
}

@property(nonatomic, weak) UIView * contentView;

@property(nonatomic, weak) UIView * headerView;

@property(nonatomic, weak) UIScrollView * HScrollView;

@property(nonatomic, weak) UIView * sectionView;

@property(nonatomic, strong) UIViewController * currentVC;

@property(nonatomic, strong) UIButton * selectedBtn;

@property(nonatomic, weak) UIView * bottomLineView;

@end



@implementation LSLSegmentScrollView

- (instancetype)initWithFrame:(CGRect)frame headerView:(UIView *)headerView currentVC:(UIViewController *)vc{
    if (self = [super initWithFrame:frame]) {
        
        self.headerView = headerView;
        self.currentVC = vc;
        
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        
        self.tag = 10;
        
        [self setUpUserInterface];
    }
    return self;
}

- (void)setUpUserInterface {
    
    [self addSubview:self.headerView];
    
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.frame.size.width, SectionH)];
    [self addSubview:sectionView];
    self.sectionView = sectionView;
    
    //划线
    
    UIView *bottomLine = [self createLineWithWidth:[UIScreen mainScreen].bounds.size.width andHeight:1 andColor:[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1]];
    [bottomLine setOrigin:CGPointMake(0, SectionH-1)];
    [_sectionView addSubview:bottomLine];
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sectionView.frame), self.frame.size.width, self.frame.size.height - NavH)];
    self.contentView = contentView;
    [self addSubview:contentView];
    
    self.contentSize = CGSizeMake(self.frame.size.width, self.headerView.frame.size.height + contentView.frame.size.height);
    
    UIScrollView * HScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, contentView.frame.size.height - SectionH)];
    HScrollView.tag = 20;
    HScrollView.pagingEnabled = YES;
    HScrollView.delegate = self;
    [self.contentView addSubview:HScrollView];
    self.HScrollView = HScrollView;
    HScrollView.backgroundColor = [UIColor whiteColor];
    
}
//绘制线
- (UIView *)createLineWithWidth:(CGFloat)width andHeight:(CGFloat)height andColor:(UIColor *)color{
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    line.backgroundColor = color;
    
    return line;
}
- (void)setTitleArrays:(NSArray *)titleArrays {
    _titleArrays = titleArrays;
    
    //初始化控制器视图
    self.HScrollView.contentSize = CGSizeMake(titleArrays.count * self.contentView.frame.size.width, self.contentView.frame.size.height - SectionH);
    
    //添加按钮
    [self addBtns];
}

- (void)addBtns {
    for (int i = 0; i < self.titleArrays.count; i ++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.sectionView.frame.size.width / self.titleArrays.count * i , 0, self.sectionView.frame.size.width / self.titleArrays.count, self.sectionView.frame.size.height);
        NSDictionary * dic = self.titleArrays[i];
        [btn setTitleColor:[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitle:dic.allValues[0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.sectionView addSubview:btn];
        btn.tag = 100 + i;
        
        if (btn.tag == 100) {
            btn.selected = YES;
            self.selectedBtn = btn;
        }
        
        [btn addTarget:self action:@selector(sectionTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    //底部的划线
    UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(self.selectedBtn.frame.size.width / 4, self.selectedBtn.frame.size.height - BottomLineH, self.selectedBtn.frame.size.width / 2, BottomLineH)];
    bottomLineView.backgroundColor = [UIColor redColor];
    self.bottomLineView = bottomLineView;
    [self.sectionView addSubview:bottomLineView];
    
    //默认添加第一个视图view
    [self setUpOneViewWithIndex:0];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 10) {//外面的大scrollView
//        scrollView.bounces = (scrollView.contentOffset.y >= self.headerView.frame.size.height - NavH) ? NO : YES;
        CGPoint offset = scrollView.contentOffset;
        if (offset.y >= self.headerView.frame.size.height - NavH) {
            offset.y = self.headerView.frame.size.height - NavH;
        }
        scrollView.contentOffset = offset;
        NSDictionary *dict =@{@"offset": [NSString stringWithFormat:@"%f",offset.y]};
        NSNotification *notification =[NSNotification notificationWithName:@"OffsetNotification" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }else {
        //横向的scrollView
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 20) {
        NSInteger index = scrollView.contentOffset.x / self.contentView.frame.size.width;
        
        self.selectedBtn.selected = NO;
        
        UIButton * btn = [self.sectionView viewWithTag:(index + 100)];
        
        btn.selected = YES;
        
        self.selectedBtn = btn;
        
        //滑块滑到对应按钮的下面
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomLineView.center = CGPointMake(btn.center.x, btn.frame.size.height - BottomLineH);
        }];
        
        if (!viewAlloc[btn.tag - 100]) {
            [self setUpOneViewWithIndex:(btn.tag - 100)];
        }
    }
}


- (void)sectionTitleBtnClick:(UIButton *)sender {
    
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    
    //划线移动到对应按钮下方
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomLineView.center = CGPointMake(sender.center.x, sender.frame.size.height - BottomLineH);
    }];
    
    //scrollView滚动到对应的页面
    [self.HScrollView setContentOffset:CGPointMake((sender.tag - 100) * self.contentView.frame.size.width, 0) animated:YES];
    
    //初始化页面的view
    if (!viewAlloc[sender.tag - 100]) {
        [self setUpOneViewWithIndex:sender.tag - 100];
    }
}

- (void)setUpOneViewWithIndex:(NSInteger)index {
    NSString * vcStr = [self.titleArrays[index] allKeys][0];
    Class vcClass = NSClassFromString(vcStr);
    
    if (vcStr.length && vcClass) {
        UIViewController * vc = vcClass.new;
        [self.currentVC addChildViewController:vc];
        
        vc.view.frame = CGRectMake(self.contentView.frame.size.width * index, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
        
        [self.HScrollView addSubview:vc.view];
        
        viewAlloc[index] = YES;
    }
}

@end
