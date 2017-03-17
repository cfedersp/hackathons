//
//  CQAppDelegate.m
//  cliq
//
//  Created by Chenchen Zheng on 11/7/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQAppDelegate.h"

#import "CQSplashViewController.h"

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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    [Parse setApplicationId:@"nc3nC6OhDI4M7UHHRaFAn6rNqz3s4FimO9zYbX9D"
                  clientKey:@"Oyc0ZtD0WsJgwgMPd2dqQmN2Oz64Rkt9eVikKUmS"];
    

    
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  CQSplashViewController *splash = [[CQSplashViewController alloc] init];
  [self.window setRootViewController:splash];
  
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

@end
