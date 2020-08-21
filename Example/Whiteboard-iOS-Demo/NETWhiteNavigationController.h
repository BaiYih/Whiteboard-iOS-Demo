//
//  NETWhiteNavigationController.h
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/21.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NETWhiteNavigationController : UINavigationController

@property (nonatomic)UIInterfaceOrientation interfaceOrientation;
@property (nonatomic)UIInterfaceOrientationMask interfaceOrientationMask;

- (void)setupOrientationLandscape:(BOOL)landscape;

@end

NS_ASSUME_NONNULL_END
