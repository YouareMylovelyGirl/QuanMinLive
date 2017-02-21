//
//  YGPageController.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGPageController.h"
#import "YGRecommendController.h"
#import "YGNetManager.h"
#import "YGRecommendItem.h"
#import "YGGamesController.h"
#import "YGGameFlowLayout.h"
#import "YGLiveController.h"
#import "YGLiveFlowLayout.h"
#import "YGHeadListItem.h"
#import "YGShowingFlowLayout.h"
#import "YGShowingController.h"
#import "YGListFlowLayout.h"
#import "YGListCell.h"
@interface YGPageController ()<WMPageControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray<YGHeadListItem *> *headListArr;
//中文名字
@property (nonatomic, strong) NSMutableArray *tempArr;
//slug
@property (nonatomic, strong) NSMutableArray *slugArr;
//列表
@property (nonatomic, strong) UICollectionView *collectionView;
//列表背景
@property (nonatomic, strong) UIView *backGroundView;
//列表中的item
@property (nonatomic, strong) NSArray *listArr;
/** 横条view */
@property(nonatomic,strong)UIView *lineView;
//动画是否运行
@property (nonatomic, assign) BOOL isRuning;
//collectionView中有slug值
@property (nonatomic, strong) NSMutableArray *slugArray;
//按钮播放动画的UIImageVIew
@property (nonatomic, strong) UIImageView *animView;
//右侧按钮
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation YGPageController

- (instancetype)init
{
    if ( self = [super init]) {
        self.menuItemWidth = 100;
        self.menuBGColor = [UIColor colorWithRed:246/255.0 green:251/255.0 blue:254/255.0 alpha:1];
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleSizeNormal = 17;
        self.menuBGColor = [UIColor whiteColor];
        self.titleSizeSelected = self.titleSizeNormal;
        self.titleColorNormal = [UIColor redColor];
        self.titleColorSelected = self.titleColorNormal;
        self.automaticallyCalculatesItemWidths = YES; //根据题目的内容自动算宽度
        self.itemMargin = 15; //题目的间距
        self.menuViewLayoutMode = WMMenuViewLayoutModeLeft; //题目左对齐 而不是平分
        
        self.menuHeight = 44;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_nav_logo_zhibo_105x27_"]];
    self.navigationItem.titleView = imageView;
    //刚加载时没有运行
    self.isRuning = 0;
    
    [YGNetManager GETTitleListCompltionHandler:^(NSArray<YGHeadListItem *> *headLists, NSError *error) {
        if (!error) {
            self.headListArr = headLists;
            [self reloadData];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 7, 30, 30);
            //设置按钮图片
            [btn setBackgroundImage:[UIImage imageNamed:@"img_tap_btn_zhankai1"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"img_tap_btn_zhankai1"] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageNamed:@"img_tap_btn_helong1"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"img_tap_btn_helong1"] forState:UIControlStateSelected | UIControlStateHighlighted];
            [btn addTarget:self action:@selector(btnShowLiveList:) forControlEvents:UIControlEventTouchUpInside];
            self.menuView.backgroundColor = [UIColor clearColor];
            self.menuView.rightView = btn;
            
        }
    }];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - btnClick 方法
