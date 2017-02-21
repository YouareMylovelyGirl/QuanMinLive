//
//  YGRecommendItem.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YGRecommendRoomItem,YGRecommendRoomListItem;
@interface YGRecommendItem : NSObject

@property (nonatomic, strong) NSArray *ad;

@property (nonatomic, strong) NSArray<YGRecommendRoomItem *> *room;

@end
@interface YGRecommendRoomItem : NSObject

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, assign) NSInteger is_default;
//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *category_more;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray<YGRecommendRoomListItem *> *list;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@end

@interface YGRecommendRoomListItem : NSObject

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger fans;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) NSInteger play_true;

@property (nonatomic, assign) BOOL is_shield;

@property (nonatomic, assign) BOOL play_status;

@property (nonatomic, copy) NSString *last_play_at;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, assign) BOOL check;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *love_cover;

@property (nonatomic, assign) NSInteger play_count;

@property (nonatomic, copy) NSString *view;

@property (nonatomic, assign) NSInteger no;

@property (nonatomic, copy) NSString *beauty_cover;

@property (nonatomic, copy) NSString *last_thumb;

@property (nonatomic, assign) NSInteger coin;

@property (nonatomic, copy) NSString *default_image;

@property (nonatomic, assign) NSInteger max_view;

@property (nonatomic, copy) NSString *category_name;

@property (nonatomic, copy) NSString *create_at;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, assign) NSInteger anniversary;

@property (nonatomic, assign) NSInteger like;

@property (nonatomic, copy) NSString *stream;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *recommend_image;

@property (nonatomic, assign) NSInteger landscape;

@property (nonatomic, copy) NSString *video;

@property (nonatomic, copy) NSString *video_quality;

@property (nonatomic, copy) NSString *last_end_at;

@property (nonatomic, copy) NSString *first_play_at;

@property (nonatomic, assign) NSInteger starlight;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger category_id;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, copy) NSString *category_slug;

@end

