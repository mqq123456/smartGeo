//
//  HQSearchBar.m
//  smartGeo
//
//  Created by HeQin on 2018/3/25.
//  Copyright © 2018年 HeQin. All rights reserved.
//

#import "HQSearchBar.h"
#import "UIView_extra.h"

@implementation HQSearchBar

/** 使用代码创建控件的时候，调用init的时候会调用此方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    // 由于是重写方法，记得一定要先调用父类初始化方法
    if (self = [super initWithFrame:frame]) {
        // 设置内容垂直居中
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        // 设置背景图片（拉伸图片）
        self.background = [self resizedImage:@"searchbar_textfield_background"];
        
        // 添加图标“放大镜“
        UIImageView *searchBarIconView = [[UIImageView alloc] init];
        searchBarIconView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        
        // 调整”放大镜”两边间距，view显示为正方形
        searchBarIconView.width = searchBarIconView.image.size.width + 10;
        searchBarIconView.height = searchBarIconView.width;
        
        // 设置”放大镜“在imageView中居中
        [searchBarIconView setContentMode:UIViewContentModeCenter];
        
        // 设置textField的左部控件（”放大镜“所属的imageView）显示
        [self setLeftViewMode:UITextFieldViewModeAlways];
        
        // 设置图标到搜索栏
        self.leftView = searchBarIconView;
        
        // 显示清除按钮
        [self setClearButtonMode:UITextFieldViewModeAlways];
    }
    
    return self;
}
/** 保护性拉伸图片，通常用来使用小图做背景 */
- (UIImage *) resizedImage:(NSString *) imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
