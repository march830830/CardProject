//
//  NetworkManager.m
//  GetAPITest
//
//  Created by Xuan on 2016/1/20.
//  Copyright © 2016年 Xuan. All rights reserved.
//

#import "NetworkManager.h"

static NSTimeInterval const RESTRequestTimeout = 6 ;
static NSTimeInterval const RESTRequestDelayTime = 1 * NSEC_PER_SEC;
static NSString * const RESTAlertGetTitle = @"HTTP GET Status";
static NSString * const RESTAlertPutTitle = @"HTTP PUT Status";
static NSString * const RESTAlertPostTitle = @"HTTP POST Status";
static NSString * const RESTAlertDeleteTitle = @"HTTP DELETE Status";

@interface NetworkManager ()

@property (strong,nonatomic) NSArray *urlArray;

@end

@implementation NetworkManager

+ (NetworkManager *)initInstaceWithServerDomain:(NSString *)serverDomain {
    static NetworkManager *networkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[NetworkManager alloc] initWithBaseURL:[NSURL URLWithString:serverDomain]];
        networkManager.restapiBaseURL = serverDomain;
//        networkManager.requestSerializer.timeoutInterval = HTTPRequestTimeout;
        networkManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        networkManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return networkManager;
}


- (void)requestURL:(NSString *)url method:(RequestType)method parameters:(id)parameters success:(APIResponse)response{
    
    NSAssert(self.restapiBaseURL != nil, @"You must set base url");
    
    [self.requestSerializer setTimeoutInterval:RESTRequestTimeout];
    NSString *apiURL = [self.restapiBaseURL stringByAppendingPathComponent:url];
    
    typeof(self) __weak weakSelf = self;
    [SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"Loading ..." maskType:SVProgressHUDMaskTypeBlack];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)RESTRequestDelayTime), dispatch_get_main_queue(), ^{
        switch (method) {
            case RequestGetType: {
                // GET Method
                [weakSelf GET:apiURL parameters:parameters success:^(NSURLSessionDataTask *task, id object) {
                    if (response) {
                        [SVProgressHUD dismiss];
                        response(object);//object就是api取到的資料
                    }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [weakSelf showAlertWithTitle:RESTAlertGetTitle message:error.localizedDescription];
                }];
            } break;
            case RequestPostType: {
                // POST Method
                [weakSelf POST:apiURL parameters:parameters success:^(NSURLSessionDataTask *task, id object) {
                    if (response) {
                        [SVProgressHUD dismiss];
                        response(object);
                    }
//                    else if ([apiURL isEqualToString:loginUrl]) {
//                        [SVProgressHUD dismiss];
//                        response(object);
//                    }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"%@",error);
                    [weakSelf showAlertWithTitle:RESTAlertPostTitle message:error.localizedDescription];
                }];
            } break;
            case RequestPutType: {
                // PUT Method
                [weakSelf PUT:apiURL parameters:parameters success:^(NSURLSessionDataTask *task, id object) {
                    if(response) {
                        [SVProgressHUD dismiss];
                        response(object);
                    }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [weakSelf showAlertWithTitle:RESTAlertPutTitle message:error.localizedDescription];
                }];
            } break;
            case RequestDeleteType: {
                // DELETE Method
                [weakSelf DELETE:apiURL parameters:parameters success:^(NSURLSessionDataTask *task, id object) {
                    if(response) {
                        [SVProgressHUD dismiss];
                        response(object);
                    }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [weakSelf showAlertWithTitle:RESTAlertDeleteTitle message:error.localizedDescription];
                }];
            } break;
        }
    });
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    [SVProgressHUD dismiss];
    UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    [messageAlert show];
}

@end
