//
//  YGADWebViewController.h
//  YGDemo
//
//  Created by 阳光 on 2017/2/4.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGADWebViewController : UIViewController
- (instancetype)initWithURL:(NSURL *)webURL;
@property (nonatomic, strong) NSURL *webURL;
@end
