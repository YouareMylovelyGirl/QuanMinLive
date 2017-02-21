//
//  YGGamesItem.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGGamesItem.h"

@implementation YGGamesItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"data":@"YGGamesDataItem"
             };
}
@end
@implementation YGGamesDataItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id"
             };
}
@end




