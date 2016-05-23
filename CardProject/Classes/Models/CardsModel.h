//
//  CardsModel.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/24.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardsModel : NSObject

+ (CardsModel*) shareInstance;
@property (nonatomic, strong) NSMutableArray *cardsArray;
@property (nonatomic, strong) NSMutableArray *tempImageArray;
@property (nonatomic, strong) NSMutableArray *tempNameArray;
@property (nonatomic, strong) NSDictionary *cardsDic;

@end
