//
//  LSLSegmentScrollView.h
//  TestDemo
//
//  Created by lisonglin on 2018/2/11.
//  Copyright © 2018年 lisonglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSLSegmentScrollView : UIScrollView

@property(nonatomic, strong) NSArray * titleArrays;

- (instancetype)initWithFrame:(CGRect)frame headerView:(UIView *)headerView currentVC:(UIViewController *)vc;

@end
