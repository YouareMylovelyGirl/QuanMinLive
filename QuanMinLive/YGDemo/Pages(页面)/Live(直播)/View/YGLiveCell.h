//
//  YGLiveCell.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGLiveCell : UICollectionViewCell

/**
 直播图片
 */
@property (nonatomic, strong) UIImageView *iconIV;

/**
 直播标题
 */
@property (nonatomic, strong) UILabel *titleLB;

/**
 昵称
 */
@property (nonatomic, strong) UILabel *nickLB;

/**
 人数数量
 */
@property (nonatomic, strong) UILabel *audienceCountLB;

/**
 人数数量图片
 */
@property (nonatomic, strong) UIImageView *audienceCountIV;


@end
