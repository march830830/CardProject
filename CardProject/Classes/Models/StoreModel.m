//
//  StoreModel.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel

+ (StoreModel*) shareInstance {
    static StoreModel *storeModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storeModel = [[StoreModel alloc] init];
    });
    return storeModel;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.storeDic = [NSMutableDictionary dictionary];
        self.storeNameArray = [NSMutableArray array];
        self.storeIdArray = [NSMutableArray array];

    }
    return self;
}

@end
