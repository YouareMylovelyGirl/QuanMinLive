//
//  YGBroadcastItem.m
//  YGDemo
//
//  Created by 阳光 on 2017/2/3.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGBroadcastItem.h"

@implementation YGBroadcastItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"room_lines":@"YGBroadcastRoomLinesItem",
             @"rank_curr":@"YGBroadcastRankCurrItem"
             };
}
@end

@implementation YGBroadcastLiveItem

@end

@implementation YGBroadcastLiveWsItem

@end

@implementation YGBroadcastLiveWsHlsItem

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"three":@"3",
             @"four":@"4",
             @"five":@"5"
             };
}

@end

@implementation YGBroadcastLiveWsHlsThreeItem

@end

@implementation YGBroadcastLiveWsHlsFiveItem

@end

@implementation YGBroadcastLiveWsHlsFourItem

@end

@implementation YGBroadcastLiveWsFlvItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"three":@"3",
             @"four":@"4",
             @"five":@"5"
             };
}
@end

@implementation YGBroadcastLiveWsFlvThreeItem

@end

@implementation YGBroadcastLiveWsFlvFiveItem

@end

@implementation YGBroadcastLiveWsFlvFourItem

@end

@implementation YGBroadcastRankCurrItem

@end

@implementation YGBroadcastRoomLinesItem

@end

@implementation YGBroadcastRoomLinesHlsItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"three":@"3",
             @"four":@"4",
             @"five":@"5"
             };
}
@end

@implementation YGBroadcastRoomLinesHlsThreeItem

@end

@implementation YGBroadcastRoomLinesHlsFiveItem

@end

@implementation YGBroadcastRoomLinesFlvItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"three":@"3",
             @"four":@"4",
             @"five":@"5"
             };
}
@end

@implementation YGBroadcastRoomLinesFlvThreeItem

@end

@implementation YGBroadcastRoomLinesFlvFiveItem

@end

@implementation YGBroadcastRoomLinesFlvFourItem

@end

