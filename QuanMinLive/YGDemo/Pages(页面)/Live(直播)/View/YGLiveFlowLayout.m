//
//  YGLiveFlowLayout.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGLiveFlowLayout.h"

@implementation YGLiveFlowLayout
- (instancetype)init
{
    if (self = [super init]) {
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 25) / 2);
        CGFloat scale = 219 / 390.0;
        CGFloat height = width * scale + 30;
        self.itemSize = CGSizeMake(width, height);
        self.minimumLineSpacing = 20;
        self.minimumInteritemSpacing = 5;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}
@end
