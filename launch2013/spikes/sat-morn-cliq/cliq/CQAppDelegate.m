//
//  CQAppDelegate.m
//  cliq
//
//  Created by Chenchen Zheng on 11/7/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQAppDelegate.h"

#import "CQLogInViewController.h"
#import "CQHomeViewController.h"

@implementation CQAppDelegate


// FBSample logic
// In the login workflow, the Facebook native application, or Safari will transition back to
// this applicaiton via a url following the scheme fb[app id]://; the call to handleOpenURL
// below captures the token, in the case of success, on behalf of the FBSession object
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [FBAppEvents activateApp];
  [FBAppCall handleDidBecomeActive];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [PFPush storeDeviceToken:deviceToken];
    
    // Get the users Push Channel from their profile
    
    //There seems to be 2 ways to subscribe to a channel - thru PFInstallation or thru PFPush
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:@"channelNameFromProfile" forKey:@"channels"];
    [currentInstallation saveInBackground];
    
    [PFPush subscribeToChannelInBackground:@"channelNameFromProfile"];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog("Failed to register for push notifications,%@", error);
}
- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //look at notification - get creator id from notification
    
    //get creator profile from parse
    
    //get event document from FireBase
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound]
  //parse setup
  //
  [Parse setApplicationId:@"rrr0JGKX7WQRjoBo59n5Uzc4Q2NDK1l6ep2hFCZv"
                clientKey:@"S3awvBgDB97QIBP0E4unvLALjkKOZgDpsuEcZvG8"];
  [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
  
  
  [self setAppTheme];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  
  // See if the app has a valid token for the current state.
  if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
    // To-do, show logged in view
    [self showHomeView];
  } else {
    // No, display the login page.
    [self showLoginView];
  }
  
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

// FBSample logic
// It is important to close any FBSession object that is no longer useful
- (void)applicationWillTerminate:(UIApplication *)application {
  // Close the session before quitting
  // this is a good idea because things may be hanging off the session, that need
  // releasing (completion block, etc.) and other components in the app may be awaiting
  // close notification in order to do cleanup
  [FBSession.activeSession close];
}
//First time login -> set rootview as login, at login page if successful show homeview else keep it going

- (void)showLoginView
{
  CQLogInViewController *login = [[CQLogInViewController alloc] init];
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:login];
  [self.window setRootViewController:navi];
}

- (void)showHomeView
{
  CQHomeViewController *home = [[CQHomeViewController alloc] init];
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:home];
  [self.window setRootViewController:navi];
}

- (void) setAppTheme
{
  //  UIColor *naviColor = [UIColor colorWithRed:24.0/256.0 green:176.0/256.0 blue:115.0/256.0 alpha:0.95];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  //ios 7 way
  NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                         fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:42/1.9], NSFontAttributeName,
                              [UIColor whiteColor], NSForegroundColorAttributeName, nil];

//  [[UILabel appearance] setFont:[UIFont fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:14]];
//  [[UILabel appearance] setAttributedText:attributes];
  [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
  
  [[UINavigationBar appearance] setTitleTextAttributes:attributes];
  //  HelveticaNeue-Light
}

- (UIImage *)imageWithColor:(UIColor *)color
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

@end
