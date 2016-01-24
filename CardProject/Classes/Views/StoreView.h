//
//  StoreView.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/21.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface StoreView : BaseView

@property (nonatomic, strong) UILabel *storeLabel;
@property (nonatomic, strong) UIButton *confirmButton;

- (instancetype) initWithFrame:(CGRect)frame ImageArray:(NSMutableArray*) imageArray;

@end
