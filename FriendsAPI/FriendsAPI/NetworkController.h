//
//  NetworkController.h
//  FriendsAPI
//
//  Created by Ethan Hess on 11/6/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

@interface NetworkController : NSObject

+ (AFHTTPSessionManager *)api;

@end
