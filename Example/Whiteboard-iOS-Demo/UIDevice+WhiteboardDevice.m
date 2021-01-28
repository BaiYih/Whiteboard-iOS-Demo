//
//  UIDevice+WhiteboardDevice.m
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/23.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import "UIDevice+WhiteboardDevice.h"

@implementation UIDevice (WhiteboardDevice)

+ (void)setupOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSNumber *orientationTarget = @(interfaceOrientation);
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

@end
