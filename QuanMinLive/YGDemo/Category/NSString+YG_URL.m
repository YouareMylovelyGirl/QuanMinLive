//
//  NSString+YG_URL.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "NSString+YG_URL.h"

@implementation NSString (YG_URL)
- (NSURL *)yg_url
{
    return [NSURL URLWithString:self];
}
@end
