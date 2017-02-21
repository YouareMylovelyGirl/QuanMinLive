//
//  YGLiveItem.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YGLiveRecommendItem,YGLiveRecommendDataItem,YGLiveRecommendDataLink_ObjectItem,YGLiveDataItem;
@interface YGLiveItem : NSObject

@property (nonatomic, strong) YGLiveRecommendItem *recommend;

@property (nonatomic, strong) NSArray<YGLiveDataItem *> *data;

@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *icon;

@end
@interface YGLiveRecommendItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, strong) NSArray<YGLiveRecommendDataItem *> *data;

@end

@interface YGLiveRecommendDataItem : NSObject
//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) NSInteger slot_id;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *create_at;

@property (nonatomic, strong) YGLiveRecommendDataLink_ObjectItem *link_object;

@property (nonatomic, copy) NSString *ext;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *fk;

@end

@interface YGLiveRecommendDataLink_ObjectItem : NSObject

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *categoryId;
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *icontext;

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

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *stream;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *recommend_image;

@property (nonatomic, copy) NSString *landscape;

@property (nonatomic, copy) NSString *video;

@property (nonatomic, copy) NSString *announcement;

@property (nonatomic, copy) NSString *videoQuality;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *follow;

@property (nonatomic, copy) NSString *play_at;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, copy) NSString *weight;

@end

@interface YGLiveDataItem : NSObject

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *categoryId;
//id ->ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *icontext;

@property (nonatomic, assign) BOOL play_status;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *last_play_at;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, copy) NSString *check;

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

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *app_shuffling_image;

@property (nonatomic, copy) NSString *category_slug;

@end

