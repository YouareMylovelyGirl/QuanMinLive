//
//  AppDelegate.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/18.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//当前设备设备朝向
@property (nonatomic, assign) UIInterfaceOrientationMask currentSupportOrientation;

@end

