//
//  MCCustomBar.m
//  简书userCenter
//
//  Created by 周陆洲 on 16/4/19.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MCCustomBar.h"
#import "UIView_extra.h"

#define ItemNorTintColor [UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1]

@implementation MCCustomBar

- (instancetype)initWithCount:(NSString *)count andName:(NSString *)name size:(CGSize)size{
    self = [super init];
    if (self) {
        [self createControlBarWithCount:count andName:name size:size];
    }
    return self;
}

//创建item
- (void)createControlBarWithCount:(NSString *)count andName:(NSString *)name size:(CGSize)size{
    
    [self setSize:size];
    //标题
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = name;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = ItemNorTintColor;
    
    [self addSubview:_nameLabel];
    
}




@end
