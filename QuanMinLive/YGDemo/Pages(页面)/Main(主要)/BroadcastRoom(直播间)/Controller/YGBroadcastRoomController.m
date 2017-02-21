//
//  YGBroadcastRoomController.m
//  YGDemo
//
//  Created by 阳光 on 2017/2/3.
//  Copyright © 2017年 YG. All rights reserved.
//

#import "YGBroadcastRoomController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "AppDelegate.h"
#import "YGBroadcastItem.h"
#import "YGNetManager.h"
#import "YGChatPageController.h"
@interface YGBroadcastRoomController ()<UITextFieldDelegate>
// 计算属性, 屏幕大小
@property (nonatomic, assign) CGSize screenSize;
//ijkPlayer
@property (nonatomic, strong) IJKFFMoviePlayerController *ijkPlayer;
//播放url地址
@property (nonatomic, strong) NSString *moviePath;
//返回按钮
@property (nonatomic, strong) UIButton *backBtn;
//强制全屏按钮
@property (nonatomic, strong) UIButton *changeScreenBtn;
//覆盖在ijkPlayer上面的view
@property (nonatomic, strong) UIView *faceView;
//键盘输入
@property (nonatomic, strong) UITextField *textField;
//键盘输入背景view
@property (nonatomic, strong) UIView *textBgView;
/** chatView */
@property(nonatomic, strong) UIView *pageView;

@end

@implementation YGBroadcastRoomController
//构造方法
- (instancetype)initWithUid:(NSInteger)uid
{
    if (self = [super init]) {
        self.uid = uid;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
    //设置设备朝向
    ((AppDelegate *)[UIApplication sharedApplication].delegate).currentSupportOrientation = UIInterfaceOrientationMaskAllButUpsideDown;
    
    //键盘谈起通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openkeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closekeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //等结束时只允许竖向
    ((AppDelegate *)[UIApplication sharedApplication].delegate).currentSupportOrientation = UIInterfaceOrientationMaskPortrait;
    //取消导航栏隐藏
    self.navigationController.navigationBarHidden = NO;
    //停止播放
    [self.ijkPlayer stop];
    [self.ijkPlayer shutdown];
    
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 修改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 获取当前设备朝向
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //获取当前设备朝向
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    //如果是横向的
    if (UIDeviceOrientationIsLandscape(orientation)) {
        self.ijkPlayer.view.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height);
        self.faceView.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height);
        self.changeScreenBtn.hidden = YES;
    } else {
        self.ijkPlayer.view.frame = CGRectMake(0, 20, self.screenSize.width, 200);
        self.faceView.frame = CGRectMake(0, 20, self.screenSize.width, 200);
        self.changeScreenBtn.hidden = NO;
    }
}

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:251/255.0 blue:254/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor orangeColor];
    [self configIjkPlayer];
    [self setupChatPageController];
    [self setupBackStateView];
    [self textField];
    [self tapGestureRec];
    [self dismissfaceViewWhenTap];
}

- (void)setupChatPageController
{
    YGChatPageController *chatVC = [[YGChatPageController alloc] init];
    
    chatVC.menuViewStyle = WMMenuViewStyleLine;
    UIButton *favorBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    favorBtn.backgroundColor = [UIColor redColor];
    favorBtn.frame = CGRectMake(0, 0, 80, 30);
    
    NSMutableAttributedString *titleStr = [NSMutableAttributedString new];
    NSTextAttachment *attentionImage = [NSTextAttachment new];
    attentionImage.image = [UIImage imageNamed:@"btn_detail_attention_36x30_"];
    attentionImage.bounds = CGRectMake(0, -3, 15, 15);
    NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attentionImage];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@" 关注" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [titleStr appendAttributedString:imageStr];
    [titleStr appendAttributedString:title];
    [favorBtn setAttributedTitle:titleStr forState:UIControlStateNormal];
    
    
    [self addChildViewController:chatVC];
    [self.view addSubview:chatVC.view];
    //翻页控制器的视图有 viewFrame属性来控制
    chatVC.viewFrame = CGRectMake(0, 220, self.screenSize.width, self.screenSize.height - 220 - 35);
    self.pageView = chatVC.view;
    chatVC.menuView.rightView = favorBtn;
}

