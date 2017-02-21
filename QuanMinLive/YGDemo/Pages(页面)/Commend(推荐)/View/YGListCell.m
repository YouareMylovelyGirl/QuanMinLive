//
//  YGListCell.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/22.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGListCell.h"

@implementation YGListCell

- (UIView *)backGroundView {
    if(_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        _backGroundView.layer.borderWidth = 1;
        _backGroundView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:_backGroundView];
        [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).offset(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _backGroundView;
}

- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        
        _iconIV = [[UIImageView alloc] init];
        [self.backGroundView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            CGFloat width = (long)([UIScreen mainScreen].bounds.size.width / 3) * 0.7;
            CGFloat scrle = 18 / 24.0;
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(_iconIV.mas_width).multipliedBy(scrle);
            
        }];
    }
    return _iconIV;
}

- (UILabel *)nameLB {
    if(_nameLB == nil) {
        _nameLB = [[UILabel alloc] init];
        _nameLB.textColor = [UIColor grayColor];
        _nameLB.textAlignment = NSTextAlignmentCenter;
        _nameLB.font = [UIFont systemFontOfSize:13];
        [self.backGroundView addSubview:_nameLB];
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.iconIV);
            make.top.mas_equalTo(self.iconIV.mas_bottom).offset(3);
        }];
    }
    return _nameLB;
}
@end
