//
//  ResultController.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "InsertData.h"
@class  ResultView;
@class  DatabaseModel;
@interface ResultController : BaseController

@property (nonatomic, strong) ResultView *resultView;
@property (nonatomic, strong) NSMutableDictionary *resultDic;
@property(nonatomic, strong, setter=setDBData:)InsertData *insertData;
@property (nonatomic, strong) NSString *pointString;

@end
