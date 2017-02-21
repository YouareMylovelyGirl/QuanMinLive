//
//  YGGamesController.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/20.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGGamesController.h"
#import "YGGamesCell.h"
#import "YGGamesItem.h"
#import "YGNetManager.h"
#import "YGBroadcastRoomController.h"
@interface YGGamesController ()
@property (nonatomic, strong) NSMutableArray *gamesArr;
@property (nonatomic, assign) NSInteger pageNum;
@end

@implementation YGGamesController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithSlug:(NSString *)slug
{
    if (self = [super init]) {
        self.slug = slug;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    self.navigationItem.title = self.navName;
    
    
}

- (void)configUI
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        [YGNetManager GETGameItemWithName:weakSelf.slug page:@"" CompletionHandler:^(YGGamesItem *games, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (error) {
                [weakSelf.view showHUD];
            }
            else
            {
                weakSelf.pageNum = 1;

                [weakSelf.gamesArr removeAllObjects];
                [weakSelf.gamesArr addObjectsFromArray:games.data];
                [weakSelf.collectionView reloadData];
                if (games.pageCount == 0) {
                    [weakSelf.collectionView endRefreshWithNoMoreData];
                }
                else
                {
                    if (self.pageNum == games.pageCount) {
                        [weakSelf.collectionView endRefreshWithNoMoreData];
                    }
                    else
                    {
                        [weakSelf.collectionView resetNoMoreData];
                    }
                }
                
            }
        }];
        
    }];
    
    [self.collectionView beginHeaderRefresh];
    [self.collectionView registerClass:[YGGamesCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView addFooterRefresh:^{
        [YGNetManager GETGameItemWithName:weakSelf.slug page:[NSString stringWithFormat:@"_%ld",weakSelf.pageNum] CompletionHandler:^(YGGamesItem *games, NSError *error) {
            [weakSelf.collectionView endFooterRefresh];
            if (error) {
                [weakSelf.view showHUD];
            }
            else
            {
                weakSelf.pageNum += 1;
                [weakSelf.gamesArr addObjectsFromArray:games.data];
                [weakSelf.collectionView reloadData];
                if (games.pageCount == 0) {
                    [weakSelf.collectionView endRefreshWithNoMoreData];
                }
                else
                {
                    if (self.pageNum == games.pageCount) {
                        [weakSelf.collectionView endRefreshWithNoMoreData];
                    }
                }
            }
        }];
    }];
    
    
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.gamesArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YGGamesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    YGGamesDataItem *item = self.gamesArr[indexPath.row];
    [cell.iconIV setImageURL:item.thumb.yg_url];
    cell.titleLB.text = item.title;
    cell.nickLB.text = item.nick;
    if ([item.view integerValue] > 10000) {
        double result = [item.view integerValue];
        cell.audienceCountLB.text = [NSString stringWithFormat:@"%.1lf万", result / 10000];
    }
    else
    {
        cell.audienceCountLB.text = item.view;
    }
    cell.audienceCountIV.image = [UIImage imageNamed:@"audienceCount"];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YGGamesDataItem *item = self.gamesArr[indexPath.row];
    YGBroadcastRoomController *broadcastVC = [[YGBroadcastRoomController alloc] initWithUid:[item.uid doubleValue]];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:broadcastVC animated:YES];
    
}

#pragma mark - lazy
- (NSMutableArray *)gamesArr {
	if(_gamesArr == nil) {
		_gamesArr = [[NSMutableArray alloc] init];
	}
	return _gamesArr;
}

@end
