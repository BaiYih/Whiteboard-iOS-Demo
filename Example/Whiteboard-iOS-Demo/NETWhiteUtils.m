//
//  NETWhiteUtils.m
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/21.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import "NETWhiteUtils.h"

#define WhiteSDKToken @"NETLESSSDK_YWs9ZVpsc0xzVHBwdmkwd0tFZyZub25jZT0xNTk2NDQyMDE1MTU2MDAmcm9sZT0wJnNpZz0yZTA2MmFjYWQ4NmE2MzYwZGUyNTkwM2I4YjNhYmQ5ODY5Njg4YjYzNDEyZWU4OWU4MmQ4YTIwZGI3YmRhMDU5"

#define WhiteAppIdentifier @"DXWdkNVgEeqjsy_YJQWJfA/09XMgUzMWU76IA"

#define  WhiteRoomUUID @"913e8fa0e06011ea907ea3e91a336099"

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
