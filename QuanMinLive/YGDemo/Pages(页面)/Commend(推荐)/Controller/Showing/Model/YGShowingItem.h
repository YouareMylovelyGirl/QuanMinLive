//
//  YGShowingItem.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YGShowingDataItem;
@interface YGShowingItem : NSObject

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSArray<YGShowingDataItem *> *data;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger pageCount;


@end

@interface YGShowingDataItem : NSObject

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *categoryId;
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) BOOL play_status;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *last_play_at;

@property (nonatomic, copy) NSString *check;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, assign) BOOL hidden;

@property (nonatomic, copy) NSString *view;

@property (nonatomic, copy) NSString *no;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *category_name;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, copy) NSString *views;

@property (nonatomic, copy) NSString *stream;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *recommend_image;

@property (nonatomic, copy) NSString *landscape;

@property (nonatomic, copy) NSString *video;

@property (nonatomic, copy) NSString *announcement;

@property (nonatomic, copy) NSString *videoQuality;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, copy) NSString *play_at;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *category_slug;

@end

