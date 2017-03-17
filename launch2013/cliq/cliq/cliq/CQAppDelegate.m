//
//  CQAppDelegate.m
//  cliq
//
//  Created by Chenchen Zheng on 11/7/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQAppDelegate.h"
#import "CQLogInViewController.h"
#import "CQProfileViewController.h"
#import "CQActivityViewController.h"
#import "CQFriendListViewController.h"
#import "CQCliqsViewController.h"
#import "CQSettingsViewController.h"


@implementation CQAppDelegate


// ****************************************************************************
// App switching methods to support Facebook Single Sign-On.
// ****************************************************************************
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  return [PFFacebookUtils handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [FBAppEvents activateApp];
  [FBSession.activeSession handleDidBecomeActive];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
  NSLog(@"called");
  // Store the deviceToken in the current installation and save it to Parse.
  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
  [currentInstallation setDeviceTokenFromData:newDeviceToken];
//  [currentInstallation addUniqueObject:@"Cliq" forKey:@"channels"];
  NSString *fbid = [[NSUserDefaults standardUserDefaults] objectForKey:@"myFBID"];
  NSLog(@"fbid is %@",fbid);
  if (fbid != nil) {
    [currentInstallation addUniqueObject:fbid forKey: @"channels"];
  }
  [currentInstallation saveInBackground];
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
  [PFPush handlePush:userInfo];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  //parse setup
  //
  [Parse setApplicationId:@"rrr0JGKX7WQRjoBo59n5Uzc4Q2NDK1l6ep2hFCZv"
                clientKey:@"S3awvBgDB97QIBP0E4unvLALjkKOZgDpsuEcZvG8"];
  [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
  
  // Register for push notifications
  [application registerForRemoteNotificationTypes:
   UIRemoteNotificationTypeBadge |
   UIRemoteNotificationTypeAlert |
   UIRemoteNotificationTypeSound];
  
  [PFFacebookUtils initializeFacebook];

  [self setAppTheme];
  
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  
  // See if the app has a valid token for the current state.
  if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {    // To-do, show logged in view
    [self createTabBar];
  } else {
    // No, display the login page.
    [self showLoginView];
  }
  
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
  [FBSession.activeSession close];
}

//First time login -> set rootview as login, at login page if successful show homeview else keep it going

- (void)showLoginView
{
  CQLogInViewController *login = [[CQLogInViewController alloc] init];
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:login];
  navi.navigationBar.hidden = YES;
  [self.window setRootViewController:navi];
}

- (void)showHomeView
{
  CQProfileViewController *home = [[CQProfileViewController alloc] init];
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:home];
  [self.window setRootViewController:navi];
}

- (void) createTabBar
{
//  //  ccz: init Trabbar controller with height of 50, thinking not to display tab bar text
  CQActivityViewController *activity = [[CQActivityViewController alloc] init];
  UINavigationController *naviAct = [[UINavigationController alloc] initWithRootViewController:activity];
  [naviAct setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"activity"
                                                       image:[UIImage imageNamed:@"activityicon"]
                                               selectedImage:[UIImage imageNamed:@"activityselected"]]];


  CQFriendListViewController *friendList = [[CQFriendListViewController alloc] initWithNibName:@"CQFriendListViewController" bundle:nil];
  UINavigationController *naviFL = [[UINavigationController alloc] initWithRootViewController:friendList];
  [naviFL setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"people"
                                                      image:[UIImage imageNamed:@"peopleicon"]
                                              selectedImage:[UIImage imageNamed:@"peopleiconselected"]]];

//  CQPagerViewController *friendList = [[CQPagerViewController alloc] init];
//  UINavigationController *naviFL = [[UINavigationController alloc] initWithRootViewController:friendList];
//  [naviFL setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"People"
//                                                      image:[UIImage imageNamed:@"peopleicon"]
//                                              selectedImage:[UIImage imageNamed:@"peopleiconselected"]]];

  CQCliqsViewController *cliq = [[CQCliqsViewController alloc] initWithStyle:UITableViewStylePlain];
  UINavigationController *naviCQ = [[UINavigationController alloc] initWithRootViewController:cliq];
  [naviCQ setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"cliqs"
                                                      image:[UIImage imageNamed:@"cliqsicon"]
                                                      tag:2]];

  CQSettingsViewController *settings = [[CQSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
  UINavigationController *naviSettings = [[UINavigationController alloc] initWithRootViewController:settings];
  [naviSettings setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"settings"
                                                           image:[UIImage imageNamed:@"settingsicon"]
                                                    selectedImage:[UIImage imageNamed:@"settingsselected"]]];
  NSArray *vcs = [NSArray arrayWithObjects:naviAct, naviFL, naviCQ, naviSettings, nil];
  UITabBarController *tabbar = [[UITabBarController alloc] init];
  [tabbar setViewControllers:vcs animated:YES];
  [self.window setRootViewController:tabbar];

}


- (void) setAppTheme
{
  //  UIColor *naviColor = [UIColor colorWithRed:24.0/256.0 green:176.0/256.0 blue:115.0/256.0 alpha:0.95];
  [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  //ios 7 way
  NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                         fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:15], NSFontAttributeName,
                              [UIColor whiteColor], NSForegroundColorAttributeName, nil];

//  [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
  [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
  [[UINavigationBar appearance] setTitleTextAttributes:attributes];
//  [[UINavigationBar appearance] setTranslucent:YES];
//  bar.translucent = NO;
  NSDictionary *attributesNormal = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                         fontWithName:@"SACKERSGOTHICSTD-HEAVY" size:9], NSFontAttributeName,
                              [UIColor colorWithRed:128/256.0 green:130/256.0 blue:133/256.0 alpha:1.0], NSForegroundColorAttributeName, nil];
  NSDictionary *attributesHighlighted = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                                    fontWithName:@"SACKERSGOTHICSTD-HEAVY" size:9], NSFontAttributeName,
                                         [UIColor colorWithRed:0/256.0 green:166/256.0 blue:81/256.0 alpha:1.0], NSForegroundColorAttributeName, nil];
  [[UITabBarItem appearance] setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
  [[UITabBarItem appearance] setTitleTextAttributes:attributesHighlighted forState:UIControlStateSelected];
//  [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:0/256.0 green:166/256.0 blue:81/256.0 alpha:1.0]];
  [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0/256.0 green:166/256.0 blue:81/256.0 alpha:1.0]];
  //  HelveticaNeue-Light
}



@end
