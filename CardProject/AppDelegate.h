//
//  AppDelegate.h
//  CardProject
//
//  Created by 陳泓諺 on 2015/11/21.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  MainController;
@class NavController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainController *mainController;
@property (nonatomic, strong) NavController *navController;


@end

