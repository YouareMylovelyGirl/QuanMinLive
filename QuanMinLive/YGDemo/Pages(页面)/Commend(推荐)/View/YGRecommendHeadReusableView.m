//
//  YGRecommendHeadReusableView.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/20.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGRecommendHeadReusableView.h"

@implementation YGRecommendHeadReusableView
- (UIView *)headView {
    if(_headView == nil) {
        _headView = [[UIView alloc] init];
        _headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 25);
        [self addSubview:_headView];
    }
    return _headView;
}

- (UILabel *)leftLabel {
    if(_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = [UIFont systemFontOfSize:15];
        [self.headView addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.mas_equalTo(self.leftImageIV.mas_right).offset(5);
        }];
    }
    return _leftLabel;
}

- (UIImageView *)leftImageIV {
    if(_leftImageIV == nil) {
        _leftImageIV = [[UIImageView alloc] init];
        [self.headView addSubview:_leftImageIV];
        [_leftImageIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(10);
            make.size.mas_equalTo(13);
        }];
    }
    return _leftImageIV;
}

- (UIButton *)rigthButton {
    if(_rigthButton == nil) {
        _rigthButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.headView addSubview:_rigthButton];
        //富文本图片字符串
        NSAttributedString *nameStr = [[NSAttributedString alloc] initWithString:@"瞅瞅" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        //带属性字符串的附件
        NSTextAttachment *textAtt = [[NSTextAttachment alloc] init];
        textAtt.image = [UIImage imageNamed:@"btn_home_content_rignt_cc_normal"];
        //调整附件的位置和大小
        textAtt.bounds = CGRectMake(0, -5, 20, 20);
        
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAtt];
        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] init];
        [mStr appendAttributedString:nameStr];
        [mStr appendAttributedString:imageStr];
        [_rigthButton setAttributedTitle:mStr forState:UIControlStateNormal];
        
        //高亮
        NSAttributedString *nameStrH = [[NSAttributedString alloc]initWithString:@"瞅瞅" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor redColor]}];
        //带属性字符串的附件
        NSTextAttachment *textAttH = [[NSTextAttachment alloc] init];
        textAttH.image = [UIImage imageNamed:@"btn_home_content_rignt_cc_selected"];
        //调整附件的位置和大小
        textAttH.bounds = CGRectMake(0, -5, 20, 20);
        NSAttributedString *imageStrH = [NSAttributedString attributedStringWithAttachment:textAttH];
        NSMutableAttributedString *mStrH = [[NSMutableAttributedString alloc] init];
        [mStrH appendAttributedString:nameStrH];
        [mStrH appendAttributedString:imageStrH];
        [_rigthButton setAttributedTitle:mStrH forState:UIControlStateHighlighted];
        
        [_rigthButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.centerY.offset(0);
        }];
        [_rigthButton addTarget:self action:@selector(btnClickGoLiveList:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rigthButton;
}


- (void)btnClickGoLiveList:(UIButton *)sender
{
    self.rightBtnGo();
}
@end