//状态条背景
- (void)setupBackStateView
{
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screenSize.width, 20)];
    blackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackView];
    
}

- (void)configIjkPlayer
{
    
    [YGNetManager GETBroadcast:self.uid completionHandler:^(YGBroadcastItem *broadcasts, NSError *error) {
        //由高到底筛选画质
        self.moviePath = broadcasts.live.ws.hls.five.src;
        if (!self.moviePath) {
            self.moviePath = broadcasts.live.ws.hls.four.src;
        }
        if (!self.moviePath) {
            self.moviePath = broadcasts.live.ws.hls.three.src;
        }
        NSLog(@"------地址为--------------%@", self.moviePath);
        
        [self ijkPlayer];
        [self configUI];
    }];
    
}
- (void)configUI
{
    
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_sp_back"] forState:UIControlStateNormal];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_hp_back_click"] forState:UIControlStateHighlighted];
    [self.faceView addSubview:self.backBtn];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(25);
        make.top.left.offset(15);
    }];
    [self.backBtn addTarget:self action:@selector(goBackLastVC:) forControlEvents:UIControlEventTouchUpInside];
    
    //强制扩大按钮
    self.changeScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.changeScreenBtn setBackgroundColor:[UIColor clearColor]];
    [self.changeScreenBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_sp_qp"] forState:UIControlStateNormal];
    [self.changeScreenBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_sp_qp_click"] forState:UIControlStateHighlighted];
    [self.faceView addSubview:self.changeScreenBtn];
    NSLog(@"%@", self.ijkPlayer);
    [self.changeScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(35);
        make.right.bottom.offset(-10);
    }];
    [self.changeScreenBtn addTarget:self action:@selector(changeScreenBounds:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *smallImage = [[UIImageView alloc] init];
    [self.faceView addSubview:smallImage];
    smallImage.image = [UIImage imageNamed:@"img_shuiyin _quanping_110x32_"];
    [smallImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.right.offset(-20);
//        CGFloat scale = 60 / 24.0;
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(32);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//判断是否横屏 决定按钮点击事件
- (void)goBackLastVC:(UIButton *)sender
{
    //获取当前设备朝向
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    //如果是横向的
    if (UIDeviceOrientationIsLandscape(orientation)){
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            SEL selector = NSSelectorFromString(@"setOrientation:");
            
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            //设置调用方法
            [invocation setSelector:selector];
            //设置调用方法的对象
            [invocation setTarget:[UIDevice currentDevice]];
            int val = UIInterfaceOrientationPortraitUpsideDown;
            if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
                val = UIInterfaceOrientationPortrait;
            }
            //设置索引值2对应的参数. 索引值0 存的是target, 1存的是selector
            [invocation setArgument:&val atIndex:2];
            //启动这个方法调用的过程
            [invocation invoke];
        }
        
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//强制改变屏幕尺寸
- (void)changeScreenBounds:(UIButton *)sender
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        //设置调用方法
        [invocation setSelector:selector];
        //设置调用方法的对象
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        if (!UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            val = UIInterfaceOrientationLandscapeRight;
        }
        //设置索引值2对应的参数. 索引值0 存的是target, 1存的是selector
        [invocation setArgument:&val atIndex:2];
        //启动这个方法调用的过程
        [invocation invoke];
        
    }
}

#pragma mark - <UITextFieldDelegate>

#pragma mark - lazy

- (CGSize)screenSize
{
    return [UIScreen mainScreen].bounds.size;
}


- (UIView *)faceView {
    if(_faceView == nil) {
        //覆盖view
        _faceView = [[UIView alloc] init];
        _faceView.backgroundColor = [UIColor clearColor];
        _faceView.frame = CGRectMake(0, 20, self.screenSize.width, 200);
        [self.view addSubview:_faceView];
    }
    return _faceView;
}

- (UIButton *)backBtn {
    if(_backBtn == nil) {
        //返回按钮
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"btn_player_sp_back"] forState:UIControlStateNormal];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"btn_hp_back_click"] forState:UIControlStateHighlighted];
        [self.faceView addSubview:_backBtn];
        
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(25);
            make.top.left.offset(15);
        }];
        [_backBtn addTarget:self action:@selector(goBackLastVC:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (IJKFFMoviePlayerController *)ijkPlayer {
    if(_ijkPlayer == nil) {
        _ijkPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.moviePath withOptions:[IJKFFOptions optionsByDefault]];
        [_ijkPlayer.view setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:_ijkPlayer.view];
        _ijkPlayer.view.frame = CGRectMake(0, 20, self.screenSize.width, 200);
        _ijkPlayer.shouldAutoplay = YES;
        _ijkPlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
        //准备播放
        [_ijkPlayer prepareToPlay];
        [self.view addSubview:self.faceView];
    }
    return _ijkPlayer;
}


- (UITextField *)textField {
	if(_textField == nil) {
        
        self.textBgView = [[UIView alloc] init];
        self.textBgView.layer.borderWidth = 1;
        self.textBgView.layer.cornerRadius = 5;
        self.textBgView.backgroundColor = [UIColor whiteColor];
        self.textBgView.layer.masksToBounds = YES;
        self.textBgView.layer.borderColor = [UIColor orangeColor].CGColor;
        [self.view addSubview:self.textBgView];
        [self.textBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.offset(0);
            make.height.mas_equalTo(35);
        }];
        UIButton *emojiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [emojiBtn setBackgroundImage:[UIImage imageNamed:@"btn_hp_write_emoji"] forState:UIControlStateNormal];
        [self.textBgView addSubview:emojiBtn];
        [emojiBtn bk_addEventHandler:^(id sender) {
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
            make.size.equalTo(30);
        }];
        
        UIButton *giftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [giftBtn setBackgroundImage:[UIImage imageNamed:@"navBar_gift-static_image_25x25_"] forState:UIControlStateNormal];
        [self.textBgView addSubview:giftBtn];
        [giftBtn bk_addEventHandler:^(id sender) {
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
            make.size.equalTo(25);
        }];
        
		_textField = [[UITextField alloc] init];
        _textField.placeholder = @"弹幕走一走, 活到二十九";
        _textField.delegate = self;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        [self.textBgView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.textBgView);
            make.left.offset(60);
            make.right.offset(-60);
        }];
        [_textField addTarget:self action:@selector(finishKeyBoard) forControlEvents:UIControlEventEditingDidEndOnExit];
	}
	return _textField;
}
#pragma mark - 收起键盘
- (void)finishKeyBoard
{
    [self.textField resignFirstResponder];
}


