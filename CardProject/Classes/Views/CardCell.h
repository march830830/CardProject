//
//  CardCell.h
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UITableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSInteger)type;
@property (nonatomic, strong) UIImageView *cardImage;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *cutButton;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *cardLabel;
@property (nonatomic, strong) UILabel *costLabel;

@end
