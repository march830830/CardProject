//
//  NetworkManager.h
//  GetAPITest
//
//  Created by Xuan on 2016/1/20.
//  Copyright © 2016年 Xuan. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

typedef NS_ENUM(NSUInteger, RequestType) {
    RequestGetType = 0,
    RequestPostType,
    RequestPutType,
    RequestDeleteType,
};

typedef void(^APIResponse)(id responseObject);

@interface NetworkManager : AFHTTPSessionManager

+ (NetworkManager *)initInstaceWithServerDomain:(NSString *)serverDomain;

- (void)requestURL:(NSString *)url method:(RequestType)method parameters:(id)parameters success:(APIResponse)response;

@property(nonatomic, copy) NSString *restapiBaseURL;

@end
