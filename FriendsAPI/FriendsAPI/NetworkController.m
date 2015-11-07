//
//  NetworkController.m
//  FriendsAPI
//
//  Created by Ethan Hess on 11/6/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import "NetworkController.h"
#import "AFNetworking.h"

@interface NetworkController()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

static NSString * const baseURL = @"https://private-5bdb3-friendmock.apiary-mock.com";

@implementation NetworkController

+ (AFHTTPSessionManager *)api {
    static AFHTTPSessionManager *api = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        api = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:baseURL]];
        api.responseSerializer = [AFJSONResponseSerializer serializer];
        api.requestSerializer = [AFJSONRequestSerializer serializer];
        [api.responseSerializer setAcceptableContentTypes: [NSSet setWithObject:@"text/html"]];
        [api.responseSerializer setAcceptableContentTypes: [NSSet setWithObject:@"application/json"]];
               
        });
    
    return api;
    
}

@end
