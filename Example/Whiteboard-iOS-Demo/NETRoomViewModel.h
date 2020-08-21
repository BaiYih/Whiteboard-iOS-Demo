//
//  NETRoomViewModel.h
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/21.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NETRoomViewModel : NSObject

+ (void)createRoomWithCompletionHandler:(void (^) (NSString * _Nullable uuid, NSString * _Nullable roomToken, NSError * _Nullable error))completionHandler;

+ (void)getRoomTokenWithUuid:(NSString *)uuid accessKey:(NSString * _Nullable)accessKey lifespan:(NSUInteger)lifespan role:(NSString *)role completionHandler:(void (^)(NSString * _Nullable roomToken, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
