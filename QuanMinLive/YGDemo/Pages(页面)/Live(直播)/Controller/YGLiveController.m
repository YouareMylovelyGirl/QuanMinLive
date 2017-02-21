//
//  YGLiveController.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGLiveController.h"
#import "YGLiveCell.h"
#import "YGLiveItem.h"
#import "YGNetManager.h"
#import "YGBroadcastRoomController.h"
@interface YGLiveController ()
@property (nonatomic, strong) NSMutableArray<YGLiveDataItem *> *livesMArr;

//@property (nonatomic, strong) NSArray *liveArr;

@property (nonatomic, assign) NSInteger pageNum;
@end

@implementation YGLiveController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - 声明周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
}


- (void)configUI
{
    self.collectionView.backgroundColor = [UIColor colorWithRed:246/255.0 green:251/255.0 blue:254/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        [YGNetManager GETLiveItem:@"" completionHandler:^(YGLiveItem *liveItems, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (error) {
                [weakSelf.view showHUD];
            }
            else
            {
                weakSelf.pageNum = 1;
                [weakSelf.livesMArr removeAllObjects];
                [weakSelf.livesMArr addObjectsFromArray:liveItems.data];
                [weakSelf.collectionView reloadData];
                if (liveItems.pageCount == 0) {
                    [weakSelf.collectionView endRefreshWithNoMoreData];
                }
                else
                {
                    if (self.pageNum == liveItems.pageCount) {
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
    
    
    [self.collectionView addFooterRefresh:^{
        [YGNetManager GETLiveItem:[NSString stringWithFormat:@"_%ld",weakSelf.pageNum] completionHandler:^(YGLiveItem *liveItems, NSError *error) {
            [weakSelf.collectionView endFooterRefresh];
            if (error) {
                [weakSelf.view showHUD];
            }
            else
            {
                weakSelf.pageNum += 1;
                [weakSelf.livesMArr addObjectsFromArray:liveItems.data];
                [weakSelf.collectionView reloadData];
                if (liveItems.pageCount == 0) {
                    [weakSelf.collectionView endRefreshWithNoMoreData];
                }
                else
                {
                    if (self.pageNum == liveItems.pageCount) {
                        [weakSelf.collectionView endRefreshWithNoMoreData];
                    }
                }
            }
        }];
    }];
    
    
    [self.collectionView registerClass:[YGLiveCell class] forCellWithReuseIdentifier:reuseIdentifier];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.livesMArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YGLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    YGLiveDataItem *item = self.livesMArr[indexPath.row];
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

#pragma mark - UITableViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YGLiveDataItem *item = self.livesMArr[indexPath.row];
    YGBroadcastRoomController *broadcastVC = [[YGBroadcastRoomController alloc] initWithUid:[item.uid integerValue]];
    [self.navigationController pushViewController:broadcastVC animated:YES];
}



#pragma mark - 懒加载
- (NSMutableArray<YGLiveDataItem *> *)livesMArr {
    if(_livesMArr == nil) {
        _livesMArr = [[NSMutableArray<YGLiveDataItem *> alloc] init];
    }
    return _livesMArr;
}

@end
