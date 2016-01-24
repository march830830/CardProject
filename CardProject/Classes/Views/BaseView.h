//
//  BaseView.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/20.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonDelegate <NSObject>

@optional

- (void) buttonTrigger:(id)trigger button:(UIButton*)button ;
- (void) buttonTrigger:(id)trigger button:(UIButton*)button buttons:(NSMutableArray*)buttons;

@end

@interface BaseView : UIView

- (instancetype) initWithFrame:(CGRect)frame titleString:(NSString*) titleString;

@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UIImageView *sloganImage;
@property (nonatomic, strong) UIImageView *heartImage;
@property (nonatomic, strong) UIView *navLine;
@property (nonatomic, weak) id<ButtonDelegate> delegate;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *homebutton;
- (void) setNavBarButton;

@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) UIPageControl *basePageControl;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *prevButton;
- (void) setScrollViewWithArray:(NSMutableArray*) imageArray;
@property (nonatomic, strong) UITableView *baseTableView;
- (void) showBaseTableView;

@end


