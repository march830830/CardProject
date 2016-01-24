//
//  SelectView.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame titleString:@"My Card"];
    if (self) {
        
        [self setNavBarButton];
        
        self.buttons = [NSMutableArray array];
        NSArray *images = @[@"中國信託",@"玉山銀行",@"彰化銀行",@"元大證券",@"日盛銀行",@"台中銀行",@"花旗銀行",@"凱基銀行",@"新光銀行"];
        
        __block CGPoint beganPoint = CGPointMake(20, CGRectGetHeight(self.frame) * 0.31);
        CGFloat widthAvg = CGRectGetWidth(self.frame) * 0.28;
        [images enumerateObjectsUsingBlock:^(id  _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(beganPoint.x, beganPoint.y, widthAvg, widthAvg)];
            button.backgroundColor = [UIColor magentaColor];
            [self configureCardsBtn:button imageName:name tag:idx+1];
            [self addSubview:button];
            
            
            beganPoint.x += widthAvg + 10;
            if((idx + 1) % 3 == 0) {
                beganPoint.x = 20;
                beganPoint.y += widthAvg + 10;
            }
        }];
        
        self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.3, CGRectGetHeight(self.frame) * 0.845, CGRectGetWidth(self.frame) * 0.4, CGRectGetHeight(self.frame) * 0.08)];
        [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"ComfirmButton"] forState:UIControlStateNormal];
        [self addSubview:self.confirmButton];
    }
    return self;
}

- (void) buttonAction:(UIButton*)button {
    [self.delegate buttonTrigger:self button:button];
}

-(void) configureCardsBtn:(UIButton*)button imageName:(NSString*)name tag:(NSInteger)tag{
    button.tag = tag;
    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-1",name]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",name]] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
}

@end
