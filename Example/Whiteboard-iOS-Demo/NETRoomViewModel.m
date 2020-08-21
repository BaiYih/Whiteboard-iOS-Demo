//
//  NETRoomViewModel.m
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/21.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import "NETRoomViewModel.h"

#import "NETWhiteUtils.h"

@interface NETRoomViewModel ()

@end

@implementation NETRoomViewModel

static NSString *APIHost = @"https://shunt-api.netless.link/v5/";

+ (NSString *)appIdentifier
{
    return [NETWhiteUtils appIdentifier];
}

+ (NSString *)sdkToken
{
    return [NETWhiteUtils sdkToken];
}

+ (void)createRoomWithCompletionHandler:(void (^) (NSString * _Nullable uuid, NSString * _Nullable roomToken, NSError * _Nullable error))completionHandler
{
    if (!completionHandler) {
        return;
    }
    
    [self createRoomWithResult:^(BOOL success, id  _Nullable response, NSError * _Nullable error) {
        if (success) {
            NSString *uuid = response[@"uuid"];
            [self createRoomTokenWithUuid:uuid accessKey:nil lifespan:0 role:@"admin" Result:^(BOOL success, NSString *response, NSError *error) {
                if (success) {
                    !completionHandler ? : completionHandler(uuid, response, nil);
                } else {
                    !completionHandler ? : completionHandler(nil, nil, error);
                }
            }];
        } else {
            !completionHandler ? : completionHandler(nil, nil, error);
        }
    }];
}

+ (void)getRoomTokenWithUuid:(NSString *)uuid accessKey:(NSString *)accessKey lifespan:(NSUInteger)lifespan role:(NSString *)role completionHandler:(void (^)(NSString * _Nullable roomToken, NSError * _Nullable error))completionHandler
{

    [self createRoomTokenWithUuid:uuid accessKey:accessKey lifespan:lifespan role:role Result:^(BOOL success, NSString *response, NSError *error) {
        !completionHandler ? : completionHandler(response, nil);
    }];
}

#pragma mark - Private

//FIXME:我们推荐将这两个请求，放在您的服务器端进行。防止您从 https://console.netless.link 获取的 token 发生泄露。
+ (void)createRoomWithResult:(void (^) (BOOL success, id  _Nullable response, NSError * _Nullable error))result;
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[APIHost stringByAppendingString:@"rooms"]]];
    
    NSMutableURLRequest *modifyRequest = [request mutableCopy];
    [modifyRequest setHTTPMethod:@"POST"];
    
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //在 header 中加入身份鉴权
    [modifyRequest addValue:self.sdkToken forHTTPHeaderField:@"token"];
    
    //@"isRecord": @YES 是否开启录制，YES 为可回放房间，默认为持久化房间。
    NSDictionary *params = @{@"name": @"whiteboard-example-ios", @"limit": @110, @"isRecord": @YES};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    
    [modifyRequest setHTTPBody:postData];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:modifyRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!result) {
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 201) {
                NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                result(YES, responseObject, nil);
            } else if (error) {
                result(NO, nil, error);
            } else if (data) {
                NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:401 userInfo:responseObject];
                result(NO, nil, error);
            }
        });
    }];
    [task resume];
}

/**
 向服务器获取对应 room uuid 所需要的房间 roomToken
 
 @param uuid 房间 uuid
 @param result 服务器返回信息
 */
+ (void)createRoomTokenWithUuid:(NSString *)uuid accessKey:(NSString *)accessKey lifespan:(NSUInteger)lifespan role:(NSString *)role Result:(void (^) (BOOL success, NSString *response, NSError *error))result
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:[APIHost stringByAppendingString:@"tokens/rooms/%@"], uuid]]];
        
    NSMutableURLRequest *modifyRequest = [request mutableCopy];
    
    [modifyRequest setHTTPMethod:@"POST"];
    
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [modifyRequest addValue:self.sdkToken forHTTPHeaderField:@"token"];
    
    NSMutableDictionary *params = @{@"lifespan": @(lifespan), @"role": role}.mutableCopy;
    if (accessKey) {
        [params setValue:accessKey forKey:@"ak"];
    }
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];

    [modifyRequest setHTTPBody:postData];

    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:modifyRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!result) {
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 201) {
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                if ([responseObject isKindOfClass:[NSString class]]) {
                    result(YES, responseObject, nil);
                } else {
                    NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey:@"Error return value type", NSLocalizedDescriptionKey:responseObject};
                    NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:401 userInfo:userInfo];
                    result(NO, nil, error);
                }
            } else if (error) {
                result(NO, nil, error);
            } else if (data) {
                NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:401 userInfo:responseObject];
                result(NO, nil, error);
            }
        });
    }];
    [task resume];

}

@end
