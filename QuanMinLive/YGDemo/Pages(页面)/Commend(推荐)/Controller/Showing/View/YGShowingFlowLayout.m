//
//  YGShowingFlowLayout.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/20.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGShowingFlowLayout.h"

@implementation YGShowingFlowLayout
- (instancetype)init
{
    if (self = [super init]) {
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 30) / 2);
        CGFloat height = width + 20;
        self.itemSize = CGSizeMake(width, height);
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return self;
}
@end
