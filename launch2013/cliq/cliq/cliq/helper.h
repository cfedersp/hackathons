//
//  helper.h
//  cliq
//
//  Created by Chenchen Zheng on 11/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define CQGreenColor [UIColor colorWithRed:0/256.0 green:166/256.0 blue:81/256.0 alpha:1.0];


@interface helper : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIColor *) CQGreenColor;
+ (UIColor *) CQBackgroundColor;
+ (NSArray *)getFriendPictures;
+ (void) uploadImage2Parse:(NSData *)image;

@end
