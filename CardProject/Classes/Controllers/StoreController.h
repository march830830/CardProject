//
//  StoreController.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/21.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@class StoreView;

@interface StoreController : BaseController

@property (nonatomic, strong) StoreView *storeView;
@property (nonatomic, strong) NSMutableArray *testArray;

@end
