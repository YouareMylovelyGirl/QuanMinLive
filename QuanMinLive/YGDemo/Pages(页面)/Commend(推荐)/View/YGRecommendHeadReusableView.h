//
//  YGRecommendHeadReusableView.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/20.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGRecommendHeadReusableView : UICollectionReusableView
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIImageView *leftImageIV;
@property (nonatomic, strong) UIButton *rigthButton;

@property (nonatomic, copy) void(^rightBtnGo)();



@end
