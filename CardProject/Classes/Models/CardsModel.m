//
//  CardsModel.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/24.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "CardsModel.h"

@implementation CardsModel

+ (CardsModel*) shareInstance {
    static CardsModel *cardsModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cardsModel = [[CardsModel alloc] init];
    });
    return cardsModel;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.cardsArray = [NSMutableArray array];
        self.tempImageArray = [NSMutableArray array];        
        self.tempNameArray = [NSMutableArray array];

    }
    return self;
}

@end
