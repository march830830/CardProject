//
//  CalculateView.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/21.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface CalculateView : BaseView

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UITextField *totalField;
@property (nonatomic, strong) UIButton *calButton;


@end
