//
//  YGGamesController.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/20.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGGamesController : UICollectionViewController
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *navName;
- (instancetype)initWithSlug:(NSString *)slug;
@end
