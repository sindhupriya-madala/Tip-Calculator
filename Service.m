//
//  Service.m
//  TipCalculator
//
//  Created by PriyaManoj on 2016-09-16.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import "Service.h"

@interface Service()

@property (strong, nonatomic) AFHTTPSessionManager *requestManager;
@property (strong, nonatomic) AFHTTPSessionManager *programFileManager;

@end

@implementation Service

- (id)init {
    if (self = [super init]) {
        NSString *serverBaseURL = @"http://192.168.1.69:8080/";
        NSAssert(serverBaseURL, @"server url has not been set in plist");
        _requestManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:serverBaseURL]];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        // Request serializer
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [_requestManager setRequestSerializer:requestSerializer];
        [_requestManager.requestSerializer setTimeoutInterval:10];
        // Response serializer
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        [responseSerializer setReadingOptions:NSJSONReadingAllowFragments];
        [_requestManager setResponseSerializer:responseSerializer];
        
    }
    return self;
}


- (PMKPromise *)login:(UserModel *)user
{
    NSDictionary *params = @{@"username": user.userName,
                             @"password": user.password};
    
    return [PMKPromise promiseWithResolver:^(PMKResolver _Nonnull resolve){
        [self.requestManager POST:@"login" parameters:params progress:nil success:^
         (NSURLSessionDataTask *task, id responseObject){
            resolve(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error){
            resolve(error);
        }];
    }];
}

@end
