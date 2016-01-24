//
//  CalculateView.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/21.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "CalculateView.h"

@interface CalculateView ()

@end

@implementation CalculateView


- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame titleString:@"voucher"];
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
        
        
        self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.8, CGRectGetHeight(self.frame) * 0.77, CGRectGetWidth(self.frame) * 0.11, CGRectGetWidth(self.frame) * 0.11)];
        [self.addButton setBackgroundImage:[UIImage imageNamed:@"addButton"] forState:UIControlStateNormal];
        [self addSubview:self.addButton];
        
        self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.1, CGRectGetHeight(self.frame) * 0.85, CGRectGetWidth(self.frame) * 0.8, 1)];
        self.bottomLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bottomLine];
        
        self.totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.1, CGRectGetHeight(self.frame) * 0.87, CGRectGetWidth(self.frame) * 0.2, CGRectGetHeight(self.frame) * 0.07)];
        self.totalLabel.backgroundColor = [UIColor magentaColor];
        self.totalLabel.text = @"Total";
        self.totalLabel.textColor = [UIColor whiteColor];
        self.totalLabel.textAlignment = NSTextAlignmentCenter;
        self.totalLabel.font = [UIFont boldSystemFontOfSize:21];
        [self addSubview:self.totalLabel];
        
        self.totalField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.35, CGRectGetHeight(self.frame) * 0.87, CGRectGetWidth(self.frame) * 0.3, CGRectGetHeight(self.frame) * 0.07)];
        self.totalField.backgroundColor = [UIColor clearColor];
        self.totalField.textAlignment = NSTextAlignmentCenter;
        self.totalField.layer.borderWidth = 1;
        self.totalField.layer.borderColor = [UIColor whiteColor].CGColor;
        self.totalField.layer.cornerRadius = 15;
        self.totalField.textColor = [UIColor whiteColor];
        self.totalField.placeholder = @"$$$$";
        self.totalField.inputAccessoryView = [[UIView alloc] init];
        self.totalField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.totalField];
        
        self.calButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.75, CGRectGetHeight(self.frame) * 0.87, CGRectGetWidth(self.frame) * 0.11, CGRectGetWidth(self.frame) * 0.11)];
        [self.calButton setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [self addSubview:self.calButton];
        
    }
    return self;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.totalField resignFirstResponder];
}

@end
