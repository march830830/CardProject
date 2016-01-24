//
//  StoreModel.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

+ (StoreModel*) shareInstance;

@property (nonatomic, strong) NSMutableDictionary *storeDic;
@property (nonatomic, strong) NSMutableArray *storeNameArray;;
@property (nonatomic, strong) NSMutableArray *storeIdArray;;

@end
