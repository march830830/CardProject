//
//  CalculateController.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/21.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
@class CalculateView;

@interface CalculateController : BaseController

@property (nonatomic, strong) CalculateView *calculateView;
@property (nonatomic) NSInteger storeId;


@end
