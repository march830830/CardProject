//
//  MainView.m
//  CardProject
//
//  Created by 陳泓諺 on 2015/12/3.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import "MainView.h"

@interface MainView ()

@property (nonatomic, strong) NSMutableArray *buttons;


@end

@implementation MainView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame titleString:@"Latest Promotion"];
    if (self) {
        
//        [self setScrollViewWithArray:imageArray];
        
        self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.1, CGRectGetHeight(self.frame) * 0.8, CGRectGetWidth(self.frame) * 0.8, 1)];
        self.bottomLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bottomLine];
        
        self.buttons = [NSMutableArray array];
//        CGRect frame
        
        
//        CGRect buttonFrame = CGRectMake(CGRectGetWidth(self.frame) * 0.2, CGRectGetHeight(self.frame) * 0.82, CGRectGetWidth(self.frame) * 0.2, CGRectGetWidth(self.frame) * 0.2);
        __block CGPoint buttonPoint = CGPointMake(CGRectGetWidth(self.frame) * 0.15, CGRectGetHeight(self.frame) * 0.82);
        NSArray *images = @[@"calculate",@"news",@"notes",@"aboutUS"];
        [images enumerateObjectsUsingBlock:^(id  _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(buttonPoint.x, buttonPoint.y, CGRectGetWidth(self.frame) * 0.15, CGRectGetWidth(self.frame) * 0.15);
            button.clipsToBounds = YES;
//            button.backgroundColor = [UIColor lightGrayColor];
            button.tag = idx;
            [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [self.buttons addObject:button];
            buttonPoint.x += CGRectGetWidth(self.frame) * 0.2;
        }];
        
//
        
    }
    return self;
}



- (void) buttonAction:(UIButton*)button {
    [self.delegate buttonTrigger:self button:button];
}

@end
