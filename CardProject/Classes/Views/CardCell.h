//
//  CardCell.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardData.h"

@protocol cardValueDelegate;

@interface CardCell : UITableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type;
@property (nonatomic, strong) UIImageView *cardImage;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *cutButton;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *cardLabel;
@property (nonatomic, strong) UILabel *costLabel;
@property (nonatomic, weak) id<cardValueDelegate> delegate;
@property (nonatomic, strong, setter=setData:) CardData *cardData;

@end

@protocol cardValueDelegate <NSObject>

@required
- (void) card:(CardCell*)cardcell didSelectAtTag:(NSInteger)tag value:(NSInteger)value;

@end
