//
//  CQAppDelegate.m
//  activity
//
//  Created by Chenchen Zheng on 11/8/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQAppDelegate.h"

#import "CQActivitiesViewController.h"

@implementation CQAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //parse setup
  //
  [Parse setApplicationId:@"rrr0JGKX7WQRjoBo59n5Uzc4Q2NDK1l6ep2hFCZv"
                clientKey:@"S3awvBgDB97QIBP0E4unvLALjkKOZgDpsuEcZvG8"];
  [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
  
  [self setAppTheme];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
  CQActivitiesViewController *activities = [[CQActivitiesViewController alloc] init];
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:activities];
  [self.window setRootViewController:navi];
  
//  UITabBarController *tabbar = [UITabBarController alloc] initwith
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

- (void) setAppTheme
{
//  UIColor *naviColor = [UIColor colorWithRed:24.0/256.0 green:176.0/256.0 blue:115.0/256.0 alpha:0.95];
//  [[UINavigationBar appearance] setTintColor:naviColor];
//ios 7 way
  
  NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                         fontWithName:@"HelveticaNeue-Light" size:42/1.9], NSFontAttributeName,
                              [UIColor whiteColor], NSForegroundColorAttributeName, nil];
  
  [[UINavigationBar appearance] setTitleTextAttributes:attributes];  
//  HelveticaNeue-Light
}
@end
