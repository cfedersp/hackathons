//
//  helper.m
//  cliq
//
//  Created by Chenchen Zheng on 11/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "helper.h"

@implementation helper

+ (UIImage *)imageWithColor:(UIColor *)color
{
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

+ (UIColor *) CQGreenColor
{
  return [UIColor colorWithRed:0/256.0 green:166/256.0 blue:81/256.0 alpha:1.0];
}

+ (UIColor *) CQBackgroundColor
{
  return [UIColor colorWithRed:241/256.0 green:242/256.0 blue:242/256.0 alpha:1.0];
}

+ (void) uploadImage2Parse:(NSData *)image
{
  PFFile *imageFile = [PFFile fileWithName:@"profile_large.jpg" data:image];
  
  //HUD creation here (see example for code)
  
  // Save PFFile
  [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (!error) {
      // Hide old HUD, show completed HUD (see example for code)
      
      // Create a PFObject around a PFFile and associate it with the current user
      PFObject *userPhoto = [PFObject objectWithClassName:@"User"];
      [userPhoto setObject:imageFile forKey:@"profile_large"];
      
      // Set the access control list to current user for security purposes
      userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
      
      PFUser *user = [PFUser currentUser];
      [userPhoto setObject:user forKey:@"user"];
      
      [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
          [SVProgressHUD showWithStatus:@"Loading"];
        }
        else{
          // Log details of the failure
          NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
      }];
    }
    else{
      [SVProgressHUD dismiss];
      // Log details of the failure
      NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
  } progressBlock:^(int percentDone) {
    // Update your progress spinner here. percentDone will be between 0 and 100.
    [SVProgressHUD dismiss];
  }];
}

@end
