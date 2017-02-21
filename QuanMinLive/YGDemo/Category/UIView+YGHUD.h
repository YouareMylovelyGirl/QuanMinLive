//
//  UIView+YGHUD.h
//  YGDemo
//
//  Created by 阳光 on 2017/1/19.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
@interface UIView (YGHUD)
- (void)showHUD;

- (void)hideHUD;

- (void)showMessage:(NSString *)message;
@end
