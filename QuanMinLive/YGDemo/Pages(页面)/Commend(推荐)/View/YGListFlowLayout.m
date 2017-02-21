//
//  YGListFlowLayout.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/22.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGListFlowLayout.h"

@implementation YGListFlowLayout
- (instancetype)init
{
    if (self = [super init]) {
        CGFloat width = (long)([UIScreen mainScreen].bounds.size.width / 3);
        CGFloat height = width;
        self.itemSize = CGSizeMake(width, height);
        self.minimumLineSpacing = 0 ;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsetsZero;
    }
    return self;
}
@end
