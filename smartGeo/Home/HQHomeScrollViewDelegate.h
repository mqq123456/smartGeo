//
//  HQHomeScrollViewDelegate.h
//  smartGeo
//
//  Created by HeQin on 2018/3/30.
//  Copyright © 2018年 HeQin. All rights reserved.
//

@protocol HQHomeScrollViewDelegate <NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
@end
