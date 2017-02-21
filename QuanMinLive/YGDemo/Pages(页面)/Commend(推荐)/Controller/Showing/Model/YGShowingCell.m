//
//  YGShowingCell.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/20.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGShowingCell.h"

@implementation YGShowingCell
/**
 直播图片
 */
- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(_iconIV.mas_width);
        }];
    }
    return _iconIV;
}

/**
 直播标题
 */
- (UILabel *)titleLB {
    if(_titleLB == nil) {
        UIImageView *backImage = [[UIImageView alloc]init];
        backImage.image = [UIImage imageNamed:@"img_bg_hp_bottom"];
        [self.iconIV addSubview:backImage];
        [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.offset(0);
            make.height.mas_equalTo(20);
        }];
        _titleLB = [[UILabel alloc] init];
        _titleLB.textColor = [UIColor whiteColor];
        _titleLB.font = [UIFont systemFontOfSize:13];
        [backImage addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.bottom.offset(-3);
            make.right.offset(-25);
        }];
    }
    return _titleLB;
}

/**
 昵称
 */
- (UILabel *)nickLB {
    if(_nickLB == nil) {
        _nickLB = [[UILabel alloc] init];
        _nickLB.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nickLB];
        [_nickLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconIV);
            make.top.mas_equalTo(self.iconIV.mas_bottom).offset(10);
            make.right.mas_equalTo(self.iconIV.mas_centerX);
        }];
    }
    return _nickLB;
}

/**
 人数数量
 */
- (UILabel *)audienceCountLB {
    if(_audienceCountLB == nil) {
        _audienceCountLB = [[UILabel alloc] init];
        _audienceCountLB.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_audienceCountLB];
        [_audienceCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.nickLB);
            make.right.offset(-3);
        }];
    }
    return _audienceCountLB;
}

/**
 人数数量图片
 */
- (UIImageView *)audienceCountIV {
    if(_audienceCountIV == nil) {
        _audienceCountIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_audienceCountIV];
        [_audienceCountIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.audienceCountLB.mas_left).offset(-5);
            make.centerY.mas_equalTo(self.audienceCountLB);
            make.size.mas_equalTo(11);
            
        }];
    }
    return _audienceCountIV;
}

/**
 地址
 */
- (UILabel *)placeLB {
    if(_placeLB == nil) {
        _placeLB = [[UILabel alloc] init];
        _placeLB.font = [UIFont systemFontOfSize:12];
        _placeLB.textColor = [UIColor whiteColor];
        [self.bgImageView addSubview:_placeLB];
        [_placeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-3);
            make.centerY.offset(0);
        }];
    }
    return _placeLB;
}


/**
 地址图标
 */
- (UIImageView *)placeLV {
    if(_placeLV == nil) {
        _placeLV = [[UIImageView alloc] init];
        [self.bgImageView addSubview:_placeLV];
        [_placeLV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.placeLB.mas_left).offset(-5);
            make.centerY.mas_equalTo(self.placeLB);
            make.size.mas_equalTo(10);
        }];
        
    }
    return _placeLV;
}

/**
 背景图片
 */
- (UIImageView *)bgImageView {
    if(_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"sy_location_shadow"];
        [self.iconIV addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.offset(0);
            make.height.mas_equalTo(20);
        }];
    }
    return _bgImageView;
}
@end
