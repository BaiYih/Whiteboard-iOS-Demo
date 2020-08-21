//
//  NETWhiteRoomViewController.h
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/21.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import "NETWhiteBaseViewController.h"
#import <Whiteboard/Whiteboard.h>

NS_ASSUME_NONNULL_BEGIN

@interface NETWhiteRoomViewController : NETWhiteBaseViewController

@property (nonatomic, strong, nullable) WhiteRoom *room;

@property (nonatomic, weak, nullable) id<WhiteRoomCallbackDelegate> roomCallbackDelegate;

@end

NS_ASSUME_NONNULL_END
