//
//  ResultView.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "ResultView.h"

@implementation ResultView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame titleString:@"Voucher"];
    if (self) {
        [self setNavBarButton];
        
        __block CGPoint buttonPoint = CGPointMake(CGRectGetWidth(self.frame) * 0.14, CGRectGetHeight(self.frame) * 0.32);
        NSArray *images = @[@"card",@"level"];
        [images enumerateObjectsUsingBlock:^(id  _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *classImageView = [[UIImageView alloc] initWithFrame:CGRectMake(buttonPoint.x, buttonPoint.y, CGRectGetWidth(self.frame) * 0.11, CGRectGetWidth(self.frame) * 0.11)];
            classImageView.image = [UIImage imageNamed:name];
            buttonPoint.x += CGRectGetWidth(self.frame) * 0.6;
            [self addSubview:classImageView];
        }];
        
        
        self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.1, CGRectGetHeight(self.frame) * 0.85, CGRectGetWidth(self.frame) * 0.8, 1)];
        self.bottomLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bottomLine];
        
        self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.1, CGRectGetHeight(self.frame) * 0.86, CGRectGetWidth(self.frame) * 0.12, CGRectGetWidth(self.frame) * 0.12)];
        [self.saveButton setBackgroundImage:[UIImage imageNamed:@"saveButton"] forState:UIControlStateNormal];
        [self addSubview:self.saveButton];
        
        self.continueButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.75, CGRectGetHeight(self.frame) * 0.86, CGRectGetWidth(self.frame) * 0.12, CGRectGetWidth(self.frame) * 0.12)];
        [self.continueButton setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [self addSubview:self.continueButton];
        
        self.pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.12, CGRectGetHeight(self.frame) * 0.8, CGRectGetWidth(self.frame) * 0.7, CGRectGetHeight(self.frame) * 0.04)];
        self.pointLabel.text = @"禮券總額 : 5500";
        self.pointLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.pointLabel];
        
    }
    return self;
}

@end
