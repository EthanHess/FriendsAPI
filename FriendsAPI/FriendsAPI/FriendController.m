//
//  FriendController.m
//  FriendsAPI
//
//  Created by Ethan Hess on 11/6/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import "FriendController.h"
#import "NetworkController.h"
#import "AFNetworking.h"

@implementation FriendController

+ (FriendController *)sharedInstance {
    static FriendController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FriendController new];
    });
    
    return sharedInstance;
    
}

- (void)getFriendsWithCompletion:(void (^)(NSArray *))completion {
    
    NSString *path = @"friends";
    
    [[NetworkController api] GET:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        self.resultFriends = responseObject;
        completion(self.resultFriends);
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        completion(nil);
        
    }];
    
}

- (void)getFriendDetailWithCompletion:(void (^)(NSDictionary *))completion {
    
    NSString *path = @"friends/id";
    
    [[NetworkController api] GET:path parameters:nil
                         success:^(NSURLSessionDataTask *task, id responseObject) {
                            
        NSDictionary *dictionary = responseObject;
        completion(dictionary);
                             
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@", error);
        completion(nil);
    
    }];
    
}

@end
