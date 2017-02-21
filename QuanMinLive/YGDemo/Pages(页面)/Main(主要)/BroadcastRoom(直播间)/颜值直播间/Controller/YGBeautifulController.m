//
//  YGBeautifulController.m
//  YGDemo
//
//  Created by 阳光 on 2017/2/5.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGBeautifulController.h"
#import "YGBroadcastItem.h"
#import "YGNetManager.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "DMHeartFlyView.h"
@interface YGBeautifulController ()
{
    CGFloat _heartSize;
    NSTimer *_burstTimer;
}
/** 屏幕大小 */
@property(nonatomic, assign) CGSize screenSize;
/** 直播间模型 */
@property(nonatomic, strong) YGBroadcastItem *broadcastItem;
/** 关闭按钮 */
@property(nonatomic, strong) UIButton *closeBtn;
/** ijkPlayer */
@property(nonatomic, strong) IJKFFMoviePlayerController *ijkPlayer;



@end

@implementation YGBeautifulController

//构造方法
- (instancetype)initWithUid:(NSInteger)uid
{
    if (self = [super init]) {
        self.uid = uid;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //点击出心
    [self tapBecomeHeart];
    [YGNetManager GETBroadcast:self.uid completionHandler:^(YGBroadcastItem *broadcasts, NSError *error) {
        self.broadcastItem = broadcasts;
        [self playIJKPlayer];
        [self closeButton];
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
//ijkPlayer
- (void)playIJKPlayer
{
    self.ijkPlayer.view.backgroundColor = [UIColor blackColor];
    NSString *videoPath = @"";
    videoPath = self.broadcastItem.live.ws.hls.five.src;
    if (!videoPath) {
        videoPath = self.broadcastItem.live.ws.hls.four.src;
    }
    if (!videoPath) {
        videoPath = self.broadcastItem.live.ws.hls.three.src;
    }
    NSLog(@"%@", videoPath);
    
    self.ijkPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:videoPath withOptions:[IJKFFOptions optionsByDefault]];
    [self.view addSubview:self.ijkPlayer.view];
    [self.ijkPlayer.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    //视频填充模式
    self.ijkPlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    //是否自动播放
    self.ijkPlayer.shouldAutoplay = YES;
    //防止播放按钮把关闭按钮遮盖住, 所以强制把关闭按钮挪到最上面
    [self.ijkPlayer prepareToPlay];
}

//关闭按钮
- (void)closeButton
{
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_hp_guanggao_close"] forState:UIControlStateNormal];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_hp_guanggao_close_click"] forState:UIControlStateHighlighted];
    [self.view addSubview:self.closeBtn];
    [self.closeBtn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(28);
    }];
}

//状态条样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.ijkPlayer play];
}

#pragma mark - viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //停止播放器
    [self.ijkPlayer stop];
    //把播放器搞死
    [self.ijkPlayer shutdown];
    self.navigationController.navigationBarHidden = NO;
}

//计算属性
- (CGSize)screenSize
{
    return [UIScreen mainScreen].bounds.size;
}

#pragma mark - 点击出💗
- (void)tapBecomeHeart
{
    _heartSize = 36;
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showTheLove)];
    [self.view addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    longPressGesture.minimumPressDuration = 0.2;
    [self.view addGestureRecognizer:longPressGesture];
}

-(void)showTheLove{
    DMHeartFlyView* heart = [[DMHeartFlyView alloc]initWithFrame:CGRectMake(0, 0, _heartSize, _heartSize)];
    [self.view addSubview:heart];
    CGPoint fountainSource = CGPointMake(self.screenSize.width - _heartSize/2.0 - 20, self.view.bounds.size.height - _heartSize/2.0 - 10);
    heart.center = fountainSource;
    [heart animateInView:self.view];
}

-(void)longPressGesture:(UILongPressGestureRecognizer *)longPressGesture{
    switch (longPressGesture.state) {
        case UIGestureRecognizerStateBegan:
            _burstTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(showTheLove) userInfo:nil repeats:YES];
            break;
        case UIGestureRecognizerStateEnded:
            [_burstTimer invalidate];
            _burstTimer = nil;
            break;
        default:
            break;
    }
}

@end
