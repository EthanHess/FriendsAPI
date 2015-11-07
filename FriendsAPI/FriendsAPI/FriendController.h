//
//  FriendController.h
//  FriendsAPI
//
//  Created by Ethan Hess on 11/6/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendController : NSObject

@property (nonatomic, strong) NSArray *resultFriends;
@property (nonatomic, strong) NSDictionary *friendDictionary;

+ (FriendController *)sharedInstance;

- (void)getFriendsWithCompletion:(void (^)(NSArray *))completion;

- (void)getFriendDetailWithCompletion:(void (^)(NSDictionary *))completion;

@end