- (void)btnShowLiveList:(UIButton *)sender
{
    self.rightBtn = sender;
    sender.selected = !sender.selected;
    NSLog(@"---------------------%@", NSStringFromCGRect(self.backGroundView.frame));
    
    //创建标题view
    [self creatLineView];
    //点击状态下
    if (sender.selected) {
        [self creatZhanKaiAnimation];
        //        [animView performSelector:@selector(removeImages) withObject:nil afterDelay:animView.animationDuration * 1];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            //添加等待视图
            [self.view showHUD];
            self.isRuning = 1;
            if (self.isRuning == 1) {
                sender.userInteractionEnabled = NO;
            }
            
            self.backGroundView.frame = self.scrollView.frame;
            self.lineView.alpha = 1;
            
        } completion:^(BOOL finished) {
            [self.view hideHUD];
            self.isRuning = 0;
            if (self.isRuning == 0) {
                sender.userInteractionEnabled = YES;
            }
            [self creatCollectionView];
            //等加载完成之后销毁数组中的图片
            [[self.animView viewWithTag:100] removeFromSuperview];
        }];
    }
    else
    {
        [self creatHeLongAnimtaion];
        [UIView animateWithDuration:0.3 animations:^{
            self.isRuning = 1;
            if (self.isRuning == 1) {
                sender.userInteractionEnabled = NO;
            }
            self.backGroundView.clipsToBounds = YES;
            self.backGroundView.frame = self.scrollView.frame;
            CGRect backRect = self.backGroundView.frame;
            backRect.size.height = 0;
            self.backGroundView.frame = backRect;
            
            self.lineView.alpha = 0;
            
            
            
        } completion:^(BOOL finished) {
            self.isRuning = 0;
            if (self.isRuning  == 0) {
                sender.userInteractionEnabled = YES;
            }
            [[self.animView viewWithTag:101] removeFromSuperview];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建展开按钮动画
- (void)creatZhanKaiAnimation
{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 12; i ++) {
        
        UIImage *selImage = [UIImage imageNamed:[NSString stringWithFormat:@"img_tap_btn_zhankai%ld", i + 1]];
        NSLog(@"文件 路径 i=%ld  %@",i , selImage);
        [tempArr addObject:selImage];
    }
    UIImageView *animView = [[UIImageView alloc] init];
    animView.frame = CGRectMake(0, 7, 30, 30);
    animView.center = self.rightBtn.center;
    //设置tag值为了选中以后释放
    animView.tag = 100;
    animView.animationImages = tempArr;
    animView.animationDuration = 0.3;
    animView.animationRepeatCount = 1;
    [animView startAnimating];
    [self.view addSubview:animView];
    self.animView = animView;
}

#pragma mark - 创建合拢时候的按钮动画
- (void)creatHeLongAnimtaion
{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 16; i ++) {
        
        UIImage *selImage = [UIImage imageNamed:[NSString stringWithFormat:@"img_tap_btn_helong%ld", i + 1]];
        NSLog(@"文件 路径 i=%ld  %@",i , selImage);
        [tempArr addObject:selImage];
    }
    UIImageView *animView = [[UIImageView alloc] init];
    animView.frame = CGRectMake(0, 7, 30, 30);
    animView.center = self.rightBtn.center;
    //设置tag值为了选中以后释放
    animView.tag = 101;
    animView.animationImages = tempArr;
    animView.animationDuration = 0.3;
    animView.animationRepeatCount = 1;
    [animView startAnimating];
    [self.view addSubview:animView];
    self.animView = animView;
}

#pragma mark - 创建lineView
- (void)creatLineView
{
    if (self.lineView) {
        return;
    }
    self.lineView = [[UIView alloc] init];
    self.lineView.frame = self.menuView.scrollView.frame;
    self.lineView.backgroundColor = [UIColor whiteColor];
    [self.menuView addSubview:self.lineView];
    UILabel *gameLabel = [[UILabel alloc]init];
    gameLabel.text = @"我的游戏";
    gameLabel.font = [UIFont systemFontOfSize:17];
    [self.lineView addSubview:gameLabel];
    [gameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.offset(0);
    }];
    //    self.lineView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 30, 30);
    self.lineView.alpha = 0;
    self.lineView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 创建collectionView
- (void)creatCollectionView
{
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.scrollView.bounds collectionViewLayout:[[YGListFlowLayout alloc] init]];
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.scrollView.size.height);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[YGListCell class] forCellWithReuseIdentifier:@"cell"];
    //    NSLog(@"-------------------------------%@", NSStringFromCGRect(self.scrollView.frame));
    [YGNetManager GETTitleListCompltionHandler:^(NSArray<YGHeadListItem *> *headLists, NSError *error) {
        for (YGHeadListItem *headItem in headLists) {
            if (![headItem.slug isEqualToString:@""]) {
                
                [self.slugArray addObject:headItem];
                
            }
        }
        
        [self.collectionView reloadData];
        [self.backGroundView addSubview:self.collectionView];
    }];
}


