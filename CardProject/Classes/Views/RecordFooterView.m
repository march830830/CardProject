//
//  RecordFooterView.m
//  CardProject
//
//  Created by 翁瑞祺 on 2016/5/22.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "RecordFooterView.h"

@implementation RecordFooterView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        self.pointLabel.text = @"禮券總額 : 5500";
        self.pointLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.pointLabel];
        
    }
    return self;
}

@end
