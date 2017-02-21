//
//  YGRecommendController.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGRecommendController.h"
#import "YGNetManager.h"
#import "YGRecommendItem.h"
#import "YGRecommendShowingCell.h"
#import "YGRecommendCommendCell.h"
#import "YGRecommendHeadReusableView.h"
#import "YGLiveController.h"
#import "YGADCell.h"
#import "YGLiveController.h"
#import "YGLiveFlowLayout.h"
#import "YGShowingController.h"
#import "YGShowingFlowLayout.h"
#import "YGGamesController.h"
#import "YGGameFlowLayout.h"
#import "YGBroadcastRoomController.h"
#import "YGADWebViewController.h"
#import "YGBeautifulController.h"

@interface YGRecommendController ()<UICollectionViewDelegateFlowLayout,iCarouselDelegate,iCarouselDataSource, UICollectionViewDelegate>
//推荐
@property (nonatomic, strong) NSMutableArray *recommendArr;
//AD
@property (nonatomic, strong) NSArray<YGADIosFocusItem *> *adArr;
//titleList
@property (nonatomic, strong) NSArray<YGHeadListItem *> *titleListArr;

//list中有直播的
@property (nonatomic, strong) NSMutableArray *livingMarr;


//滚动视图

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YGRecommendController



#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:251/255.0 blue:254/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    
    [self configShow];
    [self configTitleList];
    
    
    
}

#pragma mark - 解析titleList列表拿到图片
- (void)configTitleList
{
    [YGNetManager GETTitleListCompltionHandler:^(NSArray<YGHeadListItem *> *headLists, NSError *error) {
        if (!error) {
            self.titleListArr = headLists;
            [self.collectionView reloadData];
        }
    }];
}


- (void)configShow
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        [YGNetManager GETRecommendItemCompletionHandler:^(YGRecommendItem *recommendItems, NSError *error) {
            [weakSelf.collectionView endHeaderRefresh];
            if (!error) {
                [weakSelf.recommendArr removeAllObjects];
                //将list中没有元素的数组筛选出区
                for (YGRecommendRoomItem *roomItems in recommendItems.room) {
                    if (roomItems.list.count != 0) {
                        [weakSelf.recommendArr addObject:roomItems];
                    }
                }
                NSLog(@"%ld", weakSelf.recommendArr.count);
                [weakSelf.collectionView reloadData];
                
                
            }
        }];
    }];
    
    
    [self.collectionView beginHeaderRefresh];
    
    [self.collectionView registerClass:[YGRecommendShowingCell class] forCellWithReuseIdentifier:@"YGRecommendShowingCell"];
    [self.collectionView registerClass:[YGRecommendCommendCell class] forCellWithReuseIdentifier:@"YGRecommendCommendCell"];
    [self.collectionView registerClass:[YGADCell class] forCellWithReuseIdentifier:@"YGADCell"];
    [self.collectionView beginHeaderRefresh];
    
    [YGNetManager GETADCompletionHandler:^(YGADItem *adItems, NSError *error) {
        if (!error) {
            self.adArr = adItems.iosFocus;
            [self.collectionView reloadData];
            
        }
    }];
    
    
    //注册头部
    [self.collectionView registerClass:[YGRecommendHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YGRecommendHeadReusableView"];
}

#pragma mark -  返回头部分组的样子
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YGRecommendHeadReusableView *recommendHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"YGRecommendHeadReusableView" forIndexPath:indexPath];
        //调用右边按钮
        YGRecommendRoomItem *roomItem = self.recommendArr[indexPath.section - 1];
        [recommendHeadView rigthButton];
        
        //右侧按钮的跳转回调
        recommendHeadView.rightBtnGo = ^(void){
            if (roomItem.ID == 0)
            {
                YGLiveController *liveVC = [[YGLiveController alloc] initWithCollectionViewLayout:[[YGLiveFlowLayout alloc] init]];
                liveVC.title = @"直播";
                [self.navigationController pushViewController:liveVC animated:YES];
            }
            else if (roomItem.ID == 29)
            {
                YGShowingController *showingVC = [[YGShowingController alloc] initWithCollectionViewLayout:[[YGShowingFlowLayout alloc] init]];
                showingVC.title = @"热门";
                [self.navigationController pushViewController:showingVC animated:YES];
            }
            else
            {
                YGGamesController *gamesVC = [[YGGamesController alloc] initWithCollectionViewLayout:[[YGGameFlowLayout alloc] init]];
                gamesVC.navName = roomItem.name;
                gamesVC.slug = roomItem.slug;
                [self.navigationController pushViewController:gamesVC animated:YES];
            }
            
        };
        
        //创建左边文字和图片
        if (indexPath.section == 1) {
            recommendHeadView.leftImageIV.image = [UIImage imageNamed:@"ic_all_selected"];
            recommendHeadView.leftLabel.text = roomItem.name;
            return recommendHeadView;
        }
        
        [recommendHeadView.leftImageIV setImageURL:roomItem.icon.yg_url];
        recommendHeadView.leftLabel.text = roomItem.name;
        
        [recommendHeadView addSubview:recommendHeadView.headView];
        
        return recommendHeadView;
    }
    return [[UICollectionReusableView alloc] init];
    
    
}

