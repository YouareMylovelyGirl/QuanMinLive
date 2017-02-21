//
//  YGFourceController.m
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGFourceController.h"
#import "YGRecommendController.h"
@interface YGFourceController ()

@end

@implementation YGFourceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI
{
    
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:251/255.0 blue:254/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"img_wgz_130x130_"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(self.view).offset(-80);
        make.size.mas_equalTo(130);
    }];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"您关注的直播先在还没有开播";
    textLabel.font = [UIFont systemFontOfSize:13];
    textLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView);
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
    }];
    
    UIView *backBtnView = [[UIView alloc] init];
    backBtnView.layer.borderWidth = 1;
    backBtnView.layer.cornerRadius = 10;
    backBtnView.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:backBtnView];
    [backBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(textLabel.mas_bottom).offset(20);
    }];
    
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [goBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [goBtn setTitle:@"看看当前精彩直播" forState:UIControlStateNormal];
    [backBtnView addSubview:goBtn];
    [goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(backBtnView);
    }];
    [goBtn addTarget:self action:@selector(goBackRecommend:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (void)goBackRecommend:(UIButton *)sender
{
//    YGRecommendController *recommendVC = [[YGRecommendController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
//    [self.navigationController pushViewController:recommendVC animated:YES];
    self.tabBarController.selectedIndex = 0;
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
