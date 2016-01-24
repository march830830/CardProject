//
//  UIImage+Extends.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/21.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "UIImage+Extends.h"

@implementation UIImage (Extends)


+ (UIImage*) fitImage:(NSString *)imageName size:(CGSize)newSize {
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imageName ofType:nil]];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1.5);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
