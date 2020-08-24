//
//  NETWhiteUtils.m
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/21.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import "NETWhiteUtils.h"

#define WhiteSDKToken @""//<#WhiteSDKToken#>

#define WhiteAppIdentifier @""//<#WhiteAppIdentifier#>

#define  WhiteRoomUUID @""//<#WhiteRoomUUID#>

@implementation NETWhiteUtils

+ (NSString *)appIdentifier
{
    return WhiteAppIdentifier;
}

+ (NSString *)sdkToken
{
    return WhiteSDKToken;
}

+ (NSString *)roomUuid
{
    return WhiteRoomUUID;
}

@end
