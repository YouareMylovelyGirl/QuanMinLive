//
//  YGNetManager.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGNetManager.h"

@implementation YGNetManager

#pragma mark - liveItemNetManager
+ (id)GETLiveItem:(NSString *)page completionHandler:(void (^)(YGLiveItem *, NSError *))completionHandler
{
    NSString *livePath = [NSString stringWithFormat:@"http://www.quanmin.tv/json/play/list%@.json",page];
    return [self GET:livePath param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([YGLiveItem parse:obj], error);
    }];
}


#pragma mark - recommendItemNetManager
+ (id)GETRecommendItemCompletionHandler:(void (^)(YGRecommendItem *, NSError *))completionHandler
{
    NSString *recommendPath = @"http://www.quanmin.tv/json/app/index/recommend/list-iphone.json?0119144410";
    return [self GET:recommendPath param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([YGRecommendItem parse:obj], error);
    }];
}


+ (id)GETGameItemWithName:(NSString *)name page:(NSString *)page CompletionHandler:(void (^)(YGGamesItem *, NSError *))completionHandler
{
    NSString *recommendPath = [NSString stringWithFormat:@"http://www.quanmin.tv/json/categories/%@/list%@.json?0119145715",name, page];
    
    return [self GET:recommendPath param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([YGGamesItem parse:obj], error);
    }];
}


+ (id)GETTitleListCompltionHandler:(void (^)(NSArray<YGHeadListItem *> *, NSError *))completionHandler
{
    NSString *recommendPath = @"http://www.quanmin.tv/json/app/index/category/info-iphone.json";
    
    return [self GET:recommendPath param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([YGHeadListItem parse:obj], error);
    }];
}

+ (id)GETShowingCompletionHandler:(void (^)(YGShowingItem *, NSError *))completionHandler
{
    NSString *showingPath = @"http://www.quanmin.tv/json/categories/Showing/list.json?0119145715";
    return [self GET:showingPath param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([YGShowingItem parse:obj], error);
    }];
}

+ (id)GETADCompletionHandler:(void (^)(YGADItem *, NSError *))completionHandler
{
    NSString *adStr = @"http://www.quanmin.tv/json/page/app_images?p=2&rid=-1&rcat=-1&uid=1826550118&screen=2&device=57D88898-C7D0-4FEE-9D81-79539A61DE6D&sw=320.0&sh=568.0&ch=APPStore&refer=";
    return [self GET:adStr param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([YGADItem parse:obj], error);
    }];
}

+ (id)GETBroadcast:(NSInteger)uid completionHandler:(void (^)(YGBroadcastItem *, NSError *))completionHandler
{
    NSString *broadcastPath = [NSString stringWithFormat:@"http://www.quanmin.tv/json/rooms/%ld/info.json", uid];
    return [self GET:broadcastPath param:nil completionHandler:^(id obj, NSError *error) {
        !completionHandler ?: completionHandler([YGBroadcastItem parse:obj], error);
    }];
}
@end