- (NSArray<NSString *> *)titles
{
    //    NSString *recommend = @"推荐";
    //    NSString *all = @"全部";
    //    [self.tempArr addObject:recommend];
    //    [self.tempArr addObject:all];
    //    for (YGHeadListItem *item in self.headListArr) {
    //        //中文名字
    //        [self.tempArr addObject:item.name];
    //        //slug
    //        [self.slugArr addObject:item.slug];
    //    }
    //    
    //    return self.tempArr.copy;
    
    
    //便利slug
    for (YGHeadListItem *item in self.headListArr) {
        //slug
        [self.slugArr addObject:item.slug];
    }
    //便利中文名称
    if (self.headListArr.count > 0) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        [tmpArr addObjectsFromArray:@[@"推荐", @"全部"]];
        [self.headListArr enumerateObjectsUsingBlock:^(YGHeadListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.is_default) {
                [tmpArr addObject:obj.name];
            }
        }];
        return tmpArr;
    }
    return @[@"推荐", @"全部"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    if (index == 0) {
        return [[YGRecommendController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    }
    if (index == 1) {
        return [[YGLiveController alloc] initWithCollectionViewLayout:[[YGLiveFlowLayout alloc] init]];
    }
    if (index == 2) {
        return [[YGShowingController alloc] initWithCollectionViewLayout:[[YGShowingFlowLayout alloc] init]];
    }
    else
    {
        YGGamesController *VC = [[YGGamesController alloc] initWithCollectionViewLayout:[[YGGameFlowLayout alloc]init]];
        VC.slug = self.slugArr[index - 2];
        VC.index = index;
        return VC;
    }
    
}

#pragma mark - UICollectionViewDataSourse
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.slugArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YGListCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    YGHeadListItem *item = self.slugArray[indexPath.row];
    [cell.iconIV setImageURL:item.icon_image.yg_url];
    cell.nameLB.text = item.name;
    return cell;
}

#pragma mark - UICollectionViewDeleGate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YGHeadListItem *headListItem = self.headListArr[indexPath.row];
    if (headListItem.ID == 29)
    {
        YGShowingController *showingVC = [[YGShowingController alloc] initWithCollectionViewLayout:[[YGShowingFlowLayout alloc] init]];
        showingVC.title = @"热门";
        [self.navigationController pushViewController:showingVC animated:YES];
    }
    else
    {
        YGGamesController *gamesVC = [[YGGamesController alloc] initWithCollectionViewLayout:[[YGGameFlowLayout alloc] init]];
        gamesVC.navName = headListItem.name;
        gamesVC.slug = headListItem.slug;
        [self.navigationController pushViewController:gamesVC animated:YES];
    }
    
}

#pragma mark - lazy
- (NSMutableArray *)tempArr {
    if(_tempArr == nil) {
        _tempArr = [[NSMutableArray alloc] init];
    }
    return _tempArr;
}

- (NSMutableArray *)slugArr {
    if(_slugArr == nil) {
        _slugArr = [[NSMutableArray alloc] init];
    }
    return _slugArr;
}



- (UIView *)backGroundView {
    if(_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.frame = self.scrollView.frame;
        CGRect backRect = _backGroundView.frame;
        backRect.size.height = 1;
        backRect.size.width = [UIScreen mainScreen].bounds.size.width;
        
        _backGroundView.frame = backRect;
        
        _backGroundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_backGroundView];
        [self.backGroundView addSubview:self.collectionView];
    }
    return _backGroundView;
}



- (NSMutableArray *)slugArray {
    if(_slugArray == nil) {
        _slugArray = [[NSMutableArray alloc] init];
    }
    return _slugArray;
}

@end
