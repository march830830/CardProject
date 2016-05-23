//
//  DatabaseModel.m
//  CardProject
//
//  Created by 翁瑞祺 on 2016/4/9.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "DatabaseModel.h"
#import "RecordData.h"

@interface DatabaseModel ()


@end
@implementation DatabaseModel

-(void)create{
    [self openDataBase];
    if (![self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS RECORD (Operation_id int, Value int, Data text, Date text)"]) {
        NSLog(@"could not create table:%@",[self.db lastErrorMessage]);
    }
    [self.db close];
}

-(void)insert:(NSString *)data :(NSString *)value :(NSString *)operation{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *dataString = [NSString stringWithFormat:@"%@", data];
    [self openDataBase];
    [self.db executeUpdate:@"INSERT INTO RECORD (Operation_id, Value, Data, Date) VALUES (?,?,?,?)",operation, value, dataString, dateString];
    [self.db close];
}


-(NSInteger)countNum{
    [self openDataBase];
    NSInteger result = [self.db intForQuery:@"SELECT COUNT(*) FROM RECORD"];
    NSLog(@"%lD", (long)result);
    return result;
}

-(NSString*)readDataBase:(NSString*)string{
    [self openDataBase];
    NSString *SQLexecute = [NSString stringWithFormat:@"SELECT %@ FROM RECORD",string];
    NSString *result = [self.db stringForQuery:SQLexecute];
        NSLog(@"%@",result);
    [self.db close];
    return result;
}

- (NSArray*) readAllData {
    [self openDataBase];

    NSMutableArray *testArray = [NSMutableArray array];
    FMResultSet *rs = [self.db executeQuery:@"SELECT Value, Data, Date FROM RECORD"];
    
    while ([rs next]) {
        RecordData *tempRecordData = [[RecordData alloc] init];
        tempRecordData.value = [NSString stringWithFormat:@"%d", [rs intForColumn:@"Value"]];
        tempRecordData.data = [rs stringForColumn:@"Data"];
        tempRecordData.date = [rs stringForColumn:@"Date"];
        
        NSLog(@"%@", tempRecordData);
        [testArray addObject:tempRecordData];
    }
    
    [self.db close];

    return testArray;
}

-(void)openDataBase {
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [document stringByAppendingPathComponent:@"MYDataBase.db"];
    self.db = [FMDatabase databaseWithPath:dbPath];
    [self.db open];
    NSLog(@"%@",dbPath);
}
@end
