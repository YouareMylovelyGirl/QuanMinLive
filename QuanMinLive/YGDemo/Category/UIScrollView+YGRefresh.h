//
//  UIScrollView+YGRefresh.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
@interface UIScrollView (YGRefresh)
/**
 添加头部刷新
 */
- (void)addHeaderRefresh:(void(^)())block;

/**
 添加脚步刷新
 */
- (void)addFooterRefresh:(void(^)())block;

/**
 开始头部刷新
 */
- (void)beginHeaderRefresh;

/**
 停止头部刷新
 */
- (void)endHeaderRefresh;

/**
 开始脚步刷新
 */
- (void)beginFooterRefresh;

/**
 停止脚步刷新
 */
- (void)endFooterRefresh;

/**
 没有更多内容
 */
- (void)endRefreshWithNoMoreData;

/**
 重置没有内容为 显示更多
 */
- (void)resetNoMoreData;
@end
