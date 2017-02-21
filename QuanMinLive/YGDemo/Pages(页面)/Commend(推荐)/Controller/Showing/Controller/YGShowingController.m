//
//  YGShowingController.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/20.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGShowingController.h"
#import "YGNetManager.h"
#import "YGShowingCell.h"
#import "YGShowingItem.h"
#import "YGBeautifulController.h"
@interface YGShowingController ()
@property (nonatomic, strong) NSMutableArray *showingArr;
@end

@implementation YGShowingController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
}

- (void)configUI
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        [YGNetManager GETShowingCompletionHandler:^(YGShowingItem *showing, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (!error) {
                [weakSelf.showingArr addObjectsFromArray:showing.data];
                [weakSelf.collectionView reloadData];
            }
        }];
    }];
    [self.collectionView beginHeaderRefresh];
    [self.collectionView registerClass:[YGShowingCell class] forCellWithReuseIdentifier:reuseIdentifier];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.showingArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YGShowingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    YGShowingDataItem *item = self.showingArr[indexPath.row];
    
    [cell.iconIV setImageURL:item.avatar.yg_url];
    cell.titleLB.text = item.title;
    cell.nickLB.text = item.nick;
    if ([item.view integerValue] > 10000) {
        cell.audienceCountLB.text = [NSString stringWithFormat:@"%.1lf万", [item.view integerValue] / 10000.0];
    }
    else
    {
        cell.audienceCountLB.text = item.view;
    }
    cell.audienceCountIV.image = [UIImage imageNamed:@"audienceCount"];
    cell.placeLB.text = item.position;
    cell.placeLV.image = [UIImage imageNamed:@"sy_location_big"];
    return cell;

    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YGShowingDataItem *item = self.showingArr[indexPath.row];
    YGBeautifulController *beauVC = [[YGBeautifulController alloc] initWithUid:[item.uid integerValue]];
    NSLog(@"%ld", item.screen);
    [self.navigationController pushViewController:beauVC animated:YES];
}

- (NSMutableArray *)showingArr {
    if(_showingArr == nil) {
        _showingArr = [[NSMutableArray alloc] init];
    }
    return _showingArr;
}

@end
