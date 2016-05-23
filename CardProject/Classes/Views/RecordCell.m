//
//  RecordCell.m
//  CardProject
//
//  Created by 翁瑞祺 on 2016/4/9.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "RecordCell.h"
#import "CardCell.h"
#import "CardsModel.h"
#import "RecordHeaderView.h"

@interface RecordCell ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) CGFloat boundsHeight;
@property(nonatomic, strong)NSArray *array;
@property(nonatomic, strong)NSDictionary *dic;
@property(nonatomic)NSInteger value;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation RecordCell



- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.boundsHeight = ( CGRectGetHeight([[UIScreen mainScreen] bounds]));
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.boundsHeight * 0.07)-1)];
        self.label.font = [UIFont systemFontOfSize:self.boundsHeight*0.04];
        self.label.textColor = [UIColor whiteColor];
        self.label.backgroundColor = [UIColor clearColor];
        [self addSubview:self.label];
        
        self.backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.boundsHeight * 0.07)-1)];
        self.backLabel.text = @"＜";
        self.backLabel.font = [UIFont systemFontOfSize:self.boundsHeight*0.04];
        self.backLabel.textColor = [UIColor whiteColor];
        self.backLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backLabel];
        
        self.titleBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1.0)];
        self.titleBottomLineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleBottomLineView];
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.boundsHeight * 0.07 - 1.0, self.frame.size.width, 1.0)];
        self.lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lineView];
        
        RecordHeaderView *headerView = [[RecordHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.boundsHeight * 0.07)];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  self.boundsHeight * 0.08, CGRectGetWidth(self.frame), self.boundsHeight*0.45)];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.tableHeaderView = headerView;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        self.tableView.hidden = YES;

        [self addSubview:self.tableView];
        
        self.recordFooterView = [[RecordFooterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.frame.size.width, self.boundsHeight * 0.07)];
        self.recordFooterView.hidden = YES;
        [self addSubview:self.recordFooterView];
    }
    return self;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cellIdentifier";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier type:1];
    }
    
    CardData *tempCardData = [[CardData alloc] init];
    tempCardData.cardId = [self getDic:@"carId" :self.array[indexPath.row]];
    tempCardData.cost = [self getDic:@"cost" :self.array[indexPath.row]];
    
    cell.cardData = tempCardData;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  CGRectGetHeight([[UIScreen mainScreen] bounds]) * 0.1;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSString*) getDic:(NSString *)key :(NSDictionary *)dic{
    return dic[key];
}
- (void) setData:(RecordData *)data {
    _recordData = data;
    [self refreshCell];
}

- (void) refreshCell {
    NSLog(@"%@----",self.recordData.data);
    self.label.text = self.recordData.date;
    self.recordFooterView.pointLabel.text = [NSString stringWithFormat:@"禮券總額 : %@",self.recordData.value];
    NSError *err = nil;
    self.array = [NSJSONSerialization JSONObjectWithData:[self.recordData.data
                                                dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    self.dic = [self.array objectAtIndex:0];
    NSLog(@"%@",self.dic);
    //NSString *test = [dictionary objectForKey:@"ID"];
    NSLog(@"Test is %@",[self.recordData.data
                         dataUsingEncoding:NSUTF8StringEncoding]);
    NSLog(@"Test is %lu",(unsigned long)self.array.count);
}

@end
