//
//  BaseView.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/20.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "BaseView.h"
#import "UIImage+Extends.h"
#import "UIColor+Decoder.h"

@implementation BaseView

- (instancetype) initWithFrame:(CGRect)frame titleString:(NSString*) titleString {
    self = [super initWithFrame:frame];
    if (self) {
//        self.bg = [[UIImageView alloc] initWithFrame:self.frame];
//        self.bg.image = [UIImage imageNamed:@"bg"];
//        [self addSubview:self.bg];

        self.backgroundColor = [UIColor colorWithRedValue:45.0 greenValue:52.0 blueValue:72.0];
        
        self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.3, CGRectGetHeight(self.frame) * 0.045, CGRectGetWidth(self.frame) * 0.4, CGRectGetHeight(self.frame) * 0.055)];
        self.logoImage.image = [UIImage imageNamed:@"titleImage"];
        [self addSubview:self.logoImage];
        
        self.sloganImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.3, CGRectGetHeight(self.frame) * 0.11, CGRectGetWidth(self.frame) * 0.4, CGRectGetHeight(self.frame) * 0.03)];
        self.sloganImage.image = [UIImage imageNamed:@"Enjoy your Life"];
        [self addSubview:self.sloganImage];
        
        self.heartImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.47, CGRectGetHeight(self.frame) * 0.15, 30, 30)];
        self.heartImage.image = [UIImage imageNamed:@"titleLogo"];
        [self addSubview:self.heartImage];
        
        self.navLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.1, CGRectGetHeight(self.frame) * 0.21, CGRectGetWidth(self.frame) * 0.8, 1)];
        self.navLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.navLine];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.2, CGRectGetHeight(self.frame) * 0.25, CGRectGetWidth(self.frame) * 0.6, CGRectGetHeight(self.frame) * 0.045)];
        self.titleLabel.text = titleString;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:21];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

- (void) setNavBarButton {
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.11, CGRectGetHeight(self.frame) * 0.12, CGRectGetWidth(self.frame) * 0.11, CGRectGetWidth(self.frame) * 0.11)];
    [self configureBtn:self.backButton imageName:@"back" tag:100];
    [self addSubview:self.backButton];
    
    self.homebutton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.8, CGRectGetHeight(self.frame) * 0.12, CGRectGetWidth(self.frame) * 0.11, CGRectGetWidth(self.frame) * 0.11)];
    [self configureBtn:self.homebutton imageName:@"Home" tag:101];
    [self addSubview:self.homebutton];

}

-(void) configureBtn:(UIButton*)button imageName:(NSString*)name tag:(NSInteger)tag{
    button.tag = tag;
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
}

- (void) buttonAction:(UIButton*) button {
    [self.delegate buttonTrigger:self button:button];
}


- (void) setScrollViewWithArray:(NSMutableArray*) imageArray {
    
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.89, CGRectGetHeight(self.frame) * 0.5, CGRectGetWidth(self.frame) * 0.04, CGRectGetWidth(self.frame) * 0.07)];
    [self configureBtn:self.nextButton imageName:@"button_arrow_next" tag:10];
    [self addSubview:self.nextButton];

    self.prevButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.04, CGRectGetHeight(self.frame) * 0.5, CGRectGetWidth(self.frame) * 0.04, CGRectGetWidth(self.frame) * 0.07)];
    [self configureBtn:self.prevButton imageName:@"button_arrow_prev" tag:11];
    [self addSubview:self.prevButton];
    
    
    self.baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.2, CGRectGetHeight(self.frame) * 0.32, CGRectGetWidth(self.frame) * 0.6, CGRectGetHeight(self.frame) * 0.41)];
    self.baseScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.baseScrollView];

    for (int i = 0 ; i < imageArray.count; i ++) {
        CGRect frame;
        frame.origin.x = self.baseScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = CGSizeMake(self.baseScrollView.frame.size.width, CGRectGetHeight(self.baseScrollView.frame));
        
        UIImageView *infoImage = [[UIImageView alloc] initWithFrame:frame];
//        NSLog(@"%@", imageArray[i]);
        infoImage.image = [UIImage imageWithData:imageArray[i]];
//        infoImage.image = [UIImage imageNamed:imageArray[i]];
        infoImage.tag = i;
        [self.baseScrollView addSubview:infoImage];
    }
    self.basePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.baseScrollView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) *0.02 )];
    self.basePageControl.backgroundColor = [UIColor clearColor];
    [self addSubview:self.basePageControl];
    
    [self.baseScrollView setPagingEnabled:YES];
    self.baseScrollView.contentSize = CGSizeMake(self.baseScrollView.frame.size.width * imageArray.count, self.baseScrollView.frame.size.height);
    [self.basePageControl setNumberOfPages:imageArray.count];
}

- (void) showBaseTableView{
    self.baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) * 0.12, CGRectGetHeight(self.frame) * 0.4, CGRectGetWidth(self.frame) * 0.78, CGRectGetHeight(self.frame) * 0.35)];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.baseTableView];
}



@end
