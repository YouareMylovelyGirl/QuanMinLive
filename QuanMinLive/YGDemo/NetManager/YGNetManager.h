//
//  YGNetManager.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "BaseNetManager.h"
#import "YGLiveItem.h"
#import "YGRecommendItem.h"
#import "YGShowingItem.h"
#import "YGGamesItem.h"
#import "YGHeadListItem.h"
#import "YGADItem.h"
#import "YGBroadcastItem.h"
@interface YGNetManager : BaseNetManager
//live
+ (id)GETLiveItem:(NSString *)page completionHandler:(void(^)(YGLiveItem *liveItems, NSError *error))completionHandler;

//recommend
+ (id)GETRecommendItemCompletionHandler:(void(^)(YGRecommendItem *recommendItems, NSError *error))completionHandler;


//games
+ (id)GETGameItemWithName:(NSString *)name page:(NSString *)page CompletionHandler:(void(^)(YGGamesItem *games, NSError *error))completionHandler;


+ (id)GETTitleListCompltionHandler:(void(^)(NSArray<YGHeadListItem *> *headLists, NSError *error))completionHandler;
//showing
+ (id)GETShowingCompletionHandler:(void(^)(YGShowingItem *showing, NSError *error))completionHandler;
//AD广告
+ (id)GETADCompletionHandler:(void(^)(YGADItem *adItems, NSError *error))completionHandler;

//直播间
+ (id)GETBroadcast:(NSInteger)uid completionHandler:(void(^)(YGBroadcastItem *broadcasts, NSError *error))completionHandler;
@end
