//
//  CardCell.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat boundsHeight = ( CGRectGetHeight([[UIScreen mainScreen] bounds]) * 0.25 ) / 3;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.cardImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, boundsHeight, boundsHeight)];
//        self.cardImage.image = [UIImage imageNamed:@"玉山"];
        [self addSubview:self.cardImage];
        
        self.cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.2, 10, CGRectGetWidth(self.frame) * 0.4, CGRectGetHeight(self.frame))];
        self.cardLabel.textAlignment = NSTextAlignmentCenter;
//        self.cardLabel.backgroundColor = [UIColor greenColor];
        self.cardLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.cardLabel];
        
        if (type == 0) {
            self.cutButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) * 0.6, CGRectGetMidY(self.frame), CGRectGetWidth(self.frame) * 0.04, CGRectGetWidth(self.frame) * 0.07)];
            [self.cutButton setBackgroundImage:[UIImage imageNamed:@"button_arrow_prev"] forState:UIControlStateNormal];
            self.cutButton.tag = 0;
            [self.cutButton addTarget:self action:@selector(cardAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.cutButton];
            
            self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cutButton.frame) + 10, CGRectGetMidY(self.frame), CGRectGetWidth(self.frame) * 0.06, CGRectGetWidth(self.frame) * 0.06)];
            self.valueLabel.text = @"1";
            self.valueLabel.textColor = [UIColor whiteColor];
            [self addSubview:self.valueLabel];
            
            self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.valueLabel.frame), CGRectGetMidY(self.frame), CGRectGetWidth(self.frame) * 0.04, CGRectGetWidth(self.frame) * 0.07)];
            [self.addButton setBackgroundImage:[UIImage imageNamed:@"button_arrow_next"] forState:UIControlStateNormal];
            self.addButton.tag = 1;
            [self.addButton addTarget:self action:@selector(cardAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.addButton];
        } else {
            self.costLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) * 0.6, 10, CGRectGetWidth(self.frame) * 0.35, CGRectGetHeight(self.frame))];
            self.costLabel.textAlignment = NSTextAlignmentCenter;
            self.costLabel.textColor = [UIColor whiteColor];
            [self addSubview:self.costLabel];
        }
        
        
    }
    return self;
}

- (void) cardAction:(UIButton *) button {
    NSInteger cardValue = [self.valueLabel.text integerValue];
    if (button.tag == 0) {
        if (cardValue > 1) {
            cardValue --;
        }
    } else {
        cardValue ++;
    }
    self.valueLabel.text = [NSString stringWithFormat:@"%ld",(long)cardValue];
    
    if ([self.delegate respondsToSelector:@selector(card:didSelectAtTag:value:)]) {
        [self.delegate card:self didSelectAtTag:self.tag value:[self.valueLabel.text integerValue]];
    }
    
//    NSLog(@"%d , %@:%@",self.tag ,self.cardLabel.text,self.valueLabel.text);
}

- (void) setData:(CardData *)data {
    _cardData = data;
    self.costLabel.text = [NSString stringWithFormat:@"%@", data.cost];
    
    [self refreshCell];
}
- (void) refreshCell {
    //    NSLog(@"%@,%@,%@", self.recordData.data, self.recordData.date, self.recordData.value);
    NSLog(@"%@",self.cardData.cost);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
