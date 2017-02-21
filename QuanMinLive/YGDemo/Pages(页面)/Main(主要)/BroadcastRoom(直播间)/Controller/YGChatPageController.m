
//
//  YGChatPageController.m
//  YGDemo
//
//  Created by 阳光 on 2017/2/4.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGChatPageController.h"

@interface YGChatPageController ()

@end

@implementation YGChatPageController

- (NSArray<NSString *> *)titles
{
    return @[@"聊天", @"排行", @"主播"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    NSArray *colors = @[
                        [UIColor brownColor],
                        [UIColor blueColor],
                        [UIColor orangeColor]
                        ];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = colors[index];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
