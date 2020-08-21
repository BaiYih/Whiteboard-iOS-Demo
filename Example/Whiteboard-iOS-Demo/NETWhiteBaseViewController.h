//
//  NETWhiteBaseViewController.h
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/21.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Whiteboard/Whiteboard.h>

NS_ASSUME_NONNULL_BEGIN

@interface NETWhiteBaseViewController : UIViewController

@property (nonatomic, copy, nullable) NSString *roomUuid;
@property (nonatomic, strong) WhiteBoardView *boardView;
@property (nonatomic, strong) WhiteSDK *sdk;

@property (nonatomic, strong, nonnull) WhiteSdkConfiguration *sdkConfig;

@property (nonatomic, weak, nullable) id<WhiteCommonCallbackDelegate> commonDelegate;

@property (nonatomic, strong, nullable) WhiteRoomConfig *roomConfig;

@end

NS_ASSUME_NONNULL_END
