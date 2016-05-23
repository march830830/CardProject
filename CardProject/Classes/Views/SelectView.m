//
//  SelectView.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "SelectView.h"

@interface SelectView ()



@end

@implementation SelectView

- (instancetype) initWithFrame:(CGRect)frame CardDic:(NSMutableDictionary*)cardDic {
    self = [super initWithFrame:frame titleString:@"My Card"];
    if (self) {
        [self setNavBarButton];
        
        self.buttons = [NSMutableArray array];

        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * 0.9)];
        [self addSubview:self.scrollView];
        
        __block CGPoint beganPoint = CGPointMake(20, CGRectGetHeight(self.frame) * 0.31);
        CGFloat widthAvg = CGRectGetWidth(self.frame) * 0.28;
        for (int i = 0; i < [cardDic[@"name"] count]; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(beganPoint.x, beganPoint.y, widthAvg, widthAvg)];
            button.backgroundColor = [UIColor clearColor];
            [self configureCardsBtn:button imageName:cardDic[@"image"][i]];
            [self.scrollView addSubview:button];
            button.tag = i + 1 ;
            
            beganPoint.x += widthAvg + 10;
            if((i + 1) % 3 == 0) {
                beganPoint.x = 20;
                beganPoint.y += widthAvg + 10;
            }

        }
        
        self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.3, CGRectGetMaxY(self.scrollView.frame) + 10, CGRectGetWidth(self.frame) * 0.4, CGRectGetHeight(self.frame) * 0.08)];
        [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"ComfirmButton"] forState:UIControlStateNormal];
        [self addSubview:self.confirmButton];
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), beganPoint.y + 10);

        
    }
    return self;
}

- (void)setFilterImage:(UIImage *)filterImage{
    if (filterImage == nil) return;
    
    _filterImage = filterImage;
    //将图片添加到filterImageView上
    self.filterImageView.image = filterImage;
}


- (void) buttonAction:(UIButton*)button {
    [self.delegate buttonTrigger:self button:button];
}

-(void) configureCardsBtn:(UIButton*)button imageName:(NSData*)name {
    [button setBackgroundImage:[UIImage imageWithData:name] forState:UIControlStateNormal];
    [button setTitle:@"✔︎" forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:50];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
}

@end
