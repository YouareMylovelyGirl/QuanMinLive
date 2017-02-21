//
//  YGShowingItem.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGShowingItem.h"

@implementation YGShowingItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"data":@"YGShowingDataItem"
             };
}
@end

@implementation YGShowingDataItem

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id"
             };
}

@end

