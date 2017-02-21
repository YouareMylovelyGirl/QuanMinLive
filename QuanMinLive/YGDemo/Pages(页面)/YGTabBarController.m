//
//  YGTabBarController.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGTabBarController.h"
#import "YGFourceController.h"
#import "YGLiveController.h"
#import "YGMineController.h"
#import "YGRecommendController.h"
#import "YGPageController.h"

#import "YGLiveFlowLayout.h"
@interface YGTabBarController ()

@end

@implementation YGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配置Controller
    [self setupController];
    
    //配置全局属性
    [self configAllset];
    
    
}


#pragma mark - 配置全局属性
- (void)configAllset
{
    [UINavigationBar appearance].translucent = NO;
    [UITabBar appearance].translucent = NO;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:252/255.0 green:83/255.0 blue:88/255.0 alpha:1]} forState:UIControlStateSelected];
    
    [UIImageView appearance].contentMode = UIViewContentModeScaleAspectFill;
    [UIImageView appearance].clipsToBounds = YES;
    
    
}


#pragma mark - 配置Controller
- (void)setupController
{
    //直播导航
    YGLiveController *liveVC = [[YGLiveController alloc] initWithCollectionViewLayout:[[YGLiveFlowLayout alloc] init]];
    liveVC.title = @"直播";
    UINavigationController *liveNavi = [[UINavigationController alloc] initWithRootViewController:liveVC];
    liveVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_live_default"];
    liveVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_live_selected"];
    
    //栏导航
    YGFourceController *fourceVC = [[YGFourceController alloc] init];
    fourceVC.title = @"关注";
    UINavigationController *fourceNavi = [[UINavigationController alloc] initWithRootViewController:fourceVC];
    fourceVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_follow_default"];
    fourceVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_follow_selected"];
    
    //推荐导航
    //    YGRecommendController *recommendVC = [[YGRecommendController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    YGPageController *pageVC = [[YGPageController alloc]init];
    
    UINavigationController *recommendNavi = [[UINavigationController alloc] initWithRootViewController:pageVC];
    recommendNavi.title = @"首页";
    recommendNavi.tabBarItem.image = [UIImage imageNamed:@"tabbar_home_default"];
    recommendNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    [UICollectionView appearance].backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    //我的导航
    YGMineController *mineVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YGMineController"];
    mineVC.title = @"我的";
    UINavigationController *mineNavi = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_mine_default"];
    mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mine_selected"];
    
    self.viewControllers = @[recommendNavi, liveNavi, fourceNavi, mineNavi];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
