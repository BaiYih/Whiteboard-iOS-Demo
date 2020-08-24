//
//  NETWhiteRoomViewController.m
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/21.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import "NETWhiteRoomViewController.h"
#import <Masonry/Masonry.h>
#import "NETWhiteNavigationController.h"
#import "NETRoomViewModel.h"
#import "NETAppDelegate.h"
#import "UIDevice+WhiteboardDevice.h"

@interface NETWhiteRoomViewController ()<WhiteRoomCallbackDelegate, WhiteCommonCallbackDelegate, UIPopoverPresentationControllerDelegate>

@property (nonatomic, copy) NSString *roomToken;

@end

@implementation NETWhiteRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
    [self setupData];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    NETAppDelegate * appDelegate = (NETAppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = YES;
    [UIDevice setupOrientation:UIInterfaceOrientationLandscapeRight];
    
    /**********/
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.backgroundColor = [UIColor grayColor];
    [closeButton addTarget:self action:@selector(actionFinishButton:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [self.view addSubview:closeButton];

    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(20);
        make.width.and.height.equalTo(@(40));
    }];
    /**********/
    
}

- (void)setupData
{
    if (self.roomUuid.length) {
        [self joinExistRoom];
    } else {
        [self joinNewRoom];
    }
}

#pragma mark - CallbackDelegate
- (id<WhiteRoomCallbackDelegate>)roomCallbackDelegate
{
    if (!_roomCallbackDelegate) {
        _roomCallbackDelegate = self;
    }
    return _roomCallbackDelegate;
}

- (void)actionFinishButton:(id)sender
{
    NETAppDelegate * appDelegate = (NETAppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;
    //切换到竖屏
    [UIDevice setupOrientation:UIInterfaceOrientationPortrait];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)joinNewRoom
{
    self.title = NSLocalizedString(@"创建房间中...", nil);
    [NETRoomViewModel createRoomWithCompletionHandler:^(NSString * _Nullable uuid, NSString * _Nullable roomToken, NSError * _Nullable error) {
        if (error) {
//            if (self.roomBlock) {
//                self.roomBlock(nil, error);
//            } else {
//                NSLog(NSLocalizedString(@"创建房间失败，error:", nil), [error description]);
//                self.title = NSLocalizedString(@"创建失败", nil);
//            }
            NSLog(NSLocalizedString(@"创建房间失败，error:", nil), [error description]);
            self.title = NSLocalizedString(@"创建失败", nil);
        } else {
            self.roomUuid = uuid;
            if (self.roomUuid && roomToken) {
                [self joinRoomWithToken:roomToken];
            } else {
                NSLog(NSLocalizedString(@"连接房间失败，room uuid:%@ roomToken:%@", nil), self.roomUuid, roomToken);
                self.title = NSLocalizedString(@"创建失败", nil);
            }
        }
    }];
}

- (void)joinExistRoom
{
    self.title = NSLocalizedString(@"加入房间中...", nil);
    [NETRoomViewModel getRoomTokenWithUuid:self.roomUuid accessKey:nil lifespan:0 role:@"admin" completionHandler:^(NSString * _Nullable roomToken, NSError * _Nullable error) {
        if (roomToken) {
            self.roomToken = roomToken;
             [self joinRoomWithToken:roomToken];
         } else {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"获取 RoomToken 失败", nil) message:[NSString stringWithFormat:@"错误信息:%@", [error description]] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }];
}

- (void)joinRoomWithToken:(NSString *)roomToken
{
    self.title = NSLocalizedString(@"正在连接房间", nil);
    
    if (!self.roomConfig) {
        NSDictionary *payload = @{@"avatar": @"https://white-pan.oss-cn-shanghai.aliyuncs.com/40/image/mask.jpg"};
        WhiteRoomConfig *roomConfig = [[WhiteRoomConfig alloc] initWithUuid:self.roomUuid roomToken:roomToken userPayload:payload];
        // 配置，橡皮擦是否能删除图片。默认为 false，能够删除图片。
//         roomConfig.disableEraseImage = YES;
        self.roomConfig = roomConfig;
    }

    [self.sdk joinRoomWithConfig:self.roomConfig callbacks:self.roomCallbackDelegate completionHandler:^(BOOL success, WhiteRoom * _Nonnull room, NSError * _Nonnull error) {

        if (success) {
            self.title = NSLocalizedString(@"我的白板", nil);

            self.roomToken = roomToken;
            self.room = room;

            //TODO:加入成功逻辑处理
            
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"加入房间成功", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            }];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        } else {
            self.title = NSLocalizedString(@"加入失败", nil);
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"加入房间失败", nil) message:[NSString stringWithFormat:@"错误信息:%@", [error localizedDescription]] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//TODO: delegate 逻辑处理
- (void)firePhaseChanged:(WhiteRoomPhase)phase
{
    
}

/**
 房间中RoomState属性，发生变化时，会触发该回调。
 @param modifyState 发生变化的 RoomState 内容
 */
- (void)fireRoomStateChanged:(WhiteRoomState *)modifyState
{
    
}

/** 白板失去连接回调，附带错误信息 */
- (void)fireDisconnectWithError:(NSString *)error
{
    
}

/** 用户被远程服务器踢出房间，附带踢出原因 */
- (void)fireKickedWithReason:(NSString *)reason
{
    
}

/** 用户错误事件捕获，附带用户 id，以及错误原因 */
- (void)fireCatchErrorWhenAppendFrame:(NSUInteger)userId error:(NSString *)error
{
    
}

/**
 白板自定义事件回调，
 自定义事件参考文档，或者 RoomTests 代码
 */
- (void)fireMagixEvent:(WhiteEvent *)event
{
    
}

/**
 高频自定义事件一次性回调
 */
- (void)fireHighFrequencyEvent:(NSArray<WhiteEvent *>*)events
{
    
}

@end
