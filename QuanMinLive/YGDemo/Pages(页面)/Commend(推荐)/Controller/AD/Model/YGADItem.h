//
//  YGADItem.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/20.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YGADIosLaunchImageItem,YGADIosFocusExtItem,YGADIosFocusLink_ObjectItem,YGADIosFocusItem;

@interface YGADItem : NSObject

//ios-launch-image -> iosLaunchImage
@property (nonatomic, strong) NSArray<YGADIosLaunchImageItem *> *iosLaunchImage;
//ios-focus ->iosFocus
@property (nonatomic, strong) NSArray<YGADIosFocusItem *> *iosFocus;

@end


@interface YGADIosLaunchImageItem : NSObject

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *type;

@end



@interface YGADIosFocusLink_ObjectItem : NSObject

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

@interface YGADIosFocusItem : NSObject

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) YGADIosFocusLink_ObjectItem *link_object;

@property (nonatomic, strong) YGADIosFocusExtItem *ext;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *type;

@end

@interface YGADIosFocusExtItem : NSObject

@property (nonatomic, copy) NSString *type;

@end