#pragma mark - 分组头视图的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
}


#pragma mark - collectionDataSourse
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.recommendArr.count ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    YGRecommendRoomItem *item = self.recommendArr[section - 1];
    return item.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        [self.timer invalidate];
        YGADCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGADCell" forIndexPath:indexPath];
        cell.ic.delegate = self;
        cell.ic.dataSource = self;
        self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:3 block:^(NSTimer *timer) {
            [cell.ic scrollToItemAtIndex:cell.ic.currentItemIndex + 1 animated:YES];
        } repeats:YES];
        cell.pc.numberOfPages = self.adArr.count;
        [cell.ic reloadData];
        return cell;
    }
    else
    {
        YGRecommendRoomItem *roomItem = self.recommendArr[indexPath.section - 1];
        YGRecommendRoomListItem *item = roomItem.list[indexPath.row];
        if (roomItem.screen == 1) {
            YGRecommendShowingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGRecommendShowingCell" forIndexPath:indexPath];
            
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
            cell.placeLB.text = item.position;
            cell.placeLV.image = [UIImage imageNamed:@"sy_location_big"];
            return cell;
        }
        YGRecommendCommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGRecommendCommendCell" forIndexPath:indexPath];
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
    
}


// cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //广告 144 x 44
    if (indexPath.section == 0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 44 / 144);
    }
    if (indexPath.section == 2) { //正方形
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 30) / 2);
        return CGSizeMake(width, width + 25);
    }else{
        CGFloat width = (long)(([UIScreen mainScreen].bounds.size.width - 30) / 2);
        //390 219
        return CGSizeMake(width, width * 219 / 390.0 + 30);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;{
    if (section < 1 || section == self.recommendArr.count) {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsMake(0, 10, 20, 10);
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0) {
        YGRecommendRoomItem *roomItem = self.recommendArr[indexPath.section - 1];
        YGRecommendRoomListItem *item = roomItem.list[indexPath.row];
        if ([item.category_name isEqualToString:@"Showing"]) {
            YGBeautifulController *beauVC = [[YGBeautifulController alloc] initWithUid:item.uid];
            [self.navigationController pushViewController:beauVC animated:YES];
        } else {
            YGBroadcastRoomController *boradcastVC = [[YGBroadcastRoomController alloc] initWithUid:item.uid];
            NSLog(@"%ld", item.uid);
            self.navigationController.hidesBottomBarWhenPushed = YES;
            
            self.tabBarController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:boradcastVC animated:YES];
        }
    }
}


#pragma mark - ic 代理方法
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.adArr.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view) {
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        UIImageView *iconIV = [[UIImageView alloc] init];
        [view addSubview:iconIV];
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        iconIV.contentMode = UIViewContentModeScaleAspectFill;
        iconIV.clipsToBounds = YES;
        iconIV.tag = 100;
    }
    UIImageView *iconIV = [view viewWithTag:100];
    
    [iconIV setImageURL:self.adArr[index].thumb.yg_url];
    return view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    ((YGADCell *)(carousel.superview.superview)).pc.currentPage = carousel.currentItemIndex;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap) {
        value = YES;
    }
    return value;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    YGADIosFocusItem *focusItem = self.adArr[index];
    if ([focusItem.type isEqualToString:@"ad"]) {
        YGADWebViewController *webVc = [[YGADWebViewController alloc] initWithURL:focusItem.link.yg_url];
        [self.navigationController pushViewController:webVc animated:YES];
    }
    if ([focusItem.type isEqualToString:@"play"]) {
        YGADIosFocusItem *focusItem = self.adArr[index];
        YGBroadcastRoomController *broadCastVC = [[YGBroadcastRoomController alloc] initWithUid:[focusItem.uid doubleValue]];
        [self.navigationController pushViewController:broadCastVC animated:YES];
        
    }
    
    
    
}

#pragma mark - lzay
- (NSMutableArray<YGRecommendRoomItem *> *)recommendArr {
    if(_recommendArr == nil) {
        _recommendArr = [[NSMutableArray<YGRecommendRoomItem *> alloc] init];
    }
    return _recommendArr;
}

- (NSMutableArray *)livingMarr {
    if(_livingMarr == nil) {
        _livingMarr = [[NSMutableArray alloc] init];
    }
    return _livingMarr;
}

@end
