//
//  NETWhiteBaseViewController.m
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/21.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import "NETWhiteBaseViewController.h"
#import <NETURLSchemeHandler/NETURLSchemeHandler.h>
#import <Masonry/Masonry.h>

//仅用于测试
#import "NETWhiteUtils.h"

@interface NETWhiteBaseViewController ()<WhiteCommonCallbackDelegate>
@property (nonatomic, strong, nullable) NETURLSchemeHandler *schemeHandler API_AVAILABLE(ios(11.0));
@end

static NSString *kPPTScheme = @"netless";

@implementation NETWhiteBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];

    [self initSDK];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [UIApplication sharedApplication].statusBarOrientation = self.UIInterfaceOrientationLandscapeLeft;
}

- (void)setupViews {
    // 1. 初始化 WhiteBoardView，
    // FIXME: 请提前加入视图栈，否则 iOS12 上，SDK 无法正常初始化。
    
    if (@available(iOS 11, *)) {
        // 在初始化 sdk 时，配置 PPTParams 的 scheme，保证与此处传入的 scheme 一致。
        self.schemeHandler = [[NETURLSchemeHandler alloc] initWithScheme:kPPTScheme directory:NSTemporaryDirectory()];
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        [config setURLSchemeHandler:self.schemeHandler forURLScheme:kPPTScheme];
        self.boardView = [[WhiteBoardView alloc] initWithFrame:CGRectZero configuration:config];
    } else {
        self.boardView = [[WhiteBoardView alloc] init];
    }
    [self.view addSubview:self.boardView];
    
    // 2. 为 WhiteBoardView 做 iOS10 及其以下兼容
    /*
     WhiteBoardView 内部有 UIScrollView,
     在 iOS 10及其以下时，如果 WhiteBoardView 是当前视图栈中第一个 UIScrollView 的话，会出现内容错位。
     */
    if (@available(iOS 11, *)) {
    } else {
        //可以参考此处处理
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 3. 使用 Masonry 进行 Autolayout 处理
    [self.boardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrame) name:@"changeframe" object:nil];
}

- (void)changeFrame
{
    static int i = 0;
    if (i % 3 == 1) {
        [self.boardView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.left.bottom.right.equalTo(self.view);
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            // room 需要调用 refreshViewSize（由于文字教具弹起键盘的原因，sdk 无法主动调用）
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
        });
    } else if (i % 3 == 0) {
        [self.boardView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.width.equalTo(@90);
            make.height.equalTo(@51);
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            // room 需要调用 refreshViewSize（由于文字教具弹起键盘的原因，sdk 无法主动调用）
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
        });
    } else if (i % 3 == 2) {
        [self.boardView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.view).inset(200);
            make.left.right.equalTo(self.view).inset(50);
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            // room 需要调用 refreshViewSize（由于文字教具弹起键盘的原因，sdk 无法主动调用）
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
        });
    }
    i++;
}

#pragma mark - WhiteSDK
- (WhiteSdkConfiguration *)sdkConfig
{
    if (!_sdkConfig) {
        // 4. 初始化 SDK 配置项，根据需求配置属性
            WhiteSdkConfiguration *config = [[WhiteSdkConfiguration alloc] initWithApp:[NETWhiteUtils appIdentifier]];
        config.renderEngine = WhiteSdkRenderEngineCanvas;
        
        //如果不需要拦截图片API，则不需要开启，页面内容较为复杂时，可能会有性能问题
        //    config.enableInterrupterAPI = YES;
        config.log = YES;
        
        //自定义 netless 协议，所有 ppt 请求，都由 https 更改为 kPPTScheme
        if (@available(iOS 11.0, *)) {
            WhitePptParams *pptParams = [[WhitePptParams alloc] init];
            pptParams.scheme = kPPTScheme;
            config.pptParams = pptParams;
        }
        
        //打开用户头像显示信息
        config.userCursor = YES;
        _sdkConfig = config;
    }
    return _sdkConfig;
}

- (void)initSDK {
    // 5.初始化 SDK，传入 commomDelegate
    self.sdk = [[WhiteSDK alloc] initWithWhiteBoardView:self.boardView config:self.sdkConfig commonCallbackDelegate:self.commonDelegate];
}

#pragma mark - CallbackDelegate
- (id<WhiteCommonCallbackDelegate>)commonDelegate
{
    if (!_commonDelegate) {
        _commonDelegate = self;
    }
    return _commonDelegate;
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
