//
//  RecordCell.h
//  CardProject
//
//  Created by 翁瑞祺 on 2016/4/9.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardData.h"
#import "RecordData.h"
#import "RecordFooterView.h"

@interface RecordCell : UITableViewCell

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong, setter=setData:) RecordData *recordData;
@property (nonatomic, strong) RecordFooterView *recordFooterView;
@property (nonatomic, strong) UIView *titleBottomLineView;
@property (nonatomic, strong)UILabel *backLabel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier value:(NSInteger)value data:(NSArray *)dataArray date:(NSInteger)date;

@end
