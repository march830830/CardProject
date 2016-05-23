//
//  SelectView.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface SelectView : BaseView


- (instancetype) initWithFrame:(CGRect)frame CardDic:(NSMutableDictionary*)cardDic;

@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (strong, nonatomic) CIImage *orignalImage;
@property (strong, nonatomic) UIImage *filterImage;
@property (strong, nonatomic) UIImageView *filterImageView;
@property (strong, nonatomic) UIScrollView *scrollView;


@end
