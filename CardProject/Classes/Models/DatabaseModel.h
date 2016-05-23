//
//  DatabaseModel.h
//  CardProject
//
//  Created by 翁瑞祺 on 2016/4/9.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"


@interface DatabaseModel : NSObject

@property(nonatomic, strong) FMDatabase *db;



-(void)create;
-(void)insert:(NSString *)data :(NSString *)value :(NSString *)operation;
-(NSString*)readDataBase:(NSString*)string;
-(NSInteger)countNum;
-(NSArray*) readAllData;


@end
