//
//  YGHeadListItem.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/20.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YGHeadListItem : NSObject


@property (nonatomic, copy) NSString *slug;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSInteger is_default;
//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *icon_image;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, copy) NSString *icon_red;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon_gray;

@end

