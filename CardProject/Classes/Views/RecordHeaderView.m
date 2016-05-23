//
//  RecordHeaderView.m
//  CardProject
//
//  Created by 翁瑞祺 on 2016/4/10.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "RecordHeaderView.h"

@implementation RecordHeaderView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
                
        __block CGPoint buttonPoint = CGPointMake(0, 0);
        
        NSArray *images = @[@"card",@"level"];
        
        [images enumerateObjectsUsingBlock:^(id  _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *classImageView = [[UIImageView alloc] initWithFrame:CGRectMake(buttonPoint.x, buttonPoint.y, CGRectGetWidth(self.frame) * 0.15, CGRectGetWidth(self.frame) * 0.15)];
            classImageView.image = [UIImage imageNamed:name];
            buttonPoint.x += CGRectGetWidth(self.frame) * 0.75;
            [self addSubview:classImageView];
        }];
        

    }
    return self;
}

@end
