//
//  StoreView.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/21.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "StoreView.h"

@implementation StoreView

- (instancetype) initWithFrame:(CGRect)frame ImageArray:(NSMutableArray*) imageArray {
    self = [super initWithFrame:frame titleString:@"Choose"];
    if (self) {
        [self setNavBarButton];
        [self setScrollViewWithArray:imageArray];
        
        self.storeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.2, CGRectGetHeight(self.frame) * 0.775, CGRectGetWidth(self.frame) * 0.6, CGRectGetHeight(self.frame) * 0.045)];
        self.storeLabel.backgroundColor = [UIColor magentaColor];
        self.storeLabel.font = [UIFont boldSystemFontOfSize:21];
        self.storeLabel.textAlignment = NSTextAlignmentCenter;
        self.storeLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.storeLabel];
        
        self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.3, CGRectGetHeight(self.frame) * 0.845, CGRectGetWidth(self.frame) * 0.4, CGRectGetHeight(self.frame) * 0.08)];
        [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"ComfirmButton"] forState:UIControlStateNormal];
        [self addSubview:self.confirmButton];
        
    }
    return self;
}

@end