//faceView点击后消失
- (void)dismissfaceViewWhenTap
{
    UITapGestureRecognizer *faceViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideFaceView)];
    [self.view addGestureRecognizer:faceViewTap];
}

- (void)hideFaceView
{
    self.faceView.hidden = !self.faceView.hidden ;
}

//滚动到最后一行
-(void)scrollToTableViewLastRow{
   
}

-(void)openkeyboard:(NSNotification*)noti{
    //键盘弹起后的frame
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //动画持续时间
    NSTimeInterval time = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画类型
    UIViewAnimationOptions options = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [self.textBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(-keyboardFrame.size.height);
        
    }];
    
//    self.viewBottomConstraint.constant = keyboardFrame.size.height;
    [UIView animateWithDuration:time delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
    [self scrollToTableViewLastRow];
    
}
-(void)closekeyboard:(NSNotification*)noti{
    //动画持续时间
    NSTimeInterval time = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画类型
    UIViewAnimationOptions options = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
//    self.viewBottomConstraint.constant = 0;
    [self.textBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(0);
        
    }];
    [UIView animateWithDuration:time delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

//添加点击手势
- (void)tapGestureRec
{
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    [self.view addGestureRecognizer:tapRec];
}

- (void)closeKeyBoard
{
    [self.textField resignFirstResponder];
}



@end
