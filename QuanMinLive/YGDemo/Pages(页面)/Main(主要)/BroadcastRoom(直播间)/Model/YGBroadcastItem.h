//
//  YGBroadcastItem.h
//  YGDemo
//
//  Created by 阳光 on 2017/2/3.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YGBroadcastLiveItem,YGBroadcastLiveWsItem,YGBroadcastLiveWsHlsItem,YGBroadcastLiveWsHlsThreeItem,YGBroadcastLiveWsHlsFiveItem,YGBroadcastLiveWsHlsFourItem,YGBroadcastLiveWsFlvItem,YGBroadcastLiveWsFlvThreeItem,YGBroadcastLiveWsFlvFiveItem,YGBroadcastLiveWsFlvFourItem,YGBroadcastRankCurrItem,YGBroadcastRoomLinesItem,YGBroadcastRoomLinesHlsItem,YGBroadcastRoomLinesHlsThreeItem,YGBroadcastRoomLinesHlsFiveItem,YGBroadcastRoomLinesHlsFourItem,Flv,YGBroadcastRoomLinesFlvThreeItem,YGBroadcastRoomLinesFlvFiveItem,YGBroadcastRoomLinesFlvFourItem;
@interface YGBroadcastItem : NSObject<YYModel>

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) BOOL play_status;

@property (nonatomic, strong) NSArray *notice;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *last_play_at;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, strong) NSArray *admins;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, assign) BOOL hidden;

@property (nonatomic, assign) NSInteger view;

@property (nonatomic, assign) BOOL forbid_status;

@property (nonatomic, assign) NSInteger watermark;

@property (nonatomic, assign) NSInteger no;

@property (nonatomic, copy) NSString *watermark_pic;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, strong) YGBroadcastLiveItem *live;

@property (nonatomic, copy) NSString *category_name;

@property (nonatomic, strong) NSArray *rank_week;

@property (nonatomic, strong) NSArray<YGBroadcastRoomLinesItem *> *room_lines;

@property (nonatomic, assign) BOOL is_star;

@property (nonatomic, strong) NSArray *rank_total;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, strong) NSArray<YGBroadcastRankCurrItem *> *rank_curr;

@property (nonatomic, copy) NSString *video_quality;

@property (nonatomic, copy) NSString *special;

@property (nonatomic, copy) NSString *announcement;

@property (nonatomic, strong) NSArray *hot_word;

@property (nonatomic, assign) NSInteger follow;

@property (nonatomic, copy) NSString *play_at;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, assign) BOOL police_forbid;

@end

@interface YGBroadcastLiveItem : NSObject

@property (nonatomic, strong) YGBroadcastLiveWsItem *ws;

@end

@interface YGBroadcastLiveWsItem : NSObject

@property (nonatomic, strong) YGBroadcastLiveWsHlsItem *hls;

@property (nonatomic, copy) NSString *def_mobile;

@property (nonatomic, copy) NSString *def_pc;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) YGBroadcastLiveWsFlvItem *flv;

@property (nonatomic, copy) NSString *v;

@end

@interface YGBroadcastLiveWsHlsItem : NSObject
//3 -> three
@property (nonatomic, strong) YGBroadcastLiveWsHlsThreeItem *three;

@property (nonatomic, assign) NSInteger main_mobile;
//4 -> four
@property (nonatomic, strong) YGBroadcastLiveWsHlsFourItem *four;

@property (nonatomic, assign) NSInteger main_pc;
//5 -> five
@property (nonatomic, strong) YGBroadcastLiveWsHlsFiveItem *five;

@end

@interface YGBroadcastLiveWsHlsThreeItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastLiveWsHlsFiveItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastLiveWsHlsFourItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastLiveWsFlvItem : NSObject
//3 -> three
@property (nonatomic, strong) YGBroadcastLiveWsFlvThreeItem *three;

@property (nonatomic, assign) NSInteger main_mobile;
//4 -> four
@property (nonatomic, strong) YGBroadcastLiveWsFlvFourItem *four;

@property (nonatomic, assign) NSInteger main_pc;
//5 -> five
@property (nonatomic, strong) YGBroadcastLiveWsFlvFiveItem *five;

@end

@interface YGBroadcastLiveWsFlvThreeItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastLiveWsFlvFiveItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastLiveWsFlvFourItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastRankCurrItem : NSObject

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign) NSInteger rank;

@property (nonatomic, copy) NSString *send_uid;

@property (nonatomic, copy) NSString *send_nick;

@end

@interface YGBroadcastRoomLinesItem : NSObject

@property (nonatomic, strong) YGBroadcastRoomLinesHlsItem *hls;

@property (nonatomic, copy) NSString *def_mobile;

@property (nonatomic, copy) NSString *def_pc;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Flv *flv;

@property (nonatomic, copy) NSString *v;

@end

@interface YGBroadcastRoomLinesHlsItem : NSObject
//3 -> three
@property (nonatomic, strong) YGBroadcastRoomLinesHlsThreeItem *three;

@property (nonatomic, assign) NSInteger main_mobile;
//4 -> four
@property (nonatomic, strong) YGBroadcastRoomLinesHlsFourItem *four;

@property (nonatomic, assign) NSInteger main_pc;
//5 -> five
@property (nonatomic, strong) YGBroadcastRoomLinesHlsFiveItem *five;

@end

@interface YGBroadcastRoomLinesHlsThreeItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastRoomLinesHlsFiveItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastRoomLinesHlsFourItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastRoomLinesFlvItem : NSObject
//3 -> three
@property (nonatomic, strong) YGBroadcastRoomLinesFlvThreeItem *three;

@property (nonatomic, assign) NSInteger main_mobile;
//4 -> four
@property (nonatomic, strong) YGBroadcastRoomLinesFlvFourItem *four;

@property (nonatomic, assign) NSInteger main_pc;
//5 -> five
@property (nonatomic, strong) YGBroadcastRoomLinesFlvFiveItem *five;

@end

@interface YGBroadcastRoomLinesFlvThreeItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastRoomLinesFlvFiveItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

@interface YGBroadcastRoomLinesFlvFourItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *src;

@end

