//
//  YGADItem.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/20.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGADItem.h"

@implementation YGADItem
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"iosLaunchImage":@"YGADIosLaunchImageItem",
             @"iosFocus":@"YGADIosFocusItem"
             };
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"iosLaunchImage":@"ios-launch-image",
             @"iosFocus":@"ios-focus"
             };
}
@end
@implementation YGADIosFocusExtItem

@end


@implementation YGADIosFocusLink_ObjectItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ID":@"id",
             
             };
}
@end


@implementation YGADIosFocusItem

@end



