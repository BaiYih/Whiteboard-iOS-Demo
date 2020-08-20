//
//  NETCreatRoomViewController.h
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/20.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NETCreatRoomViewType) {
    /** 加入房间 */
    NETCreatRoomViewTypeJoin,
    /** 创建房间 */
    NETCreatRoomViewTypeCreate
};

@interface NETCreatRoomViewController : UIViewController

- (instancetype)initWithType:(NETCreatRoomViewType)type;

@end

NS_ASSUME_NONNULL_END
