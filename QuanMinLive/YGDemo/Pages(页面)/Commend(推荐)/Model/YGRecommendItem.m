//
//  YGRecommendItem.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGRecommendItem.h"

@implementation YGRecommendItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"room":@"YGRecommendRoomItem"
             };
}
@end
@implementation YGRecommendRoomItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"list":@"YGRecommendRoomListItem"
             };
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id"
             };
}
@end


@implementation YGRecommendRoomListItem

@end





