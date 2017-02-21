//
//  NSObject+YGParse.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YGParse)<YYModel>
+ (id)parse:(id)JSON;

@end
