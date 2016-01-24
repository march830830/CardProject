//
//  MainView.h
//  CardProject
//
//  Created by 陳泓諺 on 2015/12/3.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"



@interface MainView : BaseView

@property (nonatomic, strong) UIView *bottomLine;

- (instancetype) initWithFrame:(CGRect)frame ImageArray:(NSMutableArray*) imageArray;


@end
