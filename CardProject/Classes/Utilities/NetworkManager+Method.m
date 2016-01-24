//
//  NetworkManager+Method.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "NetworkManager+Method.h"
#import "NetworkManager.h"

NSString *domainString = @"http://172.17.140.75:3000/";

@implementation NetworkManager (Method)

+ (void) getStoreInfoWithResponse:(id) sussces:(APIResponse)response {
    [[NetworkManager initInstaceWithServerDomain:domainString] requestURL:@"api/store" method:RequestGetType parameters:nil success:^(id responseObject) {
            response(responseObject);
    }];
}

@end
